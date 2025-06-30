import csv

input_file = r'c:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/sys_users.tsv'
output_file = 'c:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/existing_users.tsv'

# Define the columns to extract
required_columns = ['id', 'title', 'code', 'knox_id', 'emp_no', 'role_cd', 'user_type']

with open(input_file, 'r', newline='', encoding='utf-8') as infile, open(output_file, 'w', newline='', encoding='utf-8') as outfile:
    reader = csv.reader(infile, delimiter='\t')
    writer = csv.writer(outfile, delimiter='\t')
    
    # Read the header row to determine column indices
    headers = next(reader)
    column_indices = [headers.index(col) for col in required_columns]
    
    # Write the header row to the output file
    writer.writerow(required_columns)
    
    # Process each row and extract the required columns
    for row in reader:
        extracted_row = [row[i] for i in column_indices]
        writer.writerow(extracted_row)