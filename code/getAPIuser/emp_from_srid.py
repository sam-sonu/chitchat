# Process employee data from testemp.txt
emp_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\employee_data_20250507_104541.txt'
emp_data = {}  # {name: [emp_ids]}
with open(emp_file, 'r', encoding='utf-8') as file:
    for line in file:
        if line.startswith('employeeId\t') or not line.strip():
            continue
        parts = line.strip().split('\t')
        if len(parts) >= 2:
            emp_id = parts[0]
            name = parts[1]
            emp_data.setdefault(name, []).append(emp_id)

# Process system user data from sys_users.tsv
sys_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\sys_users.tsv'
common_users = []
new_system_users = []

with open(sys_file, 'r', encoding='utf-8') as file:
    for line in file:
        if line.startswith('id\t') or not line.strip():
            continue
            
        parts = line.strip().split('\t')
        if len(parts) >= 7:
            title = parts[1]
            emp_no = parts[6]
            
            # Check for common users
            if title in emp_data:
                for emp_id in emp_data[title]:
                    common_users.append((emp_id, title))
            else:
                new_system_users.append((emp_no, title))

# Display common users with employee IDs
print("COMMON USERS (Employee ID\tName)")
for emp_id, name in common_users:
    print(f"{emp_id}\t{name}")
print(f"\nTotal Common Users: {len(common_users)}")

# Display new system users with system emp numbers
print("\nNEW SYSTEM USERS (Emp No\tName)")
for emp_no, name in new_system_users:
    print(f"{emp_no}\t{name}")
print(f"\nTotal New System Users: {len(new_system_users)}")