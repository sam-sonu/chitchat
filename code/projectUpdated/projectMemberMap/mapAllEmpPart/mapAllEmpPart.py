import csv
import os
import mysql.connector
from datetime import datetime

# Database connection configuration
DB_CONFIG = {
    'host': '107.109.40.131',
    'port': 3306,
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

# Column indices (0-based)
PART_NAME_COLUMN = 11
EMPLOYEE_ID_COLUMN = 0
PART_HEAD_ID_COLUMN = 12  # Assuming part head ID is in column 12

# Input file path
input_file_path = r'c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\projectMemberMap\emp_api.tsv'

# Output file paths
script_dir = os.path.dirname(os.path.abspath(__file__))
output_file_path = os.path.join(script_dir, 'project_member_inserts.sql')
report_file_path = os.path.join(script_dir, 'project_member_report.txt')

# Constants for project_member table
DEL_YN = 'N'
MODIFIER_ID = 61
CREATOR_ID = 61
OBJ_CD = 'project.member'

# Statistics counters
stats = {
    'total_members': 0,
    'total_pl_existing': 0,
    'total_pl_insert': 0,
    'total_engg_existing': 0,
    'total_engg_insert': 0,
    'total_projects': set(),
    'total_skipped': 0,
    'project_member_map': {}  # To track members per project
}

def get_db_connection():
    """Create and return a database connection"""
    try:
        connection = mysql.connector.connect(
            host=DB_CONFIG['host'],
            port=DB_CONFIG['port'],
            database=DB_CONFIG['database'],
            user=DB_CONFIG['user'],
            password=DB_CONFIG['password']
        )
        return connection
    except mysql.connector.Error as err:
        print(f"Database connection error: {err}")
        raise

def fetch_project_id(part_name, cursor):
    """Fetch project_id from database based on part_name"""
    query = "SELECT id FROM project WHERE title = %s"
    cursor.execute(query, (part_name,))
    row = cursor.fetchone()
    cursor.fetchall()  # Consume any unread results
    return row[0] if row else None

def fetch_member_id(employee_id, cursor):
    """Fetch member_id from database based on employee_id"""
    query = "SELECT id FROM sys_user WHERE emp_no = %s"
    cursor.execute(query, (employee_id,))
    row = cursor.fetchone()
    cursor.fetchall()  # Consume any unread results
    return row[0] if row else None

def determine_role(employee_id, part_head_id):
    """Determine role based on employee_id and part_head_id"""
    if part_head_id and str(employee_id) == str(part_head_id):
        return 'project.role.pl'
    return 'project.role.engg'

def check_existing_member(project_id, member_id, cursor):
    """Check if a member already exists for a project"""
    query = """
    SELECT role_cd FROM project_member 
    WHERE project_id = %s AND member_id = %s
    """
    cursor.execute(query, (project_id, member_id))
    result = cursor.fetchone()
    cursor.fetchall()  # Consume any unread results
    return result[0] if result else None

def process_file(input_file, output_file, cursor):
    """Process the input file and generate SQL inserts"""
    with open(input_file, mode='r', encoding='utf-8') as file:
        reader = csv.reader(file, delimiter='\t')
        header = next(reader)  # Skip header
        
        output_file.write("-- SQL INSERT statements for project_member table\n")
        output_file.write("-- Generated from employee data\n")
        output_file.write(f"-- Date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        
        for row_num, row in enumerate(reader, 1):
            if not row:
                continue
                
            try:
                part_name = row[PART_NAME_COLUMN].strip()
                employee_id = row[EMPLOYEE_ID_COLUMN].strip()
                part_head_id = row[PART_HEAD_ID_COLUMN].strip() if len(row) > PART_HEAD_ID_COLUMN else None
                
                # Skip if essential data is missing
                if not part_name or not employee_id:
                    print(f"Warning: Row {row_num} missing part_name or employee_id")
                    continue
                
                # Skip if project name contains "INERT"
                if "INERT" in part_name.upper():
                    print(f"Skipping project {part_name} (filtered out)")
                    continue
                
                # Fetch required IDs
                project_id = fetch_project_id(part_name, cursor)
                if not project_id:
                    print(f"Warning: No project found for part_name {part_name}")
                    continue
                    
                member_id = fetch_member_id(employee_id, cursor)
                if not member_id:
                    print(f"Warning: No member found for employee_id {employee_id}")
                    continue
                
                # Update statistics
                stats['total_members'] += 1
                stats['total_projects'].add(project_id)
                
                # Initialize project in member map if not exists
                if project_id not in stats['project_member_map']:
                    stats['project_member_map'][project_id] = {
                        'name': part_name,
                        'members': 0,
                        'pl': 0,
                        'engg': 0
                    }
                
                # Check existing role if member exists
                existing_role = check_existing_member(project_id, member_id, cursor)
                role_cd = determine_role(employee_id, part_head_id)
                
                if existing_role:
                    stats['total_skipped'] += 1
                    stats['project_member_map'][project_id]['members'] += 1
                    if existing_role == 'project.role.pl':
                        stats['total_pl_existing'] += 1
                        stats['project_member_map'][project_id]['pl'] += 1
                    else:
                        stats['total_engg_existing'] += 1
                        stats['project_member_map'][project_id]['engg'] += 1
                    print(f"Info: Member {employee_id} already exists in project {project_id} as {existing_role} - skipping")
                    continue
                
                # Generate INSERT statement for new members
                sql = f"""
                INSERT INTO project_member (
                    project_id, member_id, role_cd, sno, del_yn,
                    modifier_id, modify_dt, creator_id, create_dt, obj_cd
                ) VALUES (
                    {project_id}, {member_id}, '{role_cd}', 0, '{DEL_YN}',
                    {MODIFIER_ID}, CURRENT_TIMESTAMP, {CREATOR_ID}, CURRENT_TIMESTAMP, '{OBJ_CD}'
                );
                """
                output_file.write(sql + "\n")
                
                # Update statistics for new inserts
                stats['project_member_map'][project_id]['members'] += 1
                if role_cd == 'project.role.pl':
                    stats['total_pl_insert'] += 1
                    stats['project_member_map'][project_id]['pl'] += 1
                else:
                    stats['total_engg_insert'] += 1
                    stats['project_member_map'][project_id]['engg'] += 1
                
            except IndexError as e:
                print(f"Warning: Row {row_num} doesn't have expected columns: {e}")
            except Exception as e:
                print(f"Error processing row {row_num}: {str(e)}")

def generate_report():
    """Generate a detailed report file with statistics"""
    with open(report_file_path, 'w', encoding='utf-8') as report_file:
        report_file.write("PROJECT MEMBER MAPPING REPORT\n")
        report_file.write("=============================\n")
        report_file.write(f"Generated on: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        
        report_file.write("SUMMARY STATISTICS\n")
        report_file.write("------------------\n")
        report_file.write(f"Total members processed: {stats['total_members']}\n")
        report_file.write(f"Total projects affected: {len(stats['total_projects'])}\n")
        report_file.write(f"Total PL existing: {stats['total_pl_existing']}\n")
        report_file.write(f"Total PL to insert: {stats['total_pl_insert']}\n")
        report_file.write(f"Total Engg existing: {stats['total_engg_existing']}\n")
        report_file.write(f"Total Engg to insert: {stats['total_engg_insert']}\n")
        report_file.write(f"Total skipped (existing): {stats['total_skipped']}\n\n")
        
        report_file.write("PROJECT DETAILS\n")
        report_file.write("---------------\n")
        for project_id, data in stats['project_member_map'].items():
            report_file.write(f"Project ID: {project_id} ({data['name']})\n")
            report_file.write(f"  Total members: {data['members']}\n")
            report_file.write(f"  PL count: {data['pl']}\n")
            report_file.write(f"  Engg count: {data['engg']}\n\n")
        
        report_file.write("END OF REPORT\n")

def main():
    try:
        # Connect to database
        conn = get_db_connection()
        cursor = conn.cursor(buffered=True)  # Use buffered cursor to avoid unread results
        
        # Open output file
        with open(output_file_path, 'w', encoding='utf-8') as output_file:
            process_file(input_file_path, output_file, cursor)
        
        # Generate report
        generate_report()
        
        print(f"SQL insert statements successfully saved to: {output_file_path}")
        print(f"Report file generated at: {report_file_path}")
        
    except FileNotFoundError:
        print(f"Error: File not found at {input_file_path}")
    except mysql.connector.Error as e:
        print(f"Database error: {str(e)}")
    except Exception as e:
        print(f"An error occurred: {str(e)}")
    finally:
        # Close database connection if it exists
        if 'conn' in locals():
            try:
                cursor.close()
                conn.close()
            except:
                pass  # Ignore any errors during close

if __name__ == "__main__":
    main()