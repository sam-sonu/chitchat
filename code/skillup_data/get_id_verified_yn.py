import csv
import sys
import mysql.connector
from mysql.connector import Error

DB_CONFIG = {
    'host': '107.109.40.131',
    'port': 3306,
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

def test_connection():
    """Test database connection"""
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        connection.close()
        return True
    except Error as e:
        print(f"🔍 Connection failed: {e}")
        return False

def transform_proficiency(prof_level):
    """Convert proficiency level format"""
    if not prof_level:
        return ""
    return prof_level.replace(' to ', '->')

def read_and_update_file(filename):
    """Read the file, query database, and update the same file"""
    try:
        # First read all data and get additional info from DB
        with open(filename, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f, delimiter='\t')
            rows = list(reader)
            fieldnames = reader.fieldnames + ['id', 'verified_yn'] if reader.fieldnames else []

        # Connect to database
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Process each row
        updated_rows = []
        for row in rows:
            # Get additional data from DB
            title = row.get('Title', '')
            prof_level = row.get('Profiency Level', '')
            db_prof = transform_proficiency(prof_level)
            full_title = f"{title} {db_prof}" if title and db_prof else title
            
            cursor.execute("""
                SELECT id, verified_yn 
                FROM content_course 
                WHERE title = %s
            """, (full_title,))
            result = cursor.fetchone()
            course_id, verified_yn = result if result else (None, None)

            # Create updated row
            updated_row = row.copy()
            updated_row['id'] = course_id
            updated_row['verified_yn'] = verified_yn
            updated_rows.append(updated_row)

        # Write back to the same file
        with open(filename, 'w', newline='', encoding='utf-8') as f:
            writer = csv.DictWriter(f, fieldnames=fieldnames, delimiter='\t')
            writer.writeheader()
            writer.writerows(updated_rows)

        print(f"✅ Successfully updated {filename} with id and verified_yn")

    except Exception as e:
        print(f"🔍 Error: {e}")
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    if test_connection():
        print("✅ Connection successful! Proceed with main script.")
        read_and_update_file(r'report-bot\skillup_data\data.txt')
    else:
        print("❌ Fix connection issues first.")
        sys.exit(1)