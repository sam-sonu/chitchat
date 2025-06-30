import re

def parse_employee_data(filepath):
    employees = []
    with open(filepath, 'r') as f:
        for line in f:
            parts = [p.strip() for p in line.strip().split('\t') if p.strip()]
            if len(parts) >= 3:  # Need at least id, role_cd, title
                userid = parts[0]
                rolecd = parts[1]
                employees.append((userid, rolecd))
    return employees

def parse_project_data(filepath):
    projects = []
    with open(filepath, 'r') as f:
        next(f)  # Skip header line
        for line in f:
            line = line.strip()
            if not line:
                continue
            # Extract project ID from format "'396', 'Advance SW Group'"
            match = re.match(r"'(\d+)',\s*'([^']+)'", line)
            if match:
                projects.append((match.group(1), match.group(2)))
    return projects

# File paths
employee_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\role_code\data.txt'
project_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\role_code\new_projects.txt'
output_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\user_project_role.csv'

# Process data
employees = parse_employee_data(employee_file)
projects = parse_project_data(project_file)

if not projects:
    print("Error: No projects found in project file")
    exit()

# Generate output with distributed project assignments
with open(output_file, 'w') as out:
    out.write("userid,projectid,rolecd\n")
    for i, (userid, rolecd) in enumerate(employees):
        # Cycle through projects using modulo
        project_id = projects[i % len(projects)][0]
        out.write(f"{userid},{project_id},{rolecd}\n")

print(f"Created {output_file} with {len(employees)} records")
print(f"Assigned projects from {len(projects)} available projects")