import csv
import sys
import mysql.connector
from mysql.connector import Error
from difflib import SequenceMatcher
from datetime import datetime

DB_CONFIG = {
    'host': '107.109.40.131',
    'port': 3306,
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

def similar(a, b, threshold=0.8):
    """Check if two strings are similar above a threshold"""
    return SequenceMatcher(None, a.lower(), b.lower()).ratio() >= threshold

def get_unique_titles(input_file):
    """Extract unique titles from input file"""
    unique_titles = set()
    with open(input_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f, delimiter='\t')
        for row in reader:
            if row['Training Title']:
                unique_titles.add(row['Training Title'].strip())
    return sorted(unique_titles)

def save_unique_titles(titles, input_file):
    """Save unique titles to a new file"""
    unique_file = input_file.replace('.txt', '_unique.txt')
    with open(unique_file, 'w', encoding='utf-8', newline='') as f:
        writer = csv.writer(f, delimiter='\t')
        writer.writerow(['Training Title'])
        for title in titles:
            writer.writerow([title])
    return unique_file

def check_titles_in_db(titles_file):
    """
    Check if training titles exist in database (exact or similar matches)
    and generate a report file with statistics
    
    Args:
        titles_file: Path to training hours text file
    """
    # Get unique titles and save to new file
    unique_titles = get_unique_titles(titles_file)
    unique_file = save_unique_titles(unique_titles, titles_file)
    
    report_data = {
        'timestamp': datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        'input_file': titles_file,
        'unique_file': unique_file,
        'total_unique_titles': len(unique_titles),
        'exact_matches': [],
        'similar_matches': [],
        'no_matches': [],
        'exact_count': 0,
        'similar_count': 0,
        'no_match_count': 0
    }

    try:
        # Connect to MySQL database
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor(dictionary=True)
        
        # Get all database titles once
        cursor.execute("SELECT title FROM content_training")
        db_titles = [row['title'] for row in cursor.fetchall()]
        
        # Check each unique title against database
        for title in unique_titles:
            # Check exact match (case insensitive)
            exact_match = None
            for db_title in db_titles:
                if title.lower() == db_title.lower():
                    exact_match = db_title
                    break
            
            if exact_match:
                report_data['exact_matches'].append({
                    'file_title': title,
                    'db_title': exact_match
                })
                report_data['exact_count'] += 1
                continue
            
            # Check for similar titles if no exact match
            similar_titles = [db_title for db_title in db_titles if similar(title, db_title)]
            
            if similar_titles:
                report_data['similar_matches'].append({
                    'file_title': title,
                    'db_titles': similar_titles
                })
                report_data['similar_count'] += 1
            else:
                report_data['no_matches'].append(title)
                report_data['no_match_count'] += 1
        
        # Generate report file
        generate_report(report_data)
        
    except Error as e:
        print(f"⚠️ Database error: {e}")
    except Exception as e:
        print(f"⚠️ Error: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def generate_report(report_data):
    """Generate a detailed report file with all matches"""
    report_path = report_data['input_file'].replace('.txt', '_report.txt')
    
    with open(report_path, 'w', encoding='utf-8') as f:
        f.write(f"Training Title Matching Report\n")
        f.write(f"Generated at: {report_data['timestamp']}\n")
        f.write(f"Input file: {report_data['input_file']}\n")
        f.write(f"Unique titles file: {report_data['unique_file']}\n")
        f.write("\n=== Summary ===\n")
        f.write(f"Total unique titles processed: {report_data['total_unique_titles']}\n")
        f.write(f"Exact matches found: {report_data['exact_count']}\n")
        f.write(f"Similar matches found: {report_data['similar_count']}\n")
        f.write(f"No matches found: {report_data['no_match_count']}\n")
        
        f.write("\n=== Exact Matches ===\n")
        for match in report_data['exact_matches']:
            f.write(f"File Title: {match['file_title']}\n")
            f.write(f"DB Title:   {match['db_title']}\n\n")
        
        f.write("\n=== Similar Matches ===\n")
        for match in report_data['similar_matches']:
            f.write(f"File Title: {match['file_title']}\n")
            f.write("Similar DB Titles:\n")
            for db_title in match['db_titles']:
                f.write(f"  - {db_title}\n")
            f.write("\n")
        
        f.write("\n=== No Matches Found ===\n")
        for title in report_data['no_matches']:
            f.write(f"{title}\n")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        input_file = sys.argv[1]
    else:
        input_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\trainingAndHoursMap\trainingHours.txt'
    
    check_titles_in_db(input_file)