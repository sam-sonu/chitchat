# import csv

# with open(r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\projectMemberMap\emp_project_mapping.tsv', 'r') as f:
#     reader = csv.DictReader(f, delimiter='\t')
#     values = []
    
#     for row_number, row in enumerate(reader, start=1):
#         try:
#             # Validate EmployeeID
#             emp_id = row.get('EmployeeID', '').strip()
#             if not emp_id:
#                 raise ValueError(f"Missing EmployeeID at row {row_number}")
            
#             # Validate ProjectID
#             project_id_str = row.get('ProjectID')
#             if not project_id_str:
#                 raise ValueError(f"Missing ProjectID at row {row_number}")
            
#             try:
#                 project_id = int(project_id_str)
#             except ValueError:
#                 raise ValueError(f"Invalid ProjectID '{project_id_str}' at row {row_number}")
            
#             values.append(f"ROW('{emp_id}', {project_id})")
            
#         except (KeyError, ValueError) as e:
#             print(f"Error: {str(e)}")
#             continue  # Skip invalid rows
    
#     sql_values = ',\n        '.join(values)
    
# full_sql = f"""
# WITH project_mapping AS (
#     SELECT * FROM (
#         VALUES 
#         {sql_values}
#     ) AS t(EmployeeID, ProjectID)
# )
# SELECT 
#    su.id AS emp_no,
#     su.role_cd,
#     pm.ProjectID
# FROM 
#     gh_v3_prd.sys_user su
# INNER JOIN 
#     project_mapping pm
# ON 
#     su.emp_no = pm.EmployeeID;
# """

# print(full_sql)

