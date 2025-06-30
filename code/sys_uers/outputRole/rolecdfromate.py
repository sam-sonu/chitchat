import pandas as pd

# Read the TSV file
file_path = r"c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\sys_uers\outputRole\filtered_api_users.tsv"
data = pd.read_csv(file_path, sep='\t')

# Print all emp_no and formatted roleName pairs
for index, row in data.iterrows():
    # Handle NaN values
    role = str(row['roleName']).lower().replace(' ', '') if pd.notna(row['roleName']) else 'engg'
    formatted_role = f"user.role.{role}"
    print(f"Employee Number: {row['employeeId']}, Formatted Role: {formatted_role}")