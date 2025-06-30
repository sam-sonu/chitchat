import pandas as pd
import sqlite3  # or your database connector
from datetime import datetime

def update_project_members(tsv_path, db_connection):
    """
    Updates project member mappings from a TSV file, checking for existing entries.
    
    Args:
        tsv_path (str): Path to TSV file containing partName mappings
        db_connection: Database connection object or connection string
    """
    try:
        # Step 1: Read TSV file
        df = pd.read_csv(tsv_path, sep='\t')
        
        # Step 2: Connect to database
        conn = sqlite3.connect(db_connection)
        cursor = conn.cursor()
        
        # Get current timestamp for create_dt/modify_dt
        current_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
        
        for index, row in df.iterrows():
            part_name = row['partName']  # assuming column name is partName
            
            # Step 3: Get member_id from member table
            cursor.execute("""
                SELECT id FROM member WHERE part_name = ?
            """, (part_name,))
            member_result = cursor.fetchone()
            
            if not member_result:
                print(f"No member found with part_name: {part_name}")
                continue
                
            member_id = member_result[0]
            
            # Step 4: Get project_id from project table
            cursor.execute("""
                SELECT id FROM project WHERE part_name = ?
            """, (part_name,))
            project_result = cursor.fetchone()
            
            if not project_result:
                print(f"No project found with part_name: {part_name}")
                continue
                
            project_id = project_result[0]
            
            # Step 5: Check if mapping already exists
            cursor.execute("""
                SELECT COUNT(*) FROM project_member
                WHERE project_id = ? AND member_id = ? AND del_yn = 'N'
            """, (project_id, member_id))
            
            count = cursor.fetchone()[0]
            
            # Step 6: Insert new mapping if doesn't exist
            if count == 0:
                # Get next sno value
                cursor.execute("""
                    SELECT COALESCE(MAX(sno), 0) + 1 FROM project_member
                    WHERE project_id = ?
                """, (project_id,))
                next_sno = cursor.fetchone()[0]
                
                cursor.execute("""
                    INSERT INTO project_member (
                        project_id, member_id, role_cd, sno, del_yn,
                        modifier_id, modify_dt, creator_id, create_dt, obj_cd
                    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """, (
                    project_id, member_id, 'DEFAULT_ROLE', next_sno, 'N',
                    1, current_time, 1, current_time, 'project.member'
                ))
                print(f"Added new mapping: project_id={project_id}, member_id={member_id}")
            else:
                print(f"Mapping exists - project_id={project_id}, member_id={member_id}")
        
        # Step 7: Commit changes and close connection
        conn.commit()
        conn.close()
        
    except Exception as e:
        print(f"Error occurred: {str(e)}")
        if 'conn' in locals():
            conn.rollback()
            conn.close()

# Usage example
update_project_members('member_mappings.tsv', 'your_database.db')