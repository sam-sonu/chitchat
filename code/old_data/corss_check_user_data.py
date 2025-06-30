import pandas as pd
from pathlib import Path
from urllib.parse import quote_plus
from sqlalchemy import create_engine
from sqlalchemy.exc import SQLAlchemyError

# Database configuration
DB_CONFIG = {
    'host': '107.109.40.131',
    'port': 3306,
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'  # Your password with special characters
}

# Path to the new employees file
new_employees_path = Path('C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/output/new_employees.tsv')

def create_db_engine():
    try:
        # URL-encode special characters in password
        encoded_password = quote_plus(DB_CONFIG['password'])
        
        # Create engine with explicit database name
        connection_url = (
            f"mysql+pymysql://{DB_CONFIG['user']}:{encoded_password}@"
            f"{DB_CONFIG['host']}:{DB_CONFIG['port']}/{DB_CONFIG['database']}"
        )
        
        engine = create_engine(
            connection_url,
            pool_recycle=3600,
            pool_pre_ping=True,
            connect_args={
                'connect_timeout': 10,
            }
        )
        return engine
    except Exception as e:
        print(f"Error creating database engine: {e}")
        return None

def check_existing_employees():
    # Read new employees TSV
    try:
        new_employees = pd.read_csv(new_employees_path, sep='\t')
    except FileNotFoundError:
        print(f"Error: File not found at {new_employees_path}")
        return

    # Create database engine
    engine = create_db_engine()
    if engine is None:
        return

    try:
        with engine.connect() as connection:
            # Create a list to store duplicates
            duplicates = []
            
            for _, row in new_employees.iterrows():
                emp_id = str(row['employeeId'])
                emp_name = row['employeeName'].strip().lower()
                
                # Check by employee number (emp_no)
                query_emp_no = "SELECT id, title, emp_no, knox_id, role_cd FROM sys_user WHERE emp_no = %s"
                result_emp_no = pd.read_sql(query_emp_no, connection, params=(emp_id,))
                
                # Check by employee name (case-insensitive) in title column
                query_name = "SELECT id, title, emp_no, knox_id, role_cd FROM sys_user WHERE LOWER(title) = %s"
                result_name = pd.read_sql(query_name, connection, params=(emp_name,))
                
                if not result_emp_no.empty or not result_name.empty:
                    match_type = 'Employee Number' if not result_emp_no.empty else 'Name'
                    match_record = result_emp_no.iloc[0] if not result_emp_no.empty else result_name.iloc[0]
                    
                    duplicates.append({
                        'employeeId': emp_id,
                        'employeeName': row['employeeName'],
                        'exists_by': match_type,
                        'db_id': match_record['id'],
                        'db_title': match_record['title'],
                        'db_emp_no': match_record['emp_no'],
                        'db_knox_id': match_record['knox_id'],
                        'db_role_cd': match_record['role_cd']
                    })
            
            # Output results
            if duplicates:
                print("Duplicate/Existing employees found:")
                for dup in duplicates:
                    print(f"New Employee ID: {dup['employeeId']}, Name: {dup['employeeName']}")
                    print(f"Exists in DB by: {dup['exists_by']}")
                    print(f"DB Record - ID: {dup['db_id']}, Title: {dup['db_title']}")
                    print(f"Emp No: {dup['db_emp_no']}, Knox ID: {dup['db_knox_id']}, Role: {dup['db_role_cd']}\n")
                
                # Save duplicates to file with more details
                dup_df = pd.DataFrame([{
                    'new_employeeId': d['employeeId'],
                    'new_employeeName': d['employeeName'],
                    'exists_by': d['exists_by'],
                    'db_id': d['db_id'],
                    'db_title': d['db_title'],
                    'db_emp_no': d['db_emp_no'],
                    'db_knox_id': d['db_knox_id'],
                    'db_role_cd': d['db_role_cd']
                } for d in duplicates])
                
                output_path = Path('C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/output/duplicate_employees.tsv')
                dup_df.to_csv(output_path, sep='\t', index=False)
                print(f"Duplicate records saved to: {output_path}")
            else:
                print("No duplicate/existing employees found in the database.")

    except SQLAlchemyError as e:
        print(f"Database error occurred: {e}")
    finally:
        engine.dispose()

if __name__ == '__main__':
    check_existing_employees()