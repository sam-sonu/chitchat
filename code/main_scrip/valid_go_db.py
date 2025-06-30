def determine_project_level(title):
    """Determine project level based on title suffix"""
    if not title or str(title).strip() == '':
        return None
    
    title_lower = str(title).lower().strip()
    if title_lower.endswith(' team'):
        return 'team'
    elif title_lower.endswith(' group'):
        return 'group'
    elif title_lower.endswith(' part'):
        return 'part'
    else:
        return None  # For titles not ending with Team/Group/Part

def process_employee_data(input_file, output_file):
    """Process employee data to extract team/group/part info and transform it"""
    import csv
    
    # Read input data
    with open(input_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f, delimiter='\t')
        header = next(reader)
        rows = list(reader)
    
    # Get column indices
    team_index = header.index('teamName')
    group_index = header.index('groupName')
    part_index = header.index('partName')
    
    # Prepare output data (using dictionary to avoid duplicates and track titles)
    output_data = {}
    
    # Process each row
    for row in rows:
        # Process team
        team = str(row[team_index]).strip()
        if team:
            code = transform_to_code(team)
            level = determine_project_level(team)
            output_data[team] = (team, code, level)
        
        # Process group
        group = str(row[group_index]).strip()
        if group:
            code = transform_to_code(group)
            level = determine_project_level(group)
            output_data[group] = (group, code, level)
        
        # Process part
        part = str(row[part_index]).strip()
        if part:
            code = transform_to_code(part)
            level = determine_project_level(part)
            output_data[part] = (part, code, level)
    
    # Write output
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("title\tcode\tproject_level\n")
        for item in sorted(output_data.values()):
            # Convert None to empty string for output
            level = item[2] if item[2] is not None else ''
            f.write(f"{item[0]}\t{item[1]}\t{level}\n")

def transform_to_code(title):
    """Transform title into code format (lowercase with spaces and special chars replaced by dots)"""
    if not title or str(title).strip() == '':
        return ''
    
    # Convert to lowercase
    code = str(title).lower()
    # Replace special characters and clean up
    code = ''.join(c if c.isalnum() else '.' for c in code)
    code = code.replace('..', '.')
    code = code.strip('.')
    return code

# Example usage
input_file = 'c:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/main_scrip/newEmpSheet.txt'
output_file = 'c:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/main_scrip/output_results.txt'
process_employee_data(input_file, output_file)