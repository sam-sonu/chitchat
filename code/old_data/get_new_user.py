import pandas as pd
from pathlib import Path

# Define output directory
output_dir = Path('C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/output')
output_dir.mkdir(parents=True, exist_ok=True)

# Read the TSV files
filter_df = pd.read_csv('C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/filter_user_api_data.tsv', sep='\t')
existing_df = pd.read_csv('C:/Users/sonu.km/Desktop/basefile/sql_py_reader_bot/sys_uers/existing_users.tsv', sep='\t')

# Get employee IDs from both files
filter_emp_ids = set(filter_df['employeeId'].astype(str))
existing_emp_ids = set(existing_df['emp_no'].astype(str))

# Find common employees
common_emp_ids = filter_emp_ids.intersection(existing_emp_ids)
common_employees = filter_df[filter_df['employeeId'].astype(str).isin(common_emp_ids)]

# Find new employees (in filter but not in existing)
new_emp_ids = filter_emp_ids - existing_emp_ids
new_employees = filter_df[filter_df['employeeId'].astype(str).isin(new_emp_ids)]

# Find non-existing employees (in existing but not in filter)
non_existing_emp_ids = existing_emp_ids - filter_emp_ids
non_existing_employees = existing_df[existing_df['emp_no'].astype(str).isin(non_existing_emp_ids)]

# Get counts
total_filter_count = len(filter_df)
total_existing_count = len(existing_df)
common_count = len(common_employees)
new_count = len(new_employees)
non_existing_count = len(non_existing_employees)

# Save results to TSV files
common_employees[['employeeId', 'employeeName', 'knox']].to_csv(output_dir / 'common_employees.tsv', sep='\t', index=False)
new_employees[['employeeId', 'employeeName', 'knox']].to_csv(output_dir / 'new_employees.tsv', sep='\t', index=False)
non_existing_employees[['emp_no', 'title']].rename(columns={'emp_no': 'employeeId', 'title': 'employeeName'}) \
    .to_csv(output_dir / 'non_existing_employees.tsv', sep='\t', index=False)

# Save summary statistics
summary_data = {
    'Metric': ['Total in filter data', 'Total in existing data', 'Common employees', 'New employees', 'Non-existing employees'],
    'Count': [total_filter_count, total_existing_count, common_count, new_count, non_existing_count]
}
pd.DataFrame(summary_data).to_csv(output_dir / 'summary_stats.tsv', sep='\t', index=False)

print("Analysis completed. Results saved to:")
print(f"- Common employees: {output_dir / 'common_employees.tsv'}")
print(f"- New employees: {output_dir / 'new_employees.tsv'}")
print(f"- Non-existing employees: {output_dir / 'non_existing_employees.tsv'}")
print(f"- Summary statistics: {output_dir / 'summary_stats.tsv'}")