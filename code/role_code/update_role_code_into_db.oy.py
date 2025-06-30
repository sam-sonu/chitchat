import csv
import mysql.connector
from datetime import datetime

def update_role_codes(tsv_file_path):
    try:
        # Initialize counters
        counters = {
            'updated': 0,
            'skipped': 0,
            'not_found': 0,
            'errors': 0
        }

        # Database connection setup
        connection = mysql.connector.connect(
            host='107.109.40.131',
            port=3306,
            user='root',
            password='DBpoum0&8',
            database='gh_v3_prd'
        )
        cursor = connection.cursor()

        # Create a timestamp for the log files
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        log_file_path = f'role_update_log_{timestamp}.tsv'
        summary_file_path = f'role_update_summary_{timestamp}.txt'
        
        # Read employee data from TSV file
        with open(tsv_file_path, 'r', newline='', encoding='utf-8') as tsvfile, \
             open(log_file_path, 'w', newline='', encoding='utf-8') as logfile:
            
            # Setup CSV reader and writer
            reader = csv.DictReader(tsvfile, delimiter='\t')
            fieldnames = ['status', 'old_emp_name', 'old_emp_no', 'old_role', 
                          'new_emp_name', 'new_emp_no', 'new_role']
            writer = csv.DictWriter(logfile, fieldnames=fieldnames, delimiter='\t')
            writer.writeheader()
            
            for row in reader:
                emp_no = row['employeeId']
                employee_name = row['employeeName']
                new_role = row['roleName']
                
                try:
                    # Get current user data from DB
                    select_query = """
                        SELECT title, emp_no, role_cd FROM sys_user
                        WHERE LPAD(emp_no, 7, '0') = LPAD(%s, 7, '0')
                        AND title = %s
                        LIMIT 1;
                    """
                    cursor.execute(select_query, (emp_no, employee_name))
                    result = cursor.fetchone()
                    
                    if result:
                        db_name, db_emp_no, old_role = result
                        
                        if old_role == 'user.role.admin':
                            # Log skipped admin users
                            writer.writerow({
                                'status': 'SKIPPED',
                                'old_emp_name': db_name,
                                'old_emp_no': db_emp_no,
                                'old_role': old_role,
                                'new_emp_name': employee_name,
                                'new_emp_no': emp_no,
                                'new_role': 'ADMIN - NOT UPDATED'
                            })
                            counters['skipped'] += 1
                            print(f"Skipped admin user: {employee_name} (ID: {emp_no})")
                        else:
                            # Update query
                            update_query = """
                                UPDATE sys_user
                                SET role_cd = %s
                                WHERE LPAD(emp_no, 7, '0') = LPAD(%s, 7, '0') 
                                AND title = %s
                                AND role_cd != 'user.role.admin';
                            """
                            # cursor.execute(update_query, (new_role, emp_no, employee_name))
                            
                            # Log successful updates
                            writer.writerow({
                                'status': 'UPDATED',
                                'old_emp_name': db_name,
                                'old_emp_no': db_emp_no,
                                'old_role': old_role,
                                'new_emp_name': employee_name,
                                'new_emp_no': emp_no,
                                'new_role': new_role
                            })
                            counters['updated'] += 1
                            print(f"Updated {employee_name} (ID: {emp_no}) from {old_role} to {new_role}")
                    else:
                        # Log users not found in DB
                        writer.writerow({
                            'status': 'NOT_FOUND',
                            'old_emp_name': 'N/A',
                            'old_emp_no': 'N/A',
                            'old_role': 'N/A',
                            'new_emp_name': employee_name,
                            'new_emp_no': emp_no,
                            'new_role': new_role
                        })
                        counters['not_found'] += 1
                        print(f"User not found: {employee_name} (ID: {emp_no})")
                
                except Exception as e:
                    writer.writerow({
                        'status': 'ERROR',
                        'old_emp_name': 'ERROR',
                        'old_emp_no': 'ERROR',
                        'old_role': 'ERROR',
                        'new_emp_name': employee_name,
                        'new_emp_no': emp_no,
                        'new_role': f'ERROR: {str(e)}'
                    })
                    counters['errors'] += 1
                    print(f"Error processing {employee_name} (ID: {emp_no}): {e}")
        
        # Commit all changes
        connection.commit()
        
        # Create summary file
        with open(summary_file_path, 'w', encoding='utf-8') as summary_file:
            summary_file.write(f"Role Update Summary - {timestamp}\n")
            summary_file.write("=================================\n")
            summary_file.write(f"Total records processed: {sum(counters.values())}\n")
            summary_file.write(f"Successfully updated: {counters['updated']}\n")
            summary_file.write(f"Skipped (admin users): {counters['skipped']}\n")
            summary_file.write(f"Not found in database: {counters['not_found']}\n")
            summary_file.write(f"Errors encountered: {counters['errors']}\n")
            summary_file.write("\nDetailed log file: " + log_file_path)
        
        print(f"\nAll role updates completed.")
        print(f"Detailed log file created at: {log_file_path}")
        print(f"Summary file created at: {summary_file_path}")
        
    except Exception as e:
        if 'connection' in locals():
            connection.rollback()
        print(f"Error occurred: {e}")
    finally:
        if 'connection' in locals() and connection.is_connected():
            cursor.close()
            connection.close()

# Usage example
update_role_codes('c:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/role_code/processed_roles.tsv')