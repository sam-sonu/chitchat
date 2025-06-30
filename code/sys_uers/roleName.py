import csv
import os
import mysql.connector
import requests
from typing import List, Dict, Tuple
from mysql.connector import Error
from datetime import datetime

# Configuration
DB_CONFIG = {
    'host': '107.109.40.131:3306',
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

API_URL = "https://sridconnect.sec.samsung.net/api/Anonymous/GetEmployeeDetails"
OUTPUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "outputRole")
DB_TSV_FILE = os.path.join(OUTPUT_DIR, "sys_users.tsv")
API_TSV_FILE = os.path.join(OUTPUT_DIR, "api_users.tsv")
FILTERED_API_FILE = os.path.join(OUTPUT_DIR, "filtered_api_users.tsv")
PARTNER_FILE = os.path.join(OUTPUT_DIR, "partner_users.tsv")
ROLE_FILE = os.path.join(OUTPUT_DIR, "role_data.tsv")
LOG_FILE = os.path.join(OUTPUT_DIR, "data_export.log")

def ensure_output_directory():
    """Create output directory if it doesn't exist"""
    os.makedirs(OUTPUT_DIR, exist_ok=True)

def log_message(message: str, log_file: str = LOG_FILE) -> None:
    """Log messages with timestamp"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    formatted_message = f"[{timestamp}] {message}"
    # print(formatted_message)
    if log_file:
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(f"{formatted_message}\n")

def fetch_sys_users() -> List[Dict]:
    """Fetch sys_user data from MySQL database"""
    try:
        host_parts = DB_CONFIG['host'].split(':')
        host = host_parts[0]
        port = int(host_parts[1])
        
        connection = mysql.connector.connect(
            host=host,
            port=port,
            database=DB_CONFIG['database'],
            user=DB_CONFIG['user'],
            password=DB_CONFIG['password']
        )
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM sys_user")
        rows = cursor.fetchall()
        log_message(f"Fetched {len(rows)} records from sys_user table")
        return rows
        
    except Error as e:
        log_message(f"Database error: {e}")
        raise
    finally:
        if 'connection' in locals() and connection.is_connected():
            cursor.close()
            connection.close()
            log_message("MySQL connection closed")

def fetch_api_data() -> List[Dict]:
    """Fetch data from API"""
    try:
        response = requests.post(API_URL, json={}, timeout=30)
        response.raise_for_status()
        data = response.json()
        log_message(f"Fetched {len(data)} records from API")
        return data
    except requests.exceptions.RequestException as e:
        log_message(f"API request failed: {e}")
        raise

def save_to_tsv(data: List[Dict], filename: str) -> bool:
    """Save data to TSV file"""
    try:
        if not data:
            log_message(f"No data to save for {filename}")
            return False
            
        with open(filename, 'w', newline='', encoding='utf-8') as tsvfile:
            writer = csv.DictWriter(tsvfile, fieldnames=data[0].keys(), delimiter='\t')
            writer.writeheader()
            writer.writerows(data)
        
        log_message(f"Successfully saved {len(data)} records to {filename}")
        return True
        
    except Exception as e:
        log_message(f"Error saving TSV file {filename}: {e}")
        return False

def process_emp_data(emp_data: List[Dict]) -> Tuple[List[Dict], List[Dict]]:
    """
    Process emp_api data:
    1. Remove @samsung.com from knox IDs
    2. Filter out partner users (@partner.samsung.com)
    
    Args:
        emp_data: List of employee dictionaries containing knox field
        
    Returns:
        Tuple of (processed_emp_data, removed_partner_users)
    """
    processed_data = []
    partner_users = []
    
    for emp in emp_data:
        # Make sure we have a knox field to process
        if not emp.get('knox'):
            processed_data.append(emp)
            continue
            
        knox = emp['knox'].lower().strip()
        
        # Check for partner users
        if '@partner.samsung.com' in knox:
            partner_users.append(emp)
            continue
        
        # Remove @samsung.com if present
        if '@samsung.com' in knox:
            emp['knox'] = knox.split('@')[0]
        
        processed_data.append(emp)
    
    return processed_data, partner_users

def process_role_data(api_data: List[Dict]) -> List[Dict]:
    """
    Process role names from API data:
    1. Format role names consistently
    2. Count role occurrences
    3. Return processed data with formatted roles
    
    Args:
        api_data: List of employee dictionaries containing roleName
        
    Returns:
        List of dictionaries with employeeId and formattedRole
    """
    filtered_api_data = []
    role_counts = {}
    total_roles = 0
    
    log_message(f"Starting role processing for {len(api_data)} records")
    
    for row in api_data:
        try:
            # Process role name
            original_role = row.get('roleName', 'engg')  # Default to 'engg' if not present
            if original_role is None or str(original_role).strip() == '':
                original_role = 'engg'
                
            role = str(original_role).lower().replace(' ', '').replace('@partner', '')
            formatted_role = f"user.role.{role}"
            
            # Count role occurrences
            role_counts[formatted_role] = role_counts.get(formatted_role, 0) + 1
            total_roles += 1
            
            # Log the transformation
            log_message(f"Employee {row.get('employeeId', 'UNKNOWN')}: '{original_role}' -> '{formatted_role}'")
            
            # Store the processed data
            filtered_api_data.append({
                'employeeId': row.get('employeeId'),
                'formattedRole': formatted_role
            })
            
        except Exception as e:
            log_message(f"Error processing employee {row.get('employeeId', 'UNKNOWN')}: {str(e)}")
            continue
    
    # Log summary statistics
    log_message(f"Total roles processed: {total_roles}")
    log_message("Role distribution:")
    for role, count in role_counts.items():
        log_message(f"{role}: {count}")
    
    return filtered_api_data

def validate_roles(role_file: str = ROLE_FILE, sys_users_file: str = DB_TSV_FILE) -> Dict:
    """
    Validate and compare roles between role_data and sys_users files.
    
    Args:
        role_file: Path to role_data TSV file
        sys_users_file: Path to sys_users TSV file
        
    Returns:
        Dictionary with validation results:
        {
            'total_checked': int,
            'matching_roles': int,
            'mismatched_roles': int,
            'missing_in_sys_users': int,
            'missing_in_role_data': int,
            'mismatches': List[Dict]  # Details of mismatched roles
        }
    """
    def read_tsv(file_path: str) -> List[Dict]:
        """Helper function to read TSV files"""
        with open(file_path, 'r', encoding='utf-8') as f:
            return list(csv.DictReader(f, delimiter='\t'))
    
    try:
        # Read both files
        role_data = read_tsv(role_file)
        sys_users = read_tsv(sys_users_file)
        
        # Create lookup dictionaries
        role_lookup = {row['employeeId']: row['formattedRole'] for row in role_data}
        sys_users_lookup = {row['emp_no']: row['role_cd'] for row in sys_users}
        
        # Initialize counters
        results = {
            'total_checked': 0,
            'matching_roles': 0,
            'mismatched_roles': 0,
            'missing_in_sys_users': 0,
            'missing_in_role_data': 0,
            'mismatches': []
        }
        
        # Check all employees in role_data against sys_users
        for emp_id, formatted_role in role_lookup.items():
            results['total_checked'] += 1
            
            if emp_id not in sys_users_lookup:
                results['missing_in_sys_users'] += 1
                results['mismatches'].append({
                    'employeeId': emp_id,
                    'role_data_role': formatted_role,
                    'sys_users_role': 'MISSING',
                    'status': 'Missing in sys_users'
                })
                continue
            
            sys_role = sys_users_lookup[emp_id]
            if sys_role == formatted_role:
                results['matching_roles'] += 1
            else:
                results['mismatched_roles'] += 1
                results['mismatches'].append({
                    'employeeId': emp_id,
                    'role_data_role': formatted_role,
                    'sys_users_role': sys_role,
                    'status': 'Mismatch'
                })
        
        # Check for employees in sys_users but missing in role_data
        for emp_id in sys_users_lookup:
            if emp_id not in role_lookup:
                results['missing_in_role_data'] += 1
                results['mismatches'].append({
                    'employeeId': emp_id,
                    'role_data_role': 'MISSING',
                    'sys_users_role': sys_users_lookup[emp_id],
                    'status': 'Missing in role_data'
                })
        
        # Log results
        log_message("\nRole Validation Results:")
        log_message(f"Total employees checked: {results['total_checked']}")
        log_message(f"Matching roles: {results['matching_roles']}")
        log_message(f"Mismatched roles: {results['mismatched_roles']}")
        log_message(f"Employees missing in sys_users: {results['missing_in_sys_users']}")
        log_message(f"Employees missing in role_data: {results['missing_in_role_data']}")
        
        # Save detailed mismatches to file
        mismatch_file = os.path.join(OUTPUT_DIR, "role_mismatches.tsv")
        if results['mismatches']:
            with open(mismatch_file, 'w', newline='', encoding='utf-8') as f:
                writer = csv.DictWriter(f, 
                                      fieldnames=['employeeId', 'role_data_role', 'sys_users_role', 'status'],
                                      delimiter='\t')
                writer.writeheader()
                writer.writerows(results['mismatches'])
            log_message(f"Saved detailed mismatches to {mismatch_file}")
        
        return results
        
    except Exception as e:
        log_message(f"Error during role validation: {e}")
        raise


def main():
    """Main execution function"""
    ensure_output_directory()
    log_message("Starting data export process")
    
    try:
        # Step 1: Fetch and save database data
        db_data = fetch_sys_users()
        if db_data and not save_to_tsv(db_data, DB_TSV_FILE):
            log_message("Failed to save database data")
        
        # Step 2: Fetch API data
        api_data = fetch_api_data()
        if api_data:
            # Step 3: Process role data
            role_data = process_role_data(api_data)
            if role_data and not save_to_tsv(role_data, ROLE_FILE):
                log_message("Failed to save role data")
            
            # Step 4: Filter API data
            filtered_api_data, partner_data = process_emp_data(api_data)
            
            # Step 5: Save filtered API data
            if filtered_api_data and not save_to_tsv(filtered_api_data, FILTERED_API_FILE):
                log_message("Failed to save filtered API data")
            
            # Step 6: Save partner data separately
            if partner_data and not save_to_tsv(partner_data, PARTNER_FILE):
                log_message("Failed to save partner data")
            
            # Step 7: Save original API data
            if not save_to_tsv(api_data, API_TSV_FILE):
                log_message("Failed to save original API data")
            
            # Step 8: Validate roles between role_data and sys_users
            validate_roles()
        
        log_message("Process completed successfully")
        
    except Exception as e:
        log_message(f"Process failed: {e}")
        raise

if __name__ == "__main__":
    main()