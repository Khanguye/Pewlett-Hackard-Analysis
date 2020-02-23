-- Retirement eligibility
SELECT first_name,last_name 
FROM employees 
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- Including hire_date
SELECT first_name,last_name 
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- COUNT number records
SELECT COUNT(*) 
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Dump Query items to a table
SELECT first_name,last_name 
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Export the table to CSV

-- Query data from the new table
SELECT * FROM retirement_info;
-- DROP BEFORE NEW DATA
DROP TABLE retirement_info;

-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Joining departments and dept_manager tables
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments d
INNER JOIN dept_manager dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info LEFT JOIN dept_employees
ON retirement_info.emp_no = dept_emp.emp_no;

-- Joining retirement_info and dept_emp tables
SELECT re.emp_no,
	re.first_name,
re.last_name,
	de.to_date
FROM retirement_info re
LEFT JOIN dept_employees de
ON re.emp_no = de.emp_no;

--- Dump current employees to table
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');
---
select * from retirement_info;
select * from current_emp;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO breakdown_department
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;


SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT emp_no,
	first_name,
last_name,
	gender
	INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

DROP TABLE emp_info

SELECT e.emp_no,
	e.first_name,
e.last_name,
	e.gender,
	s.salary,
	de.to_date
	INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	  AND (de.to_date = '9999-01-01');
	  
-----------
SELECT * FROM emp_info

-- List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
---------	
SELECT * FROM manager_info
---------------
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name	
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);


-- All employees are ready to retire
SELECT * FROM retirement_info

-- all Sale employees are ready to retire
SELECT emp.emp_no,
emp.first_name,
emp.last_name,
de.dept_name
INTO sale_emp_info
FROM Employees emp JOIN Dept_employees dep ON emp.emp_no = dep.emp_no
JOIN Departments de ON dep.dept_no = de.dept_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (emp.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND de.dept_name = 'Sales' 
ORDER BY dept_name, last_name, first_name

-- all Sale and Development employees are ready to retire
SELECT emp.emp_no,
emp.first_name,
emp.last_name,
de.dept_name
INTO sale_dev_emp_info
FROM Employees emp JOIN Dept_employees dep ON emp.emp_no = dep.emp_no
JOIN Departments de ON dep.dept_no = de.dept_no
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (emp.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND de.dept_name in  ('Sales','Development') 
ORDER BY dept_name, last_name, first_name

