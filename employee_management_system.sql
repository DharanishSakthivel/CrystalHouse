-- Employee Management System PostgreSQL Schema
-- Created: 2025-03-30
-- Developer Name: Dharanish S
-- Comments: A comprehensive employee management system that handles employee data, departments, and job roles.

--Creating the Database

CREATE DATABASE employee_management;

--Create a Schema for the database for making the db objects as a organized way

CREATE SCHEMA emp_mgnt;

-- 1. Create Tables with Appropriate Data Types and Constraints

-- Departments Table
CREATE TABLE emp_mgnt.departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Job Roles Table
CREATE TABLE emp_mgnt.job_roles (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL UNIQUE,
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Employees Table
CREATE TABLE emp_mgnt.employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INTEGER NOT NULL REFERENCES departments(id),
    job_role_id INTEGER NOT NULL REFERENCES job_roles(id),
    salary NUMERIC(10, 2) NOT NULL CHECK (salary > 0),
    date_of_joining DATE NOT NULL,
    manager_id INTEGER REFERENCES employees(id),
    create_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create Indexes for Performance Optimization

-- Index on department_id for faster joins and filtering
CREATE INDEX idx_employees_department_id ON emp_mgnt.employees(department_id);

-- Index on job_role_id for faster joins and filtering
CREATE INDEX idx_employees_job_role_id ON emp_mgnt.employees(job_role_id);

-- Index on manager_id for faster reporting structure queries
CREATE INDEX idx_employees_manager_id ON emp_mgnt.employees(manager_id);

-- Index on date_of_joining for tenure-based queries
CREATE INDEX idx_employees_date_of_joining ON emp_mgnt.employees(date_of_joining);

-- 3. Insert Sample Data

-- Insert Departments
INSERT INTO emp_mgnt.departments (name) VALUES
('Engineering'),
('Marketing'),
('HR'),
('Sales'),
('Finance');

-- Insert Job Roles
INSERT INTO emp_mgnt.job_roles (title) VALUES
('Analyst'),
('Engineer'),
('Manager'),
('Specialist'),
('Coordinator');

-- Insert Employees
-- First, we need to insert employees without manager_id (to avoid circular references)
-- Then update with manager_id in a separate step

-- Insert employees without manager_id first
INSERT INTO emp_mgnt.employees (name, email, department_id, job_role_id, salary, date_of_joining, manager_id)
VALUES
-- Engineering Department
('Amanda Hughes', 'amanda.hughes@example.com', 1, 1, 92273.81, '2023-03-17', NULL),
('Kristina Leblanc', 'kristina.leblanc@example.com', 1, 2, 77169.46, '2015-05-26', NULL),
('Rebecca Floyd', 'rebecca.floyd@example.com', 1, 5, 117010.95, '2016-07-16', NULL),
('Kristine Wilson', 'kristine.wilson@example.com', 1, 3, 102958.00, '2018-02-07', NULL),
('Phillip Johnson', 'phillip.johnson@example.com', 1, 2, 66778.17, '2018-01-23', NULL),
('David Pugh', 'david.pugh@example.com', 1, 1, 56968.57, '2020-07-24', NULL),
('Brandon Hodges', 'brandon.hodges@example.com', 1, 1, 72549.15, '2015-07-16', NULL),
('Alicia Atkinson', 'alicia.atkinson@example.com', 1, 2, 101409.00, '2018-09-09', NULL),
('Anthony Jenkins', 'anthony.jenkins@example.com', 1, 4, 100366.08, '2022-09-09', NULL),
('Micheal Lee', 'micheal.lee@example.com', 1, 3, 102325.22, '2017-01-22', NULL),
('Daniel Mays', 'daniel.mays@example.com', 1, 5, 118336.30, '2019-11-23', NULL),
('Michael Cooke', 'michael.cooke@example.com', 1, 2, 65109.44, '2016-04-15', NULL),
('Arthur Murphy', 'arthur.murphy@example.com', 1, 3, 99242.22, '2016-12-25', NULL),

-- Marketing Department
('Alexa Livingston', 'alexa.livingston@example.com', 2, 2, 84993.13, '2021-02-13', NULL),
('Marie Taylor', 'marie.taylor@example.com', 2, 2, 60763.41, '2022-12-26', NULL),
('Chase Myers', 'chase.myers@example.com', 2, 2, 98958.76, '2023-11-09', NULL),
('Richard Taylor', 'richard.taylor@example.com', 2, 4, 89678.20, '2022-02-06', NULL),
('Steven Jones', 'steven.jones@example.com', 2, 2, 111583.03, '2018-04-13', NULL),
('Scott Curtis', 'scott.curtis@example.com', 2, 1, 98900.59, '2015-04-24', NULL),
('Jesse Jackson', 'jesse.jackson@example.com', 2, 3, 111750.01, '2023-08-23', NULL),
('Jessica Walker', 'jessica.walker@example.com', 2, 1, 58311.79, '2019-06-08', NULL),
('Andrew Gomez', 'andrew.gomez@example.com', 2, 3, 75555.78, '2015-05-25', NULL),

-- HR Department
('David Parks', 'david.parks@example.com', 3, 1, 92073.05, '2020-07-11', NULL),
('Douglas Gonzales', 'douglas.gonzales@example.com', 3, 2, 110067.02, '2017-01-16', NULL),
('Vincent Henderson', 'vincent.henderson@example.com', 3, 3, 53886.59, '2017-10-21', NULL),
('Anthony Duke', 'anthony.duke@example.com', 3, 4, 71759.69, '2015-03-28', NULL),
('Hannah Stevens', 'hannah.stevens@example.com', 3, 2, 64883.88, '2017-12-19', NULL),
('Dylan Robinson', 'dylan.robinson@example.com', 3, 3, 58278.81, '2019-02-14', NULL),
('Jesse Kennedy', 'jesse.kennedy@example.com', 3, 5, 64976.05, '2023-02-08', NULL),
('Renee Chan', 'renee.chan@example.com', 3, 4, 68429.08, '2021-10-25', NULL),
('Stephanie Martinez', 'stephanie.martinez@example.com', 3, 3, 88810.18, '2018-07-05', NULL),
('Miranda Hayes', 'miranda.hayes@example.com', 3, 3, 97148.61, '2015-08-07', NULL),
('Kyle Patel', 'kyle.patel@example.com', 3, 3, 80898.81, '2024-03-03', NULL),
('William Warren', 'william.warren@example.com', 3, 4, 75269.55, '2023-09-18', NULL),

-- Sales Department
('Jack Smith', 'jack.smith@example.com', 4, 2, 87016.08, '2022-04-03', NULL),
('Scott Chavez', 'scott.chavez@example.com', 4, 2, 71349.22, '2021-04-30', NULL),
('Lisa Harris', 'lisa.harris@example.com', 4, 4, 56459.14, '2021-04-04', NULL),
('David Nixon', 'david.nixon@example.com', 4, 3, 81440.61, '2020-06-25', NULL),
('Jason Kramer', 'jason.kramer@example.com', 4, 2, 79069.59, '2023-02-14', NULL),
('Nicholas Wagner', 'nicholas.wagner@example.com', 4, 5, 109957.08, '2020-11-29', NULL),

-- Finance Department
('Hannah Rodgers', 'hannah.rodgers@example.com', 5, 2, 94025.49, '2022-03-04', NULL),
('Luis Hopkins', 'luis.hopkins@example.com', 5, 5, 56527.20, '2019-05-17', NULL),
('Sharon Ford', 'sharon.ford@example.com', 5, 1, 54675.42, '2023-10-29', NULL),
('Matthew Carlson', 'matthew.carlson@example.com', 5, 5, 96571.99, '2017-04-19', NULL),
('Tammy Johnson', 'tammy.johnson@example.com', 5, 2, 63109.79, '2022-12-14', NULL),
('Derek Trujillo', 'derek.trujillo@example.com', 5, 1, 72242.68, '2020-11-02', NULL),
('Nicolas Willis', 'nicolas.willis@example.com', 5, 3, 59259.04, '2018-10-18', NULL),
('Steven Valencia', 'steven.valencia@example.com', 5, 3, 98523.14, '2017-03-19', NULL),
('Charles Carney', 'charles.carney@example.com', 5, 4, 75400.26, '2020-12-05', NULL),
('Melissa Williams', 'melissa.williams@example.com', 5, 1, 50851.82, '2017-05-06', NULL);

-- Update manager_id based on manager names from the sample data
-- For simplicity, we'll use a direct update approach
-- In a real system, we might want to use a more sophisticated approach

-- Update for David Pugh as manager
UPDATE emp_mgnt.employees
SET manager_id = (SELECT id FROM emp_mgnt.employees WHERE name = 'David Pugh')
WHERE name IN (
    'Amanda Hughes',
    'Jack Smith',
    'Kristina Leblanc',
    'Phillip Johnson',
    'Brandon Hodges',
    'Hannah Rodgers',
    'Matthew Carlson',
    'Micheal Lee',
    'Stephanie Martinez',
    'William Warren'
);

-- Update for Luis Hopkins as manager
UPDATE emp_mgnt.employees
SET manager_id = (SELECT id FROM emp_mgnt.employees WHERE name = 'Luis Hopkins')
WHERE name IN (
    'Alexa Livingston',
    'Marie Taylor',
    'Jessica Walker',
    'Melissa Williams',
    'Jason Kramer'
);

-- Update for Dylan Robinson as manager
UPDATE emp_mgnt.employees
SET manager_id = (SELECT id FROM emp_mgnt.employees WHERE name = 'Dylan Robinson')
WHERE name IN (
    'Douglas Gonzales',
    'Chase Myers',
    'Hannah Stevens',
    'Rebecca Floyd',
    'David Pugh',
    'Tammy Johnson',
    'Derek Trujillo',
    'Renee Chan',
    'Steven Valencia',
    'Anthony Jenkins',
    'Daniel Mays',
    'Michael Cooke',
    'Miranda Hayes',
    'Kyle Patel',
    'Sharon Ford'
);

-- Update for Kristine Wilson as manager
UPDATE emp_mgnt.employees
SET manager_id = (SELECT id FROM emp_mgnt.employees WHERE name = 'Kristine Wilson')
WHERE name IN (
    'Scott Chavez',
    'Richard Taylor',
    'Anthony Duke',
    'Lisa Harris',
    'Arthur Murphy',
    'Scott Curtis',
    'Jesse Jackson',
    'David Nixon',
    'Charles Carney',
    'Nicholas Wagner',
    'Jesse Kennedy'
);

-- Update for William Warren as manager
UPDATE emp_mgnt.employees
SET manager_id = (SELECT id FROM emp_mgnt.employees WHERE name = 'William Warren')
WHERE name IN (
    'Vincent Henderson',
    'Steven Jones',
    'Nicolas Willis',
    'Alicia Atkinson',
    'Andrew Gomez'
);

-- Self-referencing managers (managers who manage themselves)
UPDATE emp_mgnt.employees
SET manager_id = id
WHERE name IN (
    'Luis Hopkins',
    'Kristine Wilson',
    'Dylan Robinson'
);

-- 4. SQL Queries

-- Query 1: List all employees with their department name and job role title
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

-- Query 2: Find employees who have been with the company for more than 5 years
SELECT 
    e.name AS employee_name,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_of_joining)) AS tenure_years
