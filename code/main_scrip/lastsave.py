import os
from datetime import datetime

def clean_code(code):
    """Clean code by removing double dots and standardizing format"""
    # Remove all double dots
    while '..' in code:
        code = code.replace('..', '.')
    # Remove any leading/trailing dots
    code = code.strip('.')
    return code

def load_data(file_path):
    """Load data with better validation and debugging"""
    data = set()
    try:
        if not os.path.exists(file_path):
            print(f"Error: File does not exist - {file_path}")
            return data
            
        with open(file_path, 'r', encoding='utf-8') as f:
            print(f"\nLoading file: {file_path}")
            print(f"File size: {os.path.getsize(file_path)} bytes")
            
            # Read and validate header
            header = next(f, None)
            if not header:
                print("File is empty")
                return data
                
            print(f"Header: {header.strip()}")
            expected_columns = ['title', 'code', 'project_level']
            if not all(col in header.lower() for col in expected_columns):
                print("Warning: Header doesn't match expected format")
            
            # Process data lines
            line_count = 0
            valid_count = 0
            for line in f:
                line_count += 1
                parts = line.strip().split('\t')
                if len(parts) == 3:
                    # Clean the code before adding to set
                    cleaned_code = clean_code(parts[1].strip())
                    data.add((parts[0].strip(), cleaned_code, parts[2].strip()))
                    valid_count += 1
                else:
                    print(f"Skipping malformed line {line_count}: {line.strip()}")
            
            print(f"Processed {line_count} lines, found {valid_count} valid entries")
            if valid_count == 0:
                print("File appears to have no valid data rows")
                
    except Exception as e:
        print(f"Error processing {file_path}: {str(e)}")
    
    return data

def main():
    # File paths - UPDATE THESE TO YOUR ACTUAL FILES
    base_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\main_scrip\project_output.txt'
    new_file = r'C:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\main_scrip\output_results.txt'
    result_file = r'c:\Users\sonu.km\Desktop\basefile\sql_py_reader_bot\comparison_results.txt'
    
    print("=== Starting Data Comparison ===")
    
    # Load data with detailed debugging
    base_data = load_data(base_file)
    new_data = load_data(new_file)
    
    # Compare data
    new_entries = new_data - base_data
    common_entries = new_data & base_data
    unmatched_entries = base_data - new_data
    
    # Save results
    with open(result_file, 'w', encoding='utf-8') as f:
        # Write summary header
        f.write("=== DATA COMPARISON RESULTS ===\n\n")
        f.write(f"Base file: {base_file}\n")
        f.write(f"New file: {new_file}\n")
        f.write(f"Comparison date: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n\n")
        
        # Write statistics
        f.write("=== STATISTICS ===\n")
        f.write(f"Total base entries: {len(base_data)}\n")
        f.write(f"Total new entries: {len(new_data)}\n")
        f.write(f"New entries: {len(new_entries)}\n")
        f.write(f"Common entries: {len(common_entries)}\n")
        f.write(f"Unmatched entries: {len(unmatched_entries)}\n\n")
        
        # Write detailed results
        if new_entries:
            f.write("=== NEW ENTRIES ===\n")
            for item in sorted(new_entries):
                f.write(f"{item[0]}\t{item[1]}\t{item[2]}\n")
            f.write("\n")
        
        if common_entries:
            f.write("=== COMMON ENTRIES ===\n")
            for item in sorted(common_entries):
                f.write(f"{item[0]}\t{item[1]}\t{item[2]}\n")
            f.write("\n")
        
        if unmatched_entries:
            f.write("=== UNMATCHED ENTRIES ===\n")
            for item in sorted(unmatched_entries):
                f.write(f"{item[0]}\t{item[1]}\t{item[2]}\n")
    
    print("\n=== Comparison Complete ===")
    print(f"Results saved to: {result_file}")

if __name__ == "__main__":
    main()