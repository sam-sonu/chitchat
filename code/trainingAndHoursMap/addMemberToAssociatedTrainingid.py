import csv
import sys
import mysql.connector
from mysql.connector import Error
from datetime import datetime

DB_CONFIG = {
    'host': '107.109.40.131',
    'port': 3306,
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

def get_training_id(cursor, training_title):
    """Get training ID for given title"""
    query = "SELECT id FROM content_training WHERE title = %s ORDER BY create_dt DESC LIMIT 1"
    cursor.execute(query, (training_title,))
    result = cursor.fetchone()
    cursor.fetchall()  # Consume any unread results
    return result['id'] if result else None

def get_member_id(cursor, emp_no):
    """Get member ID for given emp_no"""
    query = "SELECT id FROM sys_user WHERE emp_no = %s"
    cursor.execute(query, (emp_no,))
    result = cursor.fetchone()
    cursor.fetchall()  # Consume any unread results
    return result['id'] if result else None

def process_training_members(titles_file):
    """Process training file and map users to training in member table"""
    try:
        # Connect to MySQL database
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor(dictionary=True)
        
        # Read training data from file
        with open(titles_file, 'r', encoding='utf-8') as f:
            reader = csv.DictReader(f, delimiter='\t')
            training_data = [row for row in reader if row['Training Title']]
        
        # Get unique training titles
        unique_titles = list(set(row['Training Title'] for row in training_data))
        
        # Prepare data for confirmation
        sample_mappings = []
        total_mappings = 0
        
        # Process each training to gather data for confirmation
        for title in unique_titles:
            training_id = get_training_id(cursor, title)
            if not training_id:
                print(f"Training not found in database: {title}")
                continue
            
            emp_nos = []
            for row in training_data:
                if row['Training Title'] == title and row['User ID']:
                    emp_nos.extend([emp_no.strip() for emp_no in row['User ID'].split(',') if emp_no.strip()])
            
            if not emp_nos:
                print(f"No emp_no found for training: {title}")
                continue
            
            # Get member details for confirmation
            for emp_no in emp_nos[:3]:  # Get first 3 for sample
                member_id = get_member_id(cursor, emp_no)
                if member_id:
                    sample_mappings.append({
                        'training_title': title,
                        'training_id': training_id,
                        'emp_no': emp_no,
                        'member_id': member_id
                    })
            
            total_mappings += len(emp_nos)
        
        # Show confirmation with sample data
        print(f"\nTotal mappings to be created: {total_mappings}")
        print("\nSample mappings (first 3):")
        for i, mapping in enumerate(sample_mappings[:3], 1):
            print(f"\nSample {i}:")
            print(f"Training Title: {mapping['training_title']}")
            print(f"Training ID: {mapping['training_id']}")
            print(f"Emp No: {mapping['emp_no']}")
            print(f"Member ID: {mapping['member_id']}")
        
        confirm = input("\nDo you want to proceed with inserting these mappings? (yes/no): ").strip().lower()
        if confirm != 'yes':
            print("Operation cancelled.")
            return
        
        # Process each training for actual insertion
        for title in unique_titles:
            training_id = get_training_id(cursor, title)
            if not training_id:
                continue
            
            emp_nos = []
            for row in training_data:
                if row['Training Title'] == title and row['User ID']:
                    emp_nos.extend([emp_no.strip() for emp_no in row['User ID'].split(',') if emp_no.strip()])
            
            if not emp_nos:
                continue
            
            # Get member IDs and insert records
            inserted_count = 0
            for emp_no in emp_nos:
                member_id = get_member_id(cursor, emp_no)
                if not member_id:
                    print(f"Member not found for emp_no: {emp_no}")
                    continue
                
                try:
                    # Check if member already mapped to this training
                    check_query = """
                        SELECT id FROM content_training_member 
                        WHERE training_id = %s AND member_id = %s
                    """
                    cursor.execute(check_query, (training_id, member_id))
                    result = cursor.fetchone()
                    cursor.fetchall()  # Consume any unread results
                    
                    if result:
                        print(f"Member {member_id} already mapped to training {training_id}")
                        continue
                    
                    # Prepare insert query
                    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                    query = """
                        INSERT INTO content_training_member (
                            training_id, member_id, role_cd, feedback, rating,
                            user_attended_yn, status_cd, sno, del_yn, modifier_id,
                            modify_dt, creator_id, create_dt, obj_cd, rating_cd,
                            nominated_yn
                        ) VALUES (
                            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                        )
                    """
                    
                    values = (
                        training_id, member_id, 'training.member.role.learner', '', 0,
                        'Y', 'status.draft', 0, 'N', 61,
                        now, 1975, now, 'content.training.member', '',
                        'N'
                    )
                    
                    cursor.execute(query, values)
                    inserted_count += 1
                    print(f"Mapped member {member_id} to training {training_id}")
                except Exception as e:
                    print(f"Error mapping member {member_id} to training {training_id}: {str(e)}")
            
            connection.commit()
            print(f"\nSuccessfully mapped {inserted_count} members to training: {title}")
        
    except Error as e:
        print(f"⚠️ Database error: {e}")
    except Exception as e:
        print(f"⚠️ Error: {e}")
    finally:
        if connection and connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_file = sys.argv[1]
    else:
        input_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\trainingAndHoursMap\trainingHours.txt'
    
    process_training_members(input_file)