import pandas as pd
import json

# Read the Excel file
excel_path = 'Attachments/Sample Employee Data.xlsx'

# Check for sheet names
xls = pd.ExcelFile(excel_path)
print(f"Sheet names: {xls.sheet_names}")

# Read each sheet
for sheet_name in xls.sheet_names:
    print(f"\n--- {sheet_name} ---")
    df = pd.read_excel(excel_path, sheet_name=sheet_name)
    
    # Skip header rows and set proper column names
    if 'Sample Employee Data' in df.columns:
        # Get the header row (usually the first row)
        header_row = df.iloc[0]
        # Set the header row as column names
        df.columns = header_row
        # Drop the header row
        df = df.iloc[1:].reset_index(drop=True)
    
    print(f"Shape: {df.shape}")
    print("Columns:")
    for col in df.columns:
        print(f"  - {col}")
    print("Sample data (first 5 rows):")
    print(df.head(5))
    
    # Extract unique departments and job roles
    if 'Department' in df.columns and 'Job Role' in df.columns:
        departments = df['Department'].unique()
        job_roles = df['Job Role'].unique()
        
        print(f"\nUnique Departments ({len(departments)}):")
        for dept in departments:
            print(f"  - {dept}")
            
        print(f"\nUnique Job Roles ({len(job_roles)}):")
        for role in job_roles:
            print(f"  - {role}")
    
    # Save to JSON for easier reference
    try:
        df_json = df.to_json(orient='records', date_format='iso')
        with open(f"{sheet_name}_data.json", 'w') as f:
            f.write(df_json)
        print(f"\nSaved data to {sheet_name}_data.json")
    except Exception as e:
        print(f"Error saving to JSON: {e}")