FROM 
    emp_mgnt.employees e
WHERE 
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.date_of_joining)) >= 5
ORDER BY 
    tenure_years DESC;

-- Query 3: Calculate the average salary per department
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

-- Query 4: Retrieve employees who report to a specific manager (e.g., 'David Pugh')
SELECT 
    e.name,
    e.email,
    e.salary
FROM 
    emp_mgnt.employees e
JOIN 
    emp_mgnt.employees m ON e.manager_id = m.id
WHERE 
    m.name = 'David Pugh'  -- Replace with desired manager name
ORDER BY 
    e.name;

-- Query 5: Retrieve the top 5 highest-paid employees
SELECT 
    e.name,
    e.salary
FROM 
    emp_mgnt.employees e
ORDER BY 
    e.salary DESC
LIMIT 5;


-- 5. Stored Procedure & Function

-- Stored Procedure to update employee salary based on performance rating
CREATE OR REPLACE PROCEDURE emp_mgnt.update_salary_by_performance(
    employee_id INTEGER,
    performance_rating VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    current_salary NUMERIC;
    increase_percentage NUMERIC;
    new_salary NUMERIC;
BEGIN
    -- Get current salary
    SELECT salary INTO current_salary FROM emp_mgnt.employees WHERE id = employee_id;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Employee with ID % not found', employee_id;
    END IF;
    
    -- Determine increase percentage based on performance rating
    CASE performance_rating
        WHEN 'Excellent' THEN increase_percentage := 0.10;  -- 10% increase
        WHEN 'Good' THEN increase_percentage := 0.05;       -- 5% increase
        WHEN 'Average' THEN increase_percentage := 0.02;    -- 2% increase
        ELSE increase_percentage := 0;                      -- No increase for other ratings
    END CASE;
    
    -- Calculate new salary
    new_salary := current_salary * (1 + increase_percentage);
    
    -- Update employee salary
    UPDATE emp_mgnt.employees
    SET 
        salary = new_salary,
        update_date = CURRENT_TIMESTAMP
    WHERE 
        id = employee_id;
        
    -- Output the results
    RAISE NOTICE 'Employee ID: %, Old Salary: %, Performance Rating: %, Increase: % percent, New Salary: %',
        employee_id, current_salary, performance_rating, increase_percentage * 100, new_salary;
END;
$$;

-- Function to return the total number of employees in a specific department
CREATE OR REPLACE FUNCTION emp_mgnt.get_department_employee_count(dept_id INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
DECLARE
    employee_count INTEGER;
BEGIN
    SELECT COUNT(*) INTO employee_count
    FROM emp_mgnt.employees
    WHERE department_id = dept_id;
    
    RETURN employee_count;
END;
$$;

-- 6. Additional Indexes for Performance Optimization

-- Composite index for salary range queries and sorting
CREATE INDEX idx_employees_salary ON emp_mgnt.employees(salary DESC);

-- Composite index for department and job role filtering
CREATE INDEX idx_employees_dept_job ON emp_mgnt.employees(department_id, job_role_id);

-- Index for email lookups (common in authentication systems)
CREATE INDEX idx_employees_email ON emp_mgnt.employees(email);
