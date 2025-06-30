import csv

# Input and output file paths
input_file = "C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/emp_api.tsv"
output_file = "C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/filter_user_api_data.tsv"

def extract_employee_data(input_path, output_path):
    """
    Extract employeeId and employeeName from TSV data and save to TSV file.
    
    Args:
        input_path (str): Path to input TSV data file
        output_path (str): Path to output TSV file
    """
    try:
        # Open input TSV file
        with open(input_path, 'r', encoding='utf-8') as infile:
            # Read the TSV file using csv reader
            tsv_reader = csv.DictReader(infile, delimiter='\t')
            
            # Get fieldnames to check if required columns exist
            fieldnames = tsv_reader.fieldnames
            
            if not fieldnames or 'employeeId' not in fieldnames or 'employeeName' not in fieldnames or 'knox' not in fieldnames:
                raise ValueError("Input file doesn't contain required columns (employeeId and employeeName)")
            
            # Open output TSV file
            with open(output_path, 'w', newline='', encoding='utf-8') as outfile:
                tsv_writer = csv.writer(outfile, delimiter='\t')
                
                # Write header
                tsv_writer.writerow(['employeeId', 'employeeName', 'knox'])
                
                # Process each row to extract employee data
                for row in tsv_reader:
                    try:
                        employee_id = row['employeeId']
                        employee_name = row['employeeName']
                        employee_knox = row['knox']
                        tsv_writer.writerow([employee_id, employee_name, employee_knox])
                    except KeyError:
                        continue  # Skip rows with missing data
        
        print(f"Data successfully saved to {output_path}")
    
    except FileNotFoundError:
        print(f"Error: Input file not found at {input_path}")
    except Exception as e:
        print(f"An error occurred: {str(e)}")

# Execute the function
extract_employee_data(input_file, output_file)