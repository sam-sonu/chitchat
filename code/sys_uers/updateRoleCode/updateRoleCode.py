import mysql.connector
from typing import List, Dict
import csv

# Configuration
DB_CONFIG = {
    'host': '107.109.40.131:3306',
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

def fetch_from_database() -> List[Dict]:
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
        
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM sys_user")
        
        # Fetch all rows as dictionaries
        rows = cursor.fetchall()
        return rows
    except Exception as e:
        print(f"Error fetching data from database: {e}")
        return []

def read_role_data(file_path: str) -> Dict[str, str]:
    """Read role_data.tsv file and return a dictionary of employeeId to formattedRole"""
    role_data = {}
    try:
        with open(file_path, 'r') as file:
            reader = csv.DictReader(file, delimiter='\t')
            for row in reader:
                role_data[row['employeeId']] = row['formattedRole']
        return role_data
    except Exception as e:
        print(f"Error reading role_data.tsv: {e}")
        return {}

def update_role_cd(users: List[Dict], role_data: Dict[str, str]) -> Dict[str, int]:
    """Update role_cd for specified employees and generate a report of changes"""
    stats = {'updated': 0, 'skipped': 0, 'unchanged': 0}
    changes = []
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
        
        for user in users:
            emp_no = user['emp_no']
            current_role_cd = user['role_cd']
            
            if emp_no in role_data:
                new_role_cd = role_data[emp_no]
                
                # Skip if current role_cd is "user.role.admin"
                if current_role_cd == "user.role.admin":
                    stats['skipped'] += 1
                    continue
                
                # Update role_cd
                if current_role_cd != new_role_cd:
                    query = "UPDATE sys_user SET role_cd = %s WHERE emp_no = %s"
                    cursor.execute(query, (new_role_cd, emp_no))
                    stats['updated'] += 1
                    changes.append({
                        'emp_no': emp_no,
                        'old_role_cd': current_role_cd,
                        'new_role_cd': new_role_cd
                    })
                else:
                    stats['unchanged'] += 1
        
        # Commit changes
        connection.commit()
        print("Role updates committed to the database.")
        return stats, changes
    except Exception as e:
        print(f"Error updating role_cd: {e}")
        return stats, changes
    finally:
        if connection:
            connection.close()

def generate_report(changes: List[Dict], report_file: str) -> None:
    """Generate a report of the changes made"""
    try:
        with open(report_file, 'w', newline='') as file:
            writer = csv.DictWriter(file, fieldnames=['emp_no', 'old_role_cd', 'new_role_cd'])
            writer.writeheader()
            writer.writerows(changes)
        print(f"Report generated at: {report_file}")
    except Exception as e:
        print(f"Error generating report: {e}")

def log_stats(stats: Dict[str, int], log_file: str) -> None:
    """Log the statistics to a text file"""
    try:
        with open(log_file, 'w') as file:
            file.write(f"Total roles updated: {stats['updated']}\n")
            file.write(f"Total roles skipped: {stats['skipped']}\n")
            file.write(f"Total roles unchanged: {stats['unchanged']}\n")
        print(f"Log generated at: {log_file}")
    except Exception as e:
        print(f"Error generating log: {e}")

def main():
    # Path to role_data.tsv file
    role_data_file = r"c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\sys_uers\updateRoleCode\role_data.tsv"
    
    # Path to save the report and log
    report_file = r"c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\sys_uers\updateRoleCode\update_report.csv"
    log_file = r"c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\sys_uers\updateRoleCode\update_log.txt"
    
    # Fetch user data from the database
    users = fetch_from_database()
    
    # Read role data from the file
    role_data = read_role_data(role_data_file)
    
    # Update role_cd and generate a report
    stats, changes = update_role_cd(users, role_data)
    generate_report(changes, report_file)
    log_stats(stats, log_file)

if __name__ == "__main__":
    main()