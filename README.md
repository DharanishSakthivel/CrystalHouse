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

Schema has been created for making tables, store procedure, functions in the organized way. 

CREATE SCHEMA emp_mgnt;

The system uses PostgreSQL with the following structure:

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

## Data Processing

The system includes a Python script (`read_excel.py`) that:
- Reads employee data from Excel files
- Processes and validates the data
- Exports the data to JSON format for easy integration

## Project Structure

- `employee_management_system.sql`: Database schema definition
- `read_excel.py`: Data processing script
- `Sheet1_data.json`: Processed employee data
- `Attachments/`: Contains source data files

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

### Sample Outputs of the SQL Queries

Query 1: List all employees with their department name and job role title

| employee_name      | department  | job_role    |
| ------------------ | ----------- | ----------- |
| Alexa Livingston   | Marketing   | Engineer    |
| Alicia Atkinson    | Engineering | Engineer    |
| Amanda Hughes      | Engineering | Analyst     |
| Andrew Gomez       | Marketing   | Manager     |
| Anthony Duke       | HR          | Specialist  |
| Anthony Jenkins    | Engineering | Specialist  |
| Arthur Murphy      | Engineering | Manager     |
| Brandon Hodges     | Engineering | Analyst     |
| Charles Carney     | Finance     | Specialist  |
| Chase Myers        | Marketing   | Engineer    |
| Daniel Mays        | Engineering | Coordinator |
| David Nixon        | Sales       | Manager     |
| David Parks        | HR          | Analyst     |
| David Pugh         | Engineering | Analyst     |
| Derek Trujillo     | Finance     | Analyst     |
| Douglas Gonzales   | HR          | Engineer    |
| Dylan Robinson     | HR          | Manager     |
| Hannah Rodgers     | Finance     | Engineer    |
| Hannah Stevens     | HR          | Engineer    |
| Jack Smith         | Sales       | Engineer    |
| Jason Kramer       | Sales       | Engineer    |
| Jesse Jackson      | Marketing   | Manager     |
| Jesse Kennedy      | HR          | Coordinator |
| Jessica Walker     | Marketing   | Analyst     |
| Kristina Leblanc   | Engineering | Engineer    |
| Kristine Wilson    | Engineering | Manager     |
| Kyle Patel         | HR          | Manager     |
| Lisa Harris        | Sales       | Specialist  |
| Luis Hopkins       | Finance     | Coordinator |
| Marie Taylor       | Marketing   | Engineer    |
| Matthew Carlson    | Finance     | Coordinator |
| Melissa Williams   | Finance     | Analyst     |
| Michael Cooke      | Engineering | Engineer    |
| Micheal Lee        | Engineering | Manager     |
| Miranda Hayes      | HR          | Manager     |
| Nicholas Wagner    | Sales       | Coordinator |
| Nicolas Willis     | Finance     | Manager     |
| Phillip Johnson    | Engineering | Engineer    |
| Rebecca Floyd      | Engineering | Coordinator |
| Renee Chan         | HR          | Specialist  |
| Richard Taylor     | Marketing   | Specialist  |
| Scott Chavez       | Sales       | Engineer    |
| Scott Curtis       | Marketing   | Analyst     |
| Sharon Ford        | Finance     | Analyst     |
| Stephanie Martinez | HR          | Manager     |
| Steven Jones       | Marketing   | Engineer    |
| Steven Valencia    | Finance     | Manager     |
| Tammy Johnson      | Finance     | Engineer    |
| Vincent Henderson  | HR          | Manager     |
| William Warren     | HR          | Specialist  |

Query 2: Find employees who have been with the company for more than 5 years

| employee_name      | tenure_years |
| ------------------ | ------------ |
| Anthony Duke       | 10           |
| Brandon Hodges     | 9            |
| Kristina Leblanc   | 9            |
| Miranda Hayes      | 9            |
| Scott Curtis       | 9            |
| Andrew Gomez       | 9            |
| Rebecca Floyd      | 8            |
| Michael Cooke      | 8            |
| Steven Valencia    | 8            |
| Arthur Murphy      | 8            |
| Micheal Lee        | 8            |
| Douglas Gonzales   | 8            |
| Phillip Johnson    | 7            |
| Vincent Henderson  | 7            |
| Matthew Carlson    | 7            |
| Hannah Stevens     | 7            |
| Kristine Wilson    | 7            |
| Melissa Williams   | 7            |
| Dylan Robinson     | 6            |
| Alicia Atkinson    | 6            |
| Steven Jones       | 6            |
| Nicolas Willis     | 6            |
| Stephanie Martinez | 6            |
| Jessica Walker     | 5            |
| Luis Hopkins       | 5            |
| Daniel Mays        | 5            |

Query 3: Calculate the average salary per department

| department  | average_salary |
| ----------- | -------------- |
| Engineering | 90192.03       |
| Marketing   | 87832.74       |
| Sales       | 80881.95       |
| HR          | 77206.78       |
| Finance     | 72118.68       |

Query 4: Retrieve employees who report to a specific manager (e.g., 'David Pugh')

| name               | email                          | salary    |
| ------------------ | ------------------------------ | --------- |
| Amanda Hughes      | amanda.hughes@example.com      | 92273.81  |
| Brandon Hodges     | brandon.hodges@example.com     | 72549.15  |
| Hannah Rodgers     | hannah.rodgers@example.com     | 94025.49  |
| Jack Smith         | jack.smith@example.com         | 87016.08  |
| Kristina Leblanc   | kristina.leblanc@example.com   | 77169.46  |
| Matthew Carlson    | matthew.carlson@example.com    | 96571.99  |
| Micheal Lee        | micheal.lee@example.com        | 102325.22 |
| Phillip Johnson    | phillip.johnson@example.com    | 66778.17  |
| Stephanie Martinez | stephanie.martinez@example.com | 88810.18  |
| William Warren     | william.warren@example.com     | 75269.55  |

Query 5: Retrieve the top 5 highest-paid employees

| name             | salary    |
| ---------------- | --------- |
| Daniel Mays      | 118336.30 |
| Rebecca Floyd    | 117010.95 |
| Jesse Jackson    | 111750.01 |
| Steven Jones     | 111583.03 |
| Douglas Gonzales | 110067.02 |
