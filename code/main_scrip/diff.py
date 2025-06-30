import re

def clean_code(raw_code):
    # First handle specific special characters by removing them completely
    code = re.sub(r'[/&-]', '', raw_code)
    # Then replace multiple dots with single dot
    code = re.sub(r'\.+', '.', code)
    # Remove all other special characters except letters and numbers, replace with dot
    code = re.sub(r'[^a-zA-Z0-9]+', '.', code)
    # Convert to lowercase
    code = code.lower()
    # Remove leading/trailing dots
    code = code.strip('.')
    return code

def get_project_level(title):
    # Extract last word from title
    last_word = title.strip().split()[-1].lower()
    # Check if it matches our target words
    if last_word in ['part', 'team', 'group']:
        return last_word
    return ""

def compare_files(base_file, new_file):
    # Read base file records
    base_records = {}
    with open(base_file, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line:  # Skip empty lines
                parts = line.split('\t')
                if len(parts) >= 2:
                    title = parts[0]
                    code = clean_code(parts[1])
                    base_records[title] = code
                else:
                    print(f"Skipping malformed line in base file: {line}")

    # Read new file records and compare
    new_records = {}
    unmatched_records = {}
    common_count = 0
    updated_count = 0
    new_count = 0
    
    with open(new_file, 'r', encoding='utf-8') as f:
        new_titles = set()
        for line in f:
            line = line.strip()
            if line:  # Skip empty lines
                parts = line.split('\t')
                if len(parts) >= 2:
                    title = parts[0]
                    new_titles.add(title)
                    raw_code = parts[1]
                    code = clean_code(raw_code)
                    project_level = get_project_level(title)
                    
                    if title in base_records:
                        if code == base_records[title]:
                            common_count += 1
                        else:
                            updated_count += 1
                            new_records[title] = (code, project_level)
                    else:
                        new_count += 1
                        new_records[title] = (code, project_level)
                else:
                    print(f"Skipping malformed line in new file: {line}")

    # Find unmatched records in base file
    for title, code in base_records.items():
        if title not in new_titles:
            project_level = get_project_level(title)
            unmatched_records[title] = (code, project_level)

    # Generate output
    print(f"Common matching records: {common_count}")
    print(f"Updated records: {updated_count}")
    print(f"New records: {new_count}")
    print(f"Total new/updated records: {len(new_records)}")
    print(f"Unmatched records in base file: {len(unmatched_records)}")
    
    # Write new/updated records to output
    with open('difference_output.txt', 'w', encoding='utf-8') as f:
        # Write header
        f.write("title\tcode\tproject_level\tstatus\n")
        
        # Write new/updated records
        for title, (code, project_level) in new_records.items():
            status = "updated" if title in base_records else "new"
            f.write(f"{title}\t{code}\t{project_level}\t{status}\n")
        
        # Write unmatched records
        for title, (code, project_level) in unmatched_records.items():
            f.write(f"{title}\t{code}\t{project_level}\tunmatched\n")

# Example usage
base_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\main_scrip\project_db_local_data.txt'
new_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\main_scrip\api_formated.txt'
compare_files(base_file, new_file)