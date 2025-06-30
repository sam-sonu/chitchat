import mysql.connector
from mysql.connector import Error
import csv

DB_CONFIG = {
    'host': '107.109.40.131:3306',
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

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
    # Select specific columns and exclude project_level = 'project'
    cursor.execute("SELECT title, code FROM project WHERE project_level != 'project'")
    
    # Fetch all rows and column names
    rows = cursor.fetchall()
    columns = [col[0] for col in cursor.description]
    
    # Write to TXT file with tab separation
    with open('project_output.txt', 'w', newline='', encoding='utf-8') as txt_file:
        # Write header
        txt_file.write('\t'.join(columns) + '\n')
        # Write each row
        for row in rows:
            txt_file.write('\t'.join(str(item) for item in row) + '\n')
    
    print(f"Successfully saved {len(rows)} records (excluding project_level='project') to project_output.txt")

except Error as e:
    print(f"Database error: {e}")
    
finally:
    if 'connection' in locals() and connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")