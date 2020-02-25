# Pewlett Hackard Analysis

### Project Summary

To create the new list of potential mentors, we need to create a query that returns a list of current employees eligible for retirement, as well as their most recent titles

1- a list of current employees eligible for retirement: "Number of titles-Retiring"
2- a list of most recent titles: "The Most Recent Titles"
3- a list of potential mentors: "Who’s Ready for a Mentor?"

### ERD Pewlett Hackard Employees

***Image***

![ERD_PH](ERD_PH.png)

***Scripts edit on [QuickDBD](https://app.quickdatabasediagrams.com)***

```
Departments
-
dept_no varchar PK
dept_name varchar

Employees
-
emp_no int PK 
birthday_date date
first_name varchar
last_name varchar
gender varchar
hire_date date

Dept_manager
-
dept_no varchar PK FK - Departments.dept_no
emp_no int PK FK - Employees.emp_no
from_date date
to_date date

Salaries
-
emp_no int PK FK - Employees.emp_no
salary int
from_date date
to_date date

Titles
-
emp_no int PK FK >- Employees.emp_no
title varchar
from_date date PK
to_date date

Dept_emp
-
emp_no int PK FK >- Employees.emp_no
dept_no varchar PK FK >- Departments.dept_no
from_date date
to_date date
```
***SQL Scripts to create tables and relationships***

[Schema Files](Queries/DDL/schema.sql)

***QUESTION 1:*** A list of current employees eligible for retirement include titles: "Number of titles-Retiring"

***Required Columns:*** 

- Employee number
- First and last name
- Title
- from_date
- Salary

***Plan To Queries:***

***ERD-Explore Plan***

!(All_Title_Retiring)[All_Titles_Retiring_ERD.png]

***Plan to execute with SQL***

- Need to inner join to tables: Employees, Titles, Salaries
- Find poeple were born between 1952-01-01 AND 1955-12-31
- And hired date between 1985-01-01 AND 1988-12-31
- And current employee so the title to_date is 9999-01-01
- Select Columns:
1- Employee Number from Employees
2- First Name from Employees
3- Last Name from Employees
4- Title from Titles
5- From Date from Titles
6- Salary from Salaries
- Create all_titles_retiring table 
```
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
```
***Image Top 20 all_titles_retiring rows***
!(All_Titles_Retiring)[All_Titles_Retiring.png]
***Total Results: 33118 rows*** 


