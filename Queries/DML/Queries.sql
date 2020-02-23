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