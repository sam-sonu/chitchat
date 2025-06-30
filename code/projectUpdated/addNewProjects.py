import csv
import os
import re

def get_team_group_part_names(file_path):
    """
    Extract unique team names, group names, and part names from a TSV file.
    
    Args:
        file_path (str): Path to the TSV file
        
    Returns:
        tuple: (set of team names, set of group names, set of part names)
    """
    try:
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"File not found: {file_path}")
            
        team_names = set()
        group_names = set()
        part_names = set()
        
        with open(file_path, 'r', newline='', encoding='utf-8') as tsvfile:
            reader = csv.DictReader(tsvfile, delimiter='\t')
            for row in reader:
                if 'teamName' in row and row['teamName'].strip():
                    team_names.add(row['teamName'].strip())
                if 'groupName' in row and row['groupName'].strip():
                    group_names.add(row['groupName'].strip())
                if 'partName' in row and row['partName'].strip():
                    part_names.add(row['partName'].strip())
                    
        return team_names, group_names, part_names
    except Exception as e:
        print(f"Error reading file: {e}")
        return set(), set(), set()

def transform_to_dot_format(name):
    """
    Transform a name into dot notation format.
    
    Args:
        name (str): The name to transform
        
    Returns:
        str: The transformed name in dot notation format
    """
    # Replace special characters and spaces with dots
    transformed = re.sub(r'[^a-zA-Z0-9]+', '.', name)
    # Remove leading/trailing dots and convert to lowercase
    transformed = transformed.strip('.').lower()
    return transformed

# Main execution
file_path = r'c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\emp_api.tsv'
output_file = r'c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\output.txt'
teams, groups, parts = get_team_group_part_names(file_path)

# Debug: Print counts for verification
print(f"Found {len(teams)} unique team names")
print(f"Found {len(groups)} unique group names")
print(f"Found {len(parts)} unique part names")

all_names = teams.union(groups, parts)
print(f"Total unique names after union: {len(all_names)}")

with open(output_file, 'w', encoding='utf-8') as f:
    # Write header with title and code columns
    f.write("title\tcode\n")
    
    # Write all names in two-column format
    for name in sorted(all_names):
        if not name:  # Skip empty names
            continue
        f.write(f"{name.ljust(30)}\t{transform_to_dot_format(name)}\n")

print(f"Output successfully written to {output_file}")