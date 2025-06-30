import mysql.connector
from mysql.connector import Error
from datetime import datetime

DB_CONFIG = {
    'host': '107.109.40.131:3306',
    'database': 'gh_v3_prd',
    'user': 'root',
    'password': 'DBpoum0&8'
}

# List of new projects to add
new_projects = [
    "AI Assistants Part",
    "Ad Platform Shared Service Team",
    "Advance SW Group",
    "Content Quality Part",
    "Enterprise OSU Part",
    "Family Hub",
    "Intelligent Data Solutions Part",
    "International Assignment(VD)",
    "Kitchen AI Part",
    "People Partners - Business",
    "Product S/W R&D Lab",
    "Reliability Engineering Part",
    "Samsung R&D Institute India - Delhi [IA Home]",
    "Screen Experience Part",
    "Sensing AI Part",
    "Service Operations Group",
    "Talent & Org. Culture"
]

def generate_code(title):
    # First handle common abbreviations
    title = title.replace('S/W', 'sw').replace('R&D', 'rd')
    
    # Remove special characters (keep only alphanumeric and spaces)
    code = ''.join(c if c.isalnum() or c == ' ' else ' ' for c in title)
    
    # Replace spaces with dots and convert to lowercase
    code = code.lower().replace(' ', '.')
    
    # Remove any consecutive dots and trim
    code = '.'.join(filter(None, code.split('.')))
    return code

def get_project_level(title):
    # Default to 'part' if no matching suffix found
    default_level = 'part'
    
    # Check for common suffixes
    for suffix in ['part', 'group', 'team']:
        if title.lower().endswith(suffix):
            return suffix
    
    # Special case for "Family Hub" - no suffix
    return default_level

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
    
    # Prepare insert statement
    insert_query = """
    INSERT INTO project (
        title, code, project_level, pid, parent_id, plm_cd, adp, sno, 
        status_cd, del_yn, modifier_id, modify_dt, creator_id, create_dt, obj_cd
    ) VALUES (
        %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
    )
    """
    
    # Current timestamp
    now = datetime.now()
    
    # Prepare all data first
    all_data = []
    for project in new_projects:
        code = generate_code(project)
        project_level = get_project_level(project)
        
        data = (
            project.strip(),  # title
            code,            # code
            project_level,   # project_level
            0,               # pid
            0,               # parent_id
            "",              # plm_cd
            0,               # adp
            0,               # sno
            "new",           # status_cd
            "N",             # del_yn
            61,              # modifier_id
            now,             # modify_dt
            61,              # creator_id
            now,             # create_dt
            "project"        # obj_cd
        )
        all_data.append(data)
    
    # Print preview of data to be inserted
    print("\nPreview of data to be inserted:")
    print("-" * 100)
    print(f"{'Title':<35} | {'Code':<35} | {'Project Level':<10} | {'Status'}")
    print("-" * 100)
    for data in all_data:
        print(f"{data[0]:<35} | {data[1]:<35} | {data[2]:<10} | {data[8]}")
    
    # Ask for confirmation
    confirm = input("\nDo you want to proceed with the insertion? (yes/no): ").strip().lower()
    if confirm != 'yes':
        print("Insertion cancelled by user.")
        exit()
    
    # Insert each project if confirmed
    for data in all_data:
        cursor.execute(insert_query, data)
    
    # Commit the transaction
    connection.commit()
    print(f"\nSuccessfully inserted {len(new_projects)} new projects into the database")

except Error as e:
    print(f"Database error: {e}")
    if 'connection' in locals() and connection.is_connected():
        connection.rollback()
    
finally:
    if 'connection' in locals() and connection.is_connected():
        cursor.close()
        connection.close()
        print("MySQL connection is closed")