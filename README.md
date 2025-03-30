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

| id | employee_name      | department_name | job_role    |
| -- | ------------------ | --------------- | ----------- |
| 14 | Alexa Livingston   | Marketing       | Engineer    |
| 8  | Alicia Atkinson    | Engineering     | Engineer    |
| 1  | Amanda Hughes      | Engineering     | Analyst     |
| 22 | Andrew Gomez       | Marketing       | Manager     |
| 26 | Anthony Duke       | HR              | Specialist  |
| 9  | Anthony Jenkins    | Engineering     | Specialist  |
| 13 | Arthur Murphy      | Engineering     | Manager     |
| 7  | Brandon Hodges     | Engineering     | Analyst     |
| 49 | Charles Carney     | Finance         | Specialist  |
| 16 | Chase Myers        | Marketing       | Engineer    |
| 11 | Daniel Mays        | Engineering     | Coordinator |
| 38 | David Nixon        | Sales           | Manager     |
| 23 | David Parks        | HR              | Analyst     |
| 6  | David Pugh         | Engineering     | Analyst     |
| 46 | Derek Trujillo     | Finance         | Analyst     |
| 24 | Douglas Gonzales   | HR              | Engineer    |
| 28 | Dylan Robinson     | HR              | Manager     |
| 41 | Hannah Rodgers     | Finance         | Engineer    |
| 27 | Hannah Stevens     | HR              | Engineer    |
| 35 | Jack Smith         | Sales           | Engineer    |
| 39 | Jason Kramer       | Sales           | Engineer    |
| 20 | Jesse Jackson      | Marketing       | Manager     |
| 29 | Jesse Kennedy      | HR              | Coordinator |
| 21 | Jessica Walker     | Marketing       | Analyst     |
| 2  | Kristina Leblanc   | Engineering     | Engineer    |
| 4  | Kristine Wilson    | Engineering     | Manager     |
| 33 | Kyle Patel         | HR              | Manager     |
| 37 | Lisa Harris        | Sales           | Specialist  |
| 42 | Luis Hopkins       | Finance         | Coordinator |
| 15 | Marie Taylor       | Marketing       | Engineer    |
| 44 | Matthew Carlson    | Finance         | Coordinator |
| 50 | Melissa Williams   | Finance         | Analyst     |
| 12 | Michael Cooke      | Engineering     | Engineer    |
| 10 | Micheal Lee        | Engineering     | Manager     |
| 32 | Miranda Hayes      | HR              | Manager     |
| 40 | Nicholas Wagner    | Sales           | Coordinator |
| 47 | Nicolas Willis     | Finance         | Manager     |
| 5  | Phillip Johnson    | Engineering     | Engineer    |
| 3  | Rebecca Floyd      | Engineering     | Coordinator |
| 30 | Renee Chan         | HR              | Specialist  |
| 17 | Richard Taylor     | Marketing       | Specialist  |
| 36 | Scott Chavez       | Sales           | Engineer    |
| 19 | Scott Curtis       | Marketing       | Analyst     |
| 43 | Sharon Ford        | Finance         | Analyst     |
| 31 | Stephanie Martinez | HR              | Manager     |
| 18 | Steven Jones       | Marketing       | Engineer    |
| 48 | Steven Valencia    | Finance         | Manager     |
| 45 | Tammy Johnson      | Finance         | Engineer    |
| 25 | Vincent Henderson  | HR              | Manager     |
| 34 | William Warren     | HR              | Specialist  |

Query 2: Find employees who have been with the company for more than 5 years

| id | employee_name      | tenure_years |
| -- | ------------------ | ------------ |
| 26 | Anthony Duke       | 10           |
| 7  | Brandon Hodges     | 9            |
| 2  | Kristina Leblanc   | 9            |
| 32 | Miranda Hayes      | 9            |
| 19 | Scott Curtis       | 9            |
| 22 | Andrew Gomez       | 9            |
| 3  | Rebecca Floyd      | 8            |
| 12 | Michael Cooke      | 8            |
| 48 | Steven Valencia    | 8            |
| 13 | Arthur Murphy      | 8            |
| 10 | Micheal Lee        | 8            |
| 24 | Douglas Gonzales   | 8            |
| 5  | Phillip Johnson    | 7            |
| 25 | Vincent Henderson  | 7            |
| 44 | Matthew Carlson    | 7            |
| 27 | Hannah Stevens     | 7            |
| 4  | Kristine Wilson    | 7            |
| 50 | Melissa Williams   | 7            |
| 28 | Dylan Robinson     | 6            |
| 8  | Alicia Atkinson    | 6            |
| 18 | Steven Jones       | 6            |
| 47 | Nicolas Willis     | 6            |
| 31 | Stephanie Martinez | 6            |
| 21 | Jessica Walker     | 5            |
| 42 | Luis Hopkins       | 5            |
| 11 | Daniel Mays        | 5            |

Query 3: Calculate the average salary per department

| department  | average_salary |
| ----------- | -------------- |
| Engineering | 90192.03       |
| Marketing   | 87832.74       |
| Sales       | 80881.95       |
| HR          | 77206.78       |
| Finance     | 72118.68       |

Query 4: Retrieve employees who report to a specific manager (e.g., 'David Pugh')

| employee_id | employee_name      | manager_name |
| ----------- | ------------------ | ------------ |
| 1           | Amanda Hughes      | David Pugh   |
| 7           | Brandon Hodges     | David Pugh   |
| 41          | Hannah Rodgers     | David Pugh   |
| 35          | Jack Smith         | David Pugh   |
| 2           | Kristina Leblanc   | David Pugh   |
| 44          | Matthew Carlson    | David Pugh   |
| 10          | Micheal Lee        | David Pugh   |
| 5           | Phillip Johnson    | David Pugh   |
| 31          | Stephanie Martinez | David Pugh   |
| 34          | William Warren     | David Pugh   |

Query 5: Retrieve the top 5 highest-paid employees

| id | name             | salary    |
| -- | ---------------- | --------- |
| 11 | Daniel Mays      | 118336.30 |
| 3  | Rebecca Floyd    | 117010.95 |
| 20 | Jesse Jackson    | 111750.01 |
| 18 | Steven Jones     | 111583.03 |
| 24 | Douglas Gonzales | 110067.02 |
