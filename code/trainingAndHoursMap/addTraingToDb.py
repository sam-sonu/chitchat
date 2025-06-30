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

def format_completion_date(date_str):
    """Format completion date to MySQL datetime format"""
    if not date_str or date_str.strip() == '':
        return None
    
    try:
        # Try parsing with format: '5/30/2025 4:05:19 PM'
        date_obj = datetime.strptime(date_str, '%m/%d/%Y %I:%M:%S %p')
        return date_obj.strftime('%Y-%m-%d 00:00:00.000000')
    except ValueError:
        return None

def get_skill_id(cursor, skill_title):
    """Get skill ID for given skill title"""
    if not skill_title:
        return None
    cursor.execute("SELECT id FROM skill WHERE title = %s", (skill_title,))
    result = cursor.fetchone()
    return result['id'] if result else None

def count_user_emails(email_str):
    """Count number of emails in comma-separated string"""
    if not email_str:
        return 0
    return len([email for email in email_str.split(',') if email.strip()])

def parse_training_hours(hours_str):
    """Parse training hours into simple format"""
    try:
        hours = float(hours_str)
        if hours <= 0:
            return "00:00", "00.00"
        return "00:00", f"{hours:.2f}"
    except:
        return "00:00", "00.00"

def get_user_emails_for_training(training_title, training_data):
    """Get all user emails associated with a specific training title"""
    emails = []
    for row in training_data:
        if row['Training Title'] == training_title and row['User Email Address']:
            emails.append(row['User Email Address'].strip())
    return ','.join(emails) if emails else None

