import mysql.connector
from mysql.connector import Error
import requests
import csv
import os
from typing import List, Dict, Set, Tuple
from datetime import datetime

# Configuration
DB_CONFIG = {
    'host': '107.109.40.131:3306',
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

API_URL = "https://sridconnect.sec.samsung.net/api/Anonymous/GetEmployeeDetails"
OUTPUT_DIR = "sys_uers"
LOG_FILE = "execution_log.txt"

def log_message(message: str, log_file: str = None) -> None:
    """Log messages to both console and log file"""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    formatted_message = f"[{timestamp}] {message}"
    
    # Print to console
    print(formatted_message)
    
    # Write to log file
    if log_file:
        with open(log_file, 'a', encoding='utf-8') as f:
            f.write(formatted_message + '\n')

def format_role_name(raw_role):
    """
    Format role name to follow user.role.* pattern.
    Converts to lowercase and removes spaces/special characters.
    
    Args:
        raw_role (str): Raw role name from TSV
        
    Returns:
        str: Formatted role name (e.g. "Group Head" → "user.role.grouphead")
    """
    if not raw_role or not raw_role.strip():
        return 'user.role.engg'  # Default role
    
    # Convert to lowercase and remove all spaces and special characters
    formatted = ''.join(c.lower() for c in raw_role if c.isalnum())
    
    return f"user.role.{formatted}"

def generate_insert_statement(employee_id, employee_name, knox, team_name, role_name):
    """
    Generate SQL INSERT statement for employee data using MySQL's getHashPassword.
    
    Args:
        employee_id (str): Employee ID number (used as password)
        employee_name (str): Employee full name
        knox (str): Knox identifier (used directly for knox_id and code)
        team_name (str): Employee team name
        role_name (str): Employee role name (will be formatted)
        
    Returns:
        tuple: (sql_statement, parameters)
    """
    formatted_role = format_role_name(role_name)
    
    # Prepare values for all columns
    values = {
        'title': employee_name,    # Employee full name
        'code': knox,             # Knox identifier
        'emp_no': employee_id,    # Employee ID number
        'knox_id': knox,          # Knox identifier
        'password': employee_id,  # Raw password for MySQL function
        'pid': 0,
        'parent_id': 0,
        'admin_yn': 'N',
        'sno': 0,
        'status_cd': 'sysuser.new',
        'obj_cd': 'sysuser',
        'del_yn': 'N',
        'modifier_id': 0,
        'modify_dt': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'creator_id': 61,
        'create_dt': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
        'gender': '',            
        'role_cd': formatted_role,
        'download_permission_yn': 'N',
        'user_type': 'SRI-D'
    }
    
    # Generate column names
    columns = ', '.join(values.keys())
    
    # Generate placeholders with getHashPassword for the password field
    placeholders = ', '.join(['%s'] * len(values))
    columns_list = columns.split(', ')
    password_index = columns_list.index('password')
    placeholders_list = placeholders.split(', ')
    placeholders_list[password_index] = 'getHashPassword(%s)'
    sql_placeholders = ', '.join(placeholders_list)
    
    # SQL statement
    sql = f"""
    INSERT INTO sys_user({columns})
    VALUES ({sql_placeholders})
    """
    
    # Prepare parameters
    params = tuple(values.values())
    
    return sql, params

def process_tsv_file(file_path, log_file):
    """Process TSV file and generate SQL statements"""
    connection = None
    cursor = None
    
    try:
        # Split host and port
        host_parts = DB_CONFIG['host'].split(':')
        host = host_parts[0]
        port = int(host_parts[1])
        
        # Establish connection
        connection = mysql.connector.connect(
            host=host,
            port=port,
            database=DB_CONFIG['database'],
            user=DB_CONFIG['user'],
            password=DB_CONFIG['password']
        )
        
        cursor = connection.cursor()
        
        with open(file_path, 'r', encoding='utf-8') as f:
            reader = csv.reader(f, delimiter='\t')
            next(reader)  # Skip header
            
            for row in reader:
                if len(row) >= 17:  # Updated for new format
                    employee_id = row[0].strip()
                    employee_name = row[1].strip()
                    knox = row[2].strip()
                    team_name = row[3].strip()
                    role_name = row[16].strip() if len(row) > 16 else ''
                    
                    if employee_id and employee_name and knox:
                        sql, params = generate_insert_statement(
                            employee_id, employee_name, knox, team_name, role_name
                        )
                        log_message("Executing SQL:", log_file)
                        log_message(sql, log_file)
                        log_message("With parameters:", log_file)
                        log_message(str(params), log_file)
                        
                        cursor.execute(sql, params)
                        connection.commit()
                        log_message("Successfully inserted record\n---\n", log_file)
    
    except mysql.connector.Error as error:
        log_message(f"Database error: {error}", log_file)
    
    finally:
        if cursor:
            cursor.close()
        if connection and connection.is_connected():
            connection.close()
            log_message("MySQL connection closed.", log_file)

def fetch_from_database(log_file: str = None) -> List[Dict]:
    """Fetch user data from MySQL database"""
    try:
        # Split host and port
        host_parts = DB_CONFIG['host'].split(':')
        host = host_parts[0]
        port = int(host_parts[1])
        
        # Establish connection
        connection = mysql.connector.connect(
            host=host,
            port=port,
            database=DB_CONFIG['database'],
            user=DB_CONFIG['user'],
            password=DB_CONFIG['password']
        )
        
        cursor = connection.cursor(dictionary=True)  # Use dictionary cursor
        cursor.execute("SELECT * FROM sys_user")
        
        # Fetch all rows as dictionaries
        rows = cursor.fetchall()
        return rows
        
    except Error as e:
        log_message(f"Database error: {e}", log_file)
        raise
        
    finally:
        if 'connection' in locals() and connection.is_connected():
            cursor.close()
            connection.close()
            log_message("MySQL connection is closed", log_file)

def fetch_from_api(log_file: str = None) -> List[Dict]:
    """Fetch employee details from API"""
    try:
        response = requests.post(API_URL, json={})
        response.raise_for_status()
        return response.json()
        
    except requests.exceptions.RequestException as e:
        log_message(f"Error fetching employee details: {e}", log_file)
        raise

def save_to_tsv(data: List[Dict], filename: str, log_file: str = None) -> None:
    """Save data to a TSV file"""
    if not data:
        log_message(f"No data to save for {filename}", log_file)
        return
        
    # Create directory if it doesn't exist
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    
    # Get headers from the first dictionary's keys
    fieldnames = list(data[0].keys())
    
    with open(filename, 'w', newline='', encoding='utf-8') as tsvfile:
        writer = csv.DictWriter(tsvfile, fieldnames=fieldnames, delimiter='\t')
        writer.writeheader()
        writer.writerows(data)
    log_message(f"Data successfully saved to {filename}", log_file)

def process_emp_api_data(emp_data: List[Dict], log_file: str = None) -> Tuple[List[Dict], List[Dict]]:
    """
    Process emp_api data:
    1. Remove @samsung.com from knox IDs
    2. Filter out partner users (@partner.samsung.com)
    Returns:
        - Tuple of (processed_emp_data, removed_partner_users)
    """
    processed_data = []
    partner_users = []
    
    for emp in emp_data:
        # Process knox field
        if 'knox' in emp and emp['knox']:
            knox = emp['knox'].lower()
            
            # Check for partner users
            if '@partner.samsung.com' in knox:
                partner_users.append(emp)
                continue
            
            # Remove @samsung.com if present
            if '@samsung.com' in knox:
                emp['knox'] = knox.split('@')[0]
        
        processed_data.append(emp)
    
    return processed_data, partner_users

def compare_employees(emp_api_data: List[Dict], sys_user_data: List[Dict], log_file: str = None) -> Dict:
    """
    Compare employee data between emp_api and sys_users.
    Returns dictionary with:
    - new_employees: in emp_api but not in sys_users
    - common_employees: in both
    - exited_employees: in sys_users but not in emp_api
    """
    # Create sets for comparison using correct fields
    emp_api_ids = {emp['employeeId'] for emp in emp_api_data}
    sys_user_emp_nos = {user['emp_no'] for user in sys_user_data}
    
    # Find new employees (in emp_api but not in sys_users)
    new_employee_ids = emp_api_ids - sys_user_emp_nos
    new_employees = [emp for emp in emp_api_data if emp['employeeId'] in new_employee_ids]
    
    # Find common employees
    common_employee_ids = emp_api_ids & sys_user_emp_nos
    common_employees = [emp for emp in emp_api_data if emp['employeeId'] in common_employee_ids]
    
    # Find exited employees (in sys_users but not in emp_api)
    exited_employee_nos = sys_user_emp_nos - emp_api_ids
    exited_employees = [user for user in sys_user_data if user['emp_no'] in exited_employee_nos]
    
    return {
        'new_employees': new_employees,
        'common_employees': common_employees,
        'exited_employees': exited_employees
    }

def check_employee_existence(emp_ids: List[str], log_file: str = None) -> Dict[str, bool]:
    """
    Check if employees exist in the database
    Returns dictionary with employee_id as key and existence status as value
    """
    results = {}
    try:
        # Split host and port
        host_parts = DB_CONFIG['host'].split(':')
        host = host_parts[0]
        port = int(host_parts[1])
        
        # Establish connection
        connection = mysql.connector.connect(
            host=host,
            port=port,
            database=DB_CONFIG['database'],
            user=DB_CONFIG['user'],
            password=DB_CONFIG['password']
        )
        
        cursor = connection.cursor(dictionary=True)
        
        for emp_id in emp_ids:
            query = "SELECT 1 FROM sys_user WHERE emp_no = %s"
            cursor.execute(query, (emp_id,))
            exists = cursor.fetchone() is not None
            results[emp_id] = exists
        
        return results
        
    except Error as e:
        log_message(f"Database error during existence check: {e}", log_file)
        raise
        
    finally:
        if 'connection' in locals() and connection.is_connected():
            cursor.close()
            connection.close()

def generate_reports(emp_api_data: List[Dict], sys_user_data: List[Dict], 
                    partner_users: List[Dict], output_dir: str, log_file: str = None) -> str:
    """Generate all required reports and return path to new_employees.tsv"""
    # Print initial counts
    log_message("\n=== INITIAL COUNTS ===", log_file)
    log_message(f"Total employees in emp_api (before processing): {len(emp_api_data) + len(partner_users)}", log_file)
    log_message(f"Total employees in sys_users: {len(sys_user_data)}", log_file)
    
    # Total employees in emp_api after removing partners
    total_emp_api = len(emp_api_data)
    
    # Comparison results
    comparison = compare_employees(emp_api_data, sys_user_data, log_file)
    
    # Create output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Save reports
    save_to_tsv(partner_users, os.path.join(output_dir, "removed_partner_users.tsv"), log_file)
    new_employees_path = os.path.join(output_dir, "new_employees.tsv")
    save_to_tsv(comparison['new_employees'], new_employees_path, log_file)
    save_to_tsv(comparison['common_employees'], os.path.join(output_dir, "common_employees.tsv"), log_file)
    save_to_tsv(comparison['exited_employees'], os.path.join(output_dir, "exited_employees.tsv"), log_file)
    
    # Print summary
    log_message("\n=== REPORT SUMMARY ===", log_file)
    log_message(f"Removed partner users: {len(partner_users)} (saved to removed_partner_users.tsv)", log_file)
    log_message(f"Remaining users after filtering: {total_emp_api}", log_file)
    log_message(f"New employees (not in sys_users): {len(comparison['new_employees'])} (saved to new_employees.tsv)", log_file)
    log_message(f"Common employees (in both files): {len(comparison['common_employees'])} (saved to common_employees.tsv)", log_file)
    log_message(f"Exited employees (in sys_users but not emp_api): {len(comparison['exited_employees'])} (saved to exited_employees.tsv)", log_file)

    # Check existence of new employees in database
    new_emp_ids = [emp['employeeId'] for emp in comparison['new_employees']]
    if new_emp_ids:
        log_message("\nChecking existence of new employees in database...", log_file)
        existence_results = check_employee_existence(new_emp_ids, log_file)
        
        # Create report for existence check
        existence_report = []
        for emp_id, exists in existence_results.items():
            existence_report.append({
                'employeeId': emp_id,
                'exists_in_db': 'Yes' if exists else 'No'
            })
        
        save_to_tsv(existence_report, os.path.join(output_dir, "existence_check_results.tsv"), log_file)
        log_message(f"Existence check results saved to existence_check_results.tsv", log_file)
    
    return new_employees_path

def process_frontend_input(input_data: Dict) -> None:
    """
    Process input from frontend and perform appropriate actions
    
    Args:
        input_data (Dict): Dictionary containing:
            - action: "fetch_and_compare" or "process_new_employees"
    """
    try:
        script_dir = os.path.dirname(os.path.abspath(__file__))
        output_dir = os.path.join(script_dir, OUTPUT_DIR)
        log_file_path = os.path.join(script_dir, LOG_FILE)
        
        # Initialize log file
        with open(log_file_path, 'w', encoding='utf-8') as f:
            f.write(f"Execution Log - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write("="*50 + "\n\n")
        
        if input_data['action'] == "fetch_and_compare":
            log_message("Fetching data from database...", log_file_path)
            db_data = fetch_from_database(log_file_path)
            db_output = os.path.join(output_dir, "sys_users.tsv")
            save_to_tsv(db_data, db_output, log_file_path)
            
            log_message("Fetching data from API...", log_file_path)
            api_data = fetch_from_api(log_file_path)
            api_output = os.path.join(output_dir, "emp_api.tsv")
            save_to_tsv(api_data, api_output, log_file_path)
            
            log_message("\nProcessing data and generating reports...", log_file_path)
            processed_emp_data, partner_users = process_emp_api_data(api_data, log_file_path)
            new_employees_path = generate_reports(processed_emp_data, db_data, partner_users, output_dir, log_file_path)
            
            # If the user wants to automatically process new employees after comparison
            if input_data.get('auto_process_new', False):
                log_message("\nAutomatically processing new employees...", log_file_path)
                process_tsv_file(new_employees_path, log_file_path)
            
        elif input_data['action'] == "process_new_employees":
            # Automatically use the generated new_employees.tsv file
            new_employees_path = os.path.join(output_dir, "new_employees.tsv")
            if not os.path.exists(new_employees_path):
                raise FileNotFoundError(f"new_employees.tsv not found at {new_employees_path}. Please run 'fetch_and_compare' first.")
            
            log_message(f"Processing new employees from {new_employees_path}", log_file_path)
            process_tsv_file(new_employees_path, log_file_path)
            
        else:
            raise ValueError(f"Unknown action: {input_data['action']}")
            
    except Exception as e:
        log_message(f"Failed to process data: {e}", log_file_path)
        raise

def main():
    # Example usage - replace with actual frontend input
    frontend_input = {
        'action': 'fetch_and_compare',
        'auto_process_new': True 
    }
    
    process_frontend_input(frontend_input)

if __name__ == "__main__":
    main()