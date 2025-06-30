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

def read_courses_from_file(filename):
    """Read courses from the data.txt file with error handling"""
    courses = []
    try:
        with open(filename, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f, delimiter='\t')
            for row in reader:
                # Handle missing fields with defaults
                courses.append({
                    'no': row.get('no', ''),
                    'title': row.get('Title', ''),
                    'prof_level': row.get('Profiency Level', ''),
                    'category': row.get('Category', ''),
                    'type': row.get('Type', ''),
                    'remarks': row.get('Remaks', '')  # Note: Original has typo 'Remaks'
                })
    except Exception as e:
        print(f"🔍 Error reading file: {e}")
    return courses

def query_database(cursor, title, prof_level):
    """Query database for matching course"""
    db_prof = transform_proficiency(prof_level)
    full_title = f"{title} {db_prof}" if title and db_prof else title
    
    try:
        cursor.execute("""
            SELECT id, verified_yn 
            FROM content_course 
            WHERE title = %s
        """, (full_title,))
        return cursor.fetchone()
    except Error as e:
        print(f"🔍 Database query error: {e}")
        return None

def main():
    try:
        # Connect to database
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()

        # Read courses from file
        courses = read_courses_from_file(r'report-bot\skillup_data\data.txt')
        if not courses:
            print("🔍 No courses found in data.txt")
            return

        # Prepare output
        output = []
        for course in courses:
            result = query_database(cursor, course['title'], course['prof_level'])
            course_id, verified_yn = result if result else (None, None)
            
            output.append({
                'no': course.get('no', ''),
                'title': course.get('title', ''),
                'prof_level': course.get('prof_level', ''),
                'category': course.get('category', ''),
                'type': course.get('type', ''),
                'remarks': course.get('remarks', ''),
                'id': course_id,
                'verified_yn': verified_yn
            })

        # Write to new file
        with open('output_with_ids.txt', 'w', newline='', encoding='utf-8') as f:
            fieldnames = ['no', 'title', 'prof_level', 'category', 'type', 'remarks', 'id', 'verified_yn']
            writer = csv.DictWriter(f, fieldnames=fieldnames, delimiter='\t')
            writer.writeheader()
            writer.writerows(output)

        print("✅ Successfully created output_with_ids.txt")

    except Exception as e:
        print(f"🔍 Error: {e}")
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    if test_connection():
        print("✅ Connection successful! Proceed with main script.")
        main()
    else:
        print("❌ Fix connection issues first.")
        sys.exit(1)