def process_training_file(titles_file):
    """Process training file and insert new records"""
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
        
        # Prepare consolidated records
        consolidated_records = []
        for title in unique_titles:
            # Find first record with this title to get common data
            sample_record = next(row for row in training_data if row['Training Title'] == title)
            
            # Get all emails for this training
            user_emails = get_user_emails_for_training(title, training_data)
            
            # Format completion date
            completion_date = format_completion_date(sample_record['Completion Date']) 
            
            consolidated_records.append({
                'Training Title': title,
                'Provider': sample_record['Provider'],
                'Completion Date': completion_date,
                'Training Hours': sample_record['Training Hours'],
                'Training Attendee Status': 'status.complete' if sample_record['Training Attendee Status'] == "Completed" else 'status.draft',
                'User Email Address': user_emails,
                'Position': sample_record.get('Position', 'Software R&D (JFG)')
            })
        
        # First confirmation - show summary
        print(f"\nFound {len(consolidated_records)} unique training records to process")
        print("First 5 sample records:")
        for i, record in enumerate(consolidated_records[:5], 1):
            print(f"\nRecord {i}:")
            for key, value in record.items():
                print(f"{key}: {value}")
        
        confirm = input("\nDo you want to proceed with inserting these records? (yes/no): ").strip().lower()
        if confirm != 'yes':
            print("Operation cancelled.")
            return
        
        # Second confirmation - insert first 5 records
        confirm_first5 = input("\nDo you want to proceed with inserting the FIRST 5 records only? (yes/no): ").strip().lower()
        if confirm_first5 == 'yes':
            # Process first 5 records
            inserted_count = 0
            for row in consolidated_records[:5]:
                try:
                    # Get required values
                    skill_id = get_skill_id(cursor, row['Position'])
                    user_emails = row['User Email Address']
                    start_time, end_time = parse_training_hours(row['Training Hours'])
                    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                    email_count = count_user_emails(user_emails)
                    
                    # Prepare insert query
                    query = """
                        INSERT INTO content_training (
                            pid, parent_id, title, code, ref_link, trainer_id, project_id,
                            event_dt, event_type_cd, location, skill_id, current_level_cd,
                            target_level_cd, user_id_arr, status_cd, sno, del_yn, modifier_id,
                            modify_dt, creator_id, create_dt, obj_cd, start_time, end_time,
                            description, external_survey_yn, external_survey_url, trainer_id_arr,
                            show_yn, module_id, program_id, co_author_id_arr, feedback_show_yn,
                            nomination_yn, mandatory_yn, training_size, training_type_cd,
                            approval_yn, email_yn, reminder_yn, verified_yn
                        ) VALUES (
                            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                            %s, %s, %s, %s, %s, %s, %s
                        )
                    """
                    
                    values = (
                        0, 0, row['Training Title'], '', row['Provider'], 0, 0,
                        row['Completion Date'],
                        "training.event.type.online", row['Provider'],
                        skill_id, "skill.level.intermediate", "skill.level.advance",
                        user_emails, row['Training Attendee Status'], 0, 'N', 61, now,
                        1975, now, 'content.training', start_time, end_time,
                        row['Training Title'], 'N', '', '', 'Y', 0, 0, '', 'Y',
                        'N', 'N', email_count, 'by.ld', 'N', 'N', 'Y', 'N'
                    )
                    
                    cursor.execute(query, values)
                    print(f"Inserted training ID: {cursor.lastrowid} - {row['Training Title']}")
                    inserted_count += 1
                except Exception as e:
                    print(f"Error inserting training: {row['Training Title']} - {str(e)}")
            
            connection.commit()
            print(f"\nSuccessfully inserted {inserted_count} out of 5 records")
            
            # Third confirmation - insert remaining records
            if len(consolidated_records) > 5:
                confirm_rest = input("\nDo you want to proceed with inserting the remaining records? (yes/no): ").strip().lower()
                if confirm_rest == 'yes':
                    inserted_count = 0
                    for row in consolidated_records[5:]:
                        try:
                            # Get required values
                            skill_id = get_skill_id(cursor, row['Position'])
                            user_emails = row['User Email Address']
                            start_time, end_time = parse_training_hours(row['Training Hours'])
                            now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
                            email_count = count_user_emails(user_emails)
                            
                            # Prepare insert query
                            query = """
                                INSERT INTO content_training (
                                    pid, parent_id, title, code, ref_link, trainer_id, project_id,
                                    event_dt, event_type_cd, location, skill_id, current_level_cd,
                                    target_level_cd, user_id_arr, status_cd, sno, del_yn, modifier_id,
                                    modify_dt, creator_id, create_dt, obj_cd, start_time, end_time,
                                    description, external_survey_yn, external_survey_url, trainer_id_arr,
                                    show_yn, module_id, program_id, co_author_id_arr, feedback_show_yn,
                                    nomination_yn, mandatory_yn, training_size, training_type_cd,
                                    approval_yn, email_yn, reminder_yn, verified_yn
                                ) VALUES (
                                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                                    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                                    %s, %s, %s, %s, %s, %s, %s
                                )
                            """
                            
                            values = (
                                0, 0, row['Training Title'], '', row['Provider'], 0, 0,
                                row['Completion Date'],
                                "training.event.type.online", row['Provider'],
                                skill_id, "skill.level.intermediate", "skill.level.advance",
                                user_emails, row['Training Attendee Status'], 0, 'N', 61, now,
                                1975, now, 'content.training', start_time, end_time,
                                row['Training Title'], 'N', '', '', 'Y', 0, 0, '', 'Y',
                                'N', 'N', email_count, 'by.ld', 'N', 'N', 'Y', 'N'
                            )
                            
                            cursor.execute(query, values)
                            print(f"Inserted training ID: {cursor.lastrowid} - {row['Training Title']}")
                            inserted_count += 1
                        except Exception as e:
                            print(f"Error inserting training: {row['Training Title']} - {str(e)}")
                    
                    connection.commit()
                    print(f"\nSuccessfully inserted {inserted_count} out of {len(consolidated_records[5:])} remaining records")
                else:
                    print("Skipping remaining records.")
        else:
            print("Operation cancelled.")
        
    except Error as e:
        print(f"⚠️ Database error: {e}")
    except Exception as e:
        print(f"⚠️ Error: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_file = sys.argv[1]
    else:
        input_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\trainingAndHoursMap\trainingHours.txt'
    
    process_training_file(input_file)