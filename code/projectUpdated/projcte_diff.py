import csv

def read_projects(filename):
    projects = set()  # Using set to store just titles
    with open(filename, 'r', newline='', encoding='utf-8') as file:
        # Skip empty lines and handle header
        lines = [line for line in file if line.strip()]
        if len(lines) > 0 and lines[0].startswith('title'):
            lines = lines[1:]  # Skip header if present
        
        for line in lines:
            # Split on first tab to get title (ignore code)
            parts = line.strip().split('\t')
            if parts:  # Only add if there's content
                title = parts[0].strip()
                if title:  # Only add non-empty titles
                    projects.add(title)
    return projects

def compare_projects(old_file, new_file, output_file):
    # Read both files (only titles)
    old_projects = read_projects(old_file)
    new_projects = read_projects(new_file)
    
    # Find common and new projects
    common_projects = new_projects.intersection(old_projects)
    new_projects_only = new_projects.difference(old_projects)
    
    # Calculate counts
    common_count = len(common_projects)
    new_count = len(new_projects_only)
    
    # Prepare results
    results = {
        'common_projects': sorted(common_projects),
        'new_projects': sorted(new_projects_only),
        'common_count': common_count,
        'new_count': new_count,
        'total_old': len(old_projects),
        'total_new': len(new_projects)
    }
    
    # Save results to file
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("Comparison Results (Title Only):\n")
        f.write(f"Total projects in old file: {results['total_old']}\n")
        f.write(f"Total projects in new file: {results['total_new']}\n")
        f.write(f"Common projects count: {results['common_count']}\n")
        f.write(f"New projects count: {results['new_count']}\n\n")
        
        f.write("Common Projects (Titles):\n")
        for title in results['common_projects']:
            f.write(f"{title}\n")
        
        f.write("\nNew Projects (Titles):\n")
        for title in results['new_projects']:
            f.write(f"{title}\n")
    
    return results

# File paths
old_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\project_output.txt'
new_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\output.txt'
output_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\report-bot\projectUpdated\comparison_results.txt'

# Run comparison
results = compare_projects(old_file, new_file, output_file)
print(f"Comparison complete. Results saved to {output_file}")