import csv

def process_employee_roles(input_file, output_file):
    # Define role mappings
    role_mappings = {
        'Expat': 'user.role.expat',
        'Group Head': 'user.role.grouphead',
        'HR Admin': 'user.role.hradmin',
        'MD': 'user.role.md',
        'Part Lead': 'user.role.partlead',
        'Super Admin': 'user.role.superhead',
        'Team Head': 'user.role.teamhead'
    }
    
    # Default role when missing
    default_role = 'user.role.engg'

    # Read input TSV file
    with open(input_file, 'r', newline='', encoding='utf-8') as infile:
        reader = csv.DictReader(infile, delimiter='\t')
        fieldnames = ['employeeId', 'employeeName', 'roleName']
        
        # Process each row
        rows = []
        for row in reader:
            # Get original role name
            original_role = row.get('roleName', '').strip()
            
            # Map role or use default
            if original_role in role_mappings:
                mapped_role = role_mappings[original_role]
            elif not original_role:
                mapped_role = default_role
            else:
                mapped_role = original_role  # Keep original if not in mappings
            
            # Create new row with only required fields
            new_row = {
                'employeeId': row.get('employeeId', ''),
                'employeeName': row.get('employeeName', ''),
                'roleName': mapped_role
            }
            rows.append(new_row)
    
    # Write to output TSV file
    with open(output_file, 'w', newline='', encoding='utf-8') as outfile:
        writer = csv.DictWriter(outfile, fieldnames=fieldnames, delimiter='\t')
        writer.writeheader()
        writer.writerows(rows)

# Example usage
input_path = 'c:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/role_code/emp_api.tsv'
output_path = 'c:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/role_code/processed_roles.tsv'
process_employee_roles(input_path, output_path)