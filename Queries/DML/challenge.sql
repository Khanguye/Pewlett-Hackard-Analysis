/*** Get All Titles Retiring ***/
-- - Need to inner join to tables: Employees, Titles, Salaries
-- - Find poeple were born between 1952-01-01 AND 1955-12-31
-- - And hired date between 1985-01-01 AND 1988-12-31
-- - And current employee so the title to_date is 9999-01-01
-- - Select Columns:
-- 1- Employee Number from Employees
-- 2- First Name from Employees
-- 3- Last Name from Employees
-- 4- Title from Titles
-- 5- From Date from Titles
-- 6- Salary from Salaries
-- - Create all_titles_retiring table 
SELECT 
	e.emp_no, e.first_name, e.last_name, t.title, t.from_date, s.salary
INTO all_titles_retiring
FROM
	public.employees as e 
	INNER JOIN public.titles as t ON e.emp_no = t.emp_no 
	INNER JOIN public.salaries as s ON e.emp_no = s.emp_no
WHERE 
	(e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (t.to_date = '9999-01-01');
-- 33118 rows 

/*** Only the Most Recent Titles of retirings ***/
-- Create a Common Table Expressions: is a temporary table during execute SQL expressions 
-- Row_Number() is increased for each data row execute, however it can  be increased or reset back over the Partition data
-- Partition data is grouping data in the similar information and oragnized by particular data order
-- so that Row_Number() can be increased in the same group data rows and reset back value when the new group data is next
-- Order_Number keeps Row_number() in the each partition
WITH titles_retiring AS(
SELECT 
	emp_no, first_name, last_name, title, from_date, salary, 
	Row_Number() Over (Partition By emp_no ORDER BY from_date DESC) AS Order_Number 
FROM 
	public.all_titles_retiring
)
-- Each employee may have many different job titles in the career. 
-- Order_Number are used to indicate many job titles. 
-- It is running from 1(one) to many where 1(one) is the most recent job title.
-- Count titles where the Order_Number = 1 (recent title) 
-- Group by title and order in alphabet order
SELECT 
	title, COUNT(Title) 
INTO title_counts
FROM
	titles_retiring
WHERE 
	Order_Number = 1
GROUP BY 
	title
ORDER BY 
	title;
-- 7 rows


--- Alternative way: all_titles_retiring table only keeps the final title so we do not need to do PARTITION
SELECT 
	title, COUNT(Title) 
--INTO title_counts
FROM
	all_titles_retiring
GROUP BY 
	title
ORDER BY 
	title;
-- 7 rows

/*** Who’s Ready for a Mentor? ***/
-- Find all employees are born between 1965-01-01 and 1965-12-31
-- And also current are employee (to_date = '9999-01-01')
--- Need to join to tables: Employees, Titles
--- Employees, Titles on Employee Number (Each current employee has a recent title at Pewlett Hackard by Employee Number)
SELECT 
	e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO ready_become_mentors
FROM
	public.employees AS e
	INNER JOIN public.titles AS t on e.emp_no = t.emp_no
WHERE 
	e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
	AND t.to_date = '9999-01-01'
ORDER BY 
	e.last_name, e.first_name;
-- 1549 rows


--Potential Hirings or Remotings needs to fill up
--Columns: Titles, Retiring Titles, Mentoring Titles
--Need to LEFT JOIN for title_counts
With titles_mentors as (
SELECT Title, Count(Title) FROM ready_become_mentors
GROUP BY Title
Order by title
	)
Select
tr.title, tr.count as retiring_title, tm.count as mentoring_titles
into side_by_side_titles
FROM
title_counts as tr LEFT JOIN 
titles_mentors tm ON tr.title = tm.title
Order By tr.title

-- Salary Statistics of Retiring employees
With salary_stats as (
SELECT 'Assistant Engineer' as Title, Min(salary), Max(salary), Avg(salary),Count(salary),SUM(salary) FROM  All_Titles_Retiring where title in ('Assistant Engineer')
UNION
SELECT 'Engineer' as Title, Min(salary), Max(salary), Avg(salary),Count(salary),SUM(salary) FROM  All_Titles_Retiring where title in ('Engineer')
UNION
SELECT 'Manager' as Title, Min(salary), Max(salary), Avg(salary),Count(salary),SUM(salary) FROM  All_Titles_Retiring where title in ('Manager')
UNION
SELECT 'Senior Engineer' as Title, Min(salary), Max(salary), Avg(salary),Count(salary),SUM(salary) FROM  All_Titles_Retiring where title in ('Senior Engineer')
UNION
SELECT 'Senior Staff' as Title, Min(salary), Max(salary), Avg(salary),Count(salary),SUM(salary) FROM  All_Titles_Retiring where title in ('Senior Staff')
UNION
SELECT 'Staff' as Title, Min(salary), Max(salary), Avg(salary),Count(salary),SUM(salary) FROM  All_Titles_Retiring where title in ('Staff')
UNION
SELECT 'Technique Leader' as Title, Min(salary), Max(salary), Avg(salary),Count(salary),SUM(salary) FROM  All_Titles_Retiring where title in ('Technique Leader')
)
SELECT * 
into salary_stats_retiring_employees
FROM salary_stats;