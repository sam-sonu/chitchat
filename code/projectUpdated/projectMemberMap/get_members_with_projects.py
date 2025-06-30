import csv

project_mapping = {
    "AI Assistants Part": 18,
    "Ad Platform Shared Service Team": 1,
    "Advance SW Group": 3,
    "Content Quality Part": 33,
    "Enterprise OSU Part": 26,
    "Family Hub": 405,
    "Intelligent Data Solutions Part": 23,
    "International Assignment(VD)": 3,
    "Kitchen AI Part": 18,
    "People Partners - Business": 411,
    "Product S/W R&D Lab": 3,
    "Reliability Engineering Part": 33,
    "Samsung R&D Institute India - Delhi [IA Home]": 402,
    "Screen Experience Part": 23,
    "Sensing AI Part": 23,
    "Service Operations Group": 12,
    "Talent & Org. Culture": 13
}

input_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\projectMemberMap\emp_api.tsv'
output_file = 'emp_project_mapping.tsv'

def extract_emp_projects():
    emp_projects = set()
    
    with open(input_file, 'r', encoding='utf-8') as tsvfile:
        reader = csv.DictReader(tsvfile, delimiter='\t')
        
        # Verify column names
        print("Available columns:", reader.fieldnames)
        
        for row in reader:
            # Changed to partName based on data sample
            project_name = row['partName']  
            if project_name in project_mapping:
                emp_id = row['employeeId']
                project_id = project_mapping[project_name]
                emp_projects.add((emp_id, str(project_id)))
    
    # Sort numerically
    sorted_data = sorted(emp_projects, key=lambda x: (int(x[0]), int(x[1])))
    
    with open(output_file, 'w', encoding='utf-8', newline='') as outfile:
        writer = csv.writer(outfile, delimiter='\t')
        writer.writerow(['EmployeeID', 'ProjectID'])
        writer.writerows(sorted_data)
    
    print(f"Generated {len(sorted_data)} mappings. Saved to {output_file}")

if __name__ == '__main__':
    extract_emp_projects()