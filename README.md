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
'''
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
'''
***SQL Scripts to create tables and relationships***
[Schema Files](Queries/DDL/schema.sql)

