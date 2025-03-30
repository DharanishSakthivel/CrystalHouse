# Employee Management System

A comprehensive PostgreSQL-based Employee Management System that handles employee data, departments, job roles, and organizational hierarchy.

## Database Schema

### Tables

1. **Departments**
   - `id`: SERIAL PRIMARY KEY
   - `name`: VARCHAR(100) NOT NULL UNIQUE
   - `create_date`: TIMESTAMP
   - `update_date`: TIMESTAMP

2. **Job Roles**
   - `id`: SERIAL PRIMARY KEY
   - `title`: VARCHAR(100) NOT NULL UNIQUE
   - `create_date`: TIMESTAMP
   - `update_date`: TIMESTAMP

3. **Employees**
   - `id`: SERIAL PRIMARY KEY
   - `name`: VARCHAR(100) NOT NULL
   - `email`: VARCHAR(100) UNIQUE
   - `department_id`: INTEGER (Foreign Key to departments)
   - `job_role_id`: INTEGER (Foreign Key to job_roles)
   - `salary`: NUMERIC(10, 2) NOT NULL CHECK (salary > 0)
   - `date_of_joining`: DATE NOT NULL
   - `manager_id`: INTEGER (Self-referencing Foreign Key)
   - `create_date`: TIMESTAMP
   - `update_date`: TIMESTAMP

### Performance Optimizations

The following indexes are implemented for optimal query performance:

- `idx_employees_department_id`: Index on department_id for faster joins
- `idx_employees_job_role_id`: Index on job_role_id for faster joins
- `idx_employees_manager_id`: Index on manager_id for reporting structure queries
- `idx_employees_date_of_joining`: Index on date_of_joining for tenure queries
- `idx_employees_salary`: Composite index for salary range queries
- `idx_employees_dept_job`: Composite index for department and job role filtering
- `idx_employees_email`: Index for email lookups

## Local Setup Instructions

1. **Prerequisites**
   - PostgreSQL 12 or higher
   - psql command-line tool

2. **Database Setup**
   ```bash
   # Connect to PostgreSQL
   psql -U postgres

   # Create a new database
   CREATE DATABASE employee_management;

   # Connect to the new database
   \c employee_management

   # Create the schema and tables
   \i employee_management_system.sql
   ```

## Key Features

### Stored Procedures

1. **Update Salary by Performance**
   ```sql
   CALL emp_mgnt.update_salary_by_performance(employee_id, performance_rating);
   ```
   - Updates employee salary based on performance rating
   - Performance ratings: 'Excellent' (10%), 'Good' (5%), 'Average' (2%)

### Functions

1. **Get Department Employee Count**
   ```sql
   SELECT emp_mgnt.get_department_employee_count(department_id);
   ```
   - Returns the total number of employees in a specific department

### Sample Queries

1. **List Employees with Department and Role**
   ```sql
   SELECT 
       e.name AS employee_name,
       d.name AS department,
       j.title AS job_role
   FROM 
       emp_mgnt.employees e
   JOIN 
       emp_mgnt.departments d ON e.department_id = d.id
   JOIN
       emp_mgnt.job_roles j ON e.job_role_id = j.id
   ORDER BY
       e.name;
   ```

2. **Find Long-tenure Employees**
   ```sql
   SELECT 
       name AS employee_name,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_joining)) AS tenure_years
   FROM 
       emp_mgnt.employees
   WHERE 
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, date_of_joining)) >= 5
   ORDER BY 
       tenure_years DESC;
   ```

3. **Department Average Salary**
   ```sql
   SELECT 
       d.name AS department,
       ROUND(AVG(e.salary), 2) AS average_salary,
       COUNT(e.id) AS employee_count
   FROM 
       emp_mgnt.departments d
   JOIN 
       emp_mgnt.employees e ON d.id = e.department_id
   GROUP BY 
       d.id, d.name
   ORDER BY 
       average_salary DESC;
   ```

## Sample Data

The system comes with pre-populated sample data including:
- 5 departments (Engineering, Marketing, HR, Sales, Finance)
- 5 job roles (Analyst, Engineer, Manager, Specialist, Coordinator)
- 50+ employee records with realistic salary distributions and reporting structures

## Best Practices

1. **Data Integrity**
   - Foreign key constraints ensure referential integrity
   - CHECK constraints validate salary values
   - UNIQUE constraints prevent duplicate entries

2. **Performance**
   - Strategic indexes for common query patterns
   - Optimized joins using appropriate indexes
   - Efficient hierarchical queries for reporting structure

3. **Maintainability**
   - Organized schema structure
   - Documented stored procedures and functions
   - Consistent naming conventions