# Employee Management System v2

A comprehensive PostgreSQL-based Employee Management System that efficiently manages employee data, departments, job roles, and organizational hierarchy. This system provides robust data management capabilities with optimized performance through strategic indexing.

## Features

- Complete employee information management
- Department and job role organization
- Hierarchical management structure
- Salary management and performance-based updates
- Comprehensive reporting capabilities
- Optimized query performance through strategic indexing

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

Strategic indexes implemented for optimal query performance:

- `idx_employees_department_id`: Index on department_id for faster joins
- `idx_employees_job_role_id`: Index on job_role_id for faster joins
- `idx_employees_manager_id`: Index on manager_id for reporting structure queries
- `idx_employees_date_of_joining`: Index on date_of_joining for tenure queries
- `idx_employees_salary`: Composite index for salary range queries
- `idx_employees_dept_job`: Composite index for department and job role filtering
- `idx_employees_email`: Index for email lookups

## Setup Instructions

### Prerequisites

- PostgreSQL 12 or higher
- psql command-line tool

### Database Setup

1. **Connect to PostgreSQL**
   ```bash
   psql -U postgres
   ```

2. **Create Database**
   ```sql
   CREATE DATABASE employee_management;
   ```

3. **Connect to Database**
   ```sql
   \c employee_management
   ```

4. **Create Schema and Tables**
   ```sql
   \i employee_management_system.sql
   ```

## Sample Data

The system comes with pre-populated sample data including:
- 5 departments (Engineering, Marketing, HR, Sales, Finance)
- 5 job roles (Analyst, Engineer, Manager, Specialist, Coordinator)
- 45+ employees with various roles and reporting structures

## Key Features

### Stored Procedures

1. **Update Salary by Performance**
   ```sql
   CALL emp_mgnt.update_salary_by_performance(employee_id, performance_rating);
   ```
   Updates employee salary based on performance rating:
   - 'Excellent': 10% increase
   - 'Good': 5% increase
   - 'Average': 2% increase

### Functions

1. **Get Department Employee Count**
   ```sql
   SELECT emp_mgnt.get_department_employee_count(department_id);
   ```
   Returns the total number of employees in a specific department.

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

2. **Find Long-term Employees (>5 years)**
   ```sql
   SELECT 
       e.name AS employee_name,
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_of_joining)) AS tenure_years
   FROM 
       emp_mgnt.employees e
   WHERE 
       EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_of_joining)) >= 5
   ORDER BY 
       tenure_years DESC;
   ```

3. **Department Average Salary**
   ```sql
   SELECT 
       d.name AS department,
       ROUND(AVG(e.salary), 2) AS average_salary
   FROM 
       emp_mgnt.departments d
   JOIN 
       emp_mgnt.employees e ON d.id = e.department_id
   GROUP BY 
       d.name
   ORDER BY 
       average_salary DESC;
   ```

## Best Practices

1. **Data Integrity**
   - Use appropriate constraints (NOT NULL, UNIQUE, CHECK)
   - Implement proper foreign key relationships
   - Maintain audit trails with create_date and update_date

2. **Performance**
   - Strategic indexing for common queries
   - Composite indexes for frequently combined filters
   - Self-referencing relationships for hierarchy

3. **Security**
   - Email uniqueness enforcement
   - Salary validation (must be positive)
   - Schema-based organization for better access control

## Version History

- v2.0: Enhanced documentation, added sample queries and best practices
- v1.0: Initial release with basic functionality