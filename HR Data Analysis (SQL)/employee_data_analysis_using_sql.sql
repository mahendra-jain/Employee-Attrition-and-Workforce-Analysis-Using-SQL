# Employee Attrition and Workforce Analysis Using SQL

# Q1 Calculate the number of employees in each department.
select department, count(*) 
from employee_trends group by department;
/*
Sales 446
R&D	961
HR	63
*/
#---------------------------------------------------------------------------------------------
#Q2 Calcualte the average age for each department.
select department, round(avg(age)) 
from employee_trends group by department;
/*
Sales 37
R&D	37
HR	38
*/
#---------------------------------------------------------------------------------------------
# Q3 Identify the most common job roles in each department
select department,job_role, count(*) 
from employee_trends group by department,job_role;
/*
Sales	Sales Executive	326
R&D	Research Scientist	292
R&D	Laboratory Technician	259
R&D	Manufacturing Director	145
R&D	Healthcare Representative	131
Sales	Manager	37
Sales	Sales Representative	83
R&D	Research Director	80
R&D	Manager	54
HR	Human Resources	52
HR	Manager	11
*/
#---------------------------------------------------------------------------------------------
# Q4 Calculate the average job satisfaction for each education level
select education, round(avg(job_satisfaction),2) 
from employee_trends group by education;
/*
High School	2.80
Master's Degree	2.79
Associates Degree	2.77
Doctoral Degree	2.67
Bachelor's Degree	2.65
*/
#---------------------------------------------------------------------------------------------
# Q5 Determine the average age for employees with different levels of job satisfaction
select job_satisfaction, round(avg(age),2) 
from employee_trends group by job_satisfaction;
/*
4	36.80
2	36.99
3	37.02
1	36.92
*/
#---------------------------------------------------------------------------------------------
# Q6 Identify the age band with the highest average job satisfaction among married employees
select marital_status,age_band, 
round(avg(job_satisfaction),2) as avg_job_sat 
from employee_trends group by marital_status,age_band 
having marital_status='married' 
order by avg_job_sat DESC;
/*
Married	Under 25	2.77
Married	45 - 54	2.76
Married	25 - 34	2.72
Married	35 - 44	2.71
Married	Over 55	2.53
*/
#---------------------------------------------------------------------------------------------
#7 Calculate the attrition rate for each age band
select age_band, 
round(sum(case when attrition ='Yes' Then 1 Else 0 End)*100/count(*),2) as attrition_rate 
from employee_trends 
group by age_band 
order by attrition_rate DESC;
/*
Under 25 39.18
25 - 34	20.22
Over 55	15.94
45 - 54	10.20
35 - 44	10.10
*/
#---------------------------------------------------------------------------------------------
# Q8 Find the age band with the highest attrition rate among employees with a specific education level
select education, age_band, 
round(sum(case when attrition ='Yes' Then 1 Else 0 End)*100/count(*),2) as attrition_rate 
from employee_trends 
group by education, age_band 
order by attrition_rate DESC;
/*
Master's Degree	Under 25	50.00
Bachelor's Degree	Under 25	48.65
High School	Under 25	38.89
High School	Over 55	33.33
Master's Degree	25 - 34	23.31
Associates Degree	Under 25	22.73
Doctoral Degree	25 - 34	21.43
Master's Degree	Over 55	20.83
Bachelor's Degree	25 - 34	20.69
Associates Degree	Over 55	20.00
Associates Degree	25 - 34	18.56
High School	25 - 34	15.38
Associates Degree	45 - 54	15.38
Bachelor's Degree	35 - 44	12.44
Doctoral Degree	45 - 54	11.11
Associates Degree	35 - 44	10.89
Master's Degree	45 - 54	9.30
Master's Degree	35 - 44	8.50
Bachelor's Degree	45 - 54	8.33
Bachelor's Degree	Over 55	7.69
High School	45 - 54	7.14
High School	35 - 44	5.56
Doctoral Degree	35 - 44	4.55
Doctoral Degree	Over 55	0.00
*/
#---------------------------------------------------------------------------------------------
# Q9 Find the education level with the highest average job satisfaction among employees who travel frequently.
select education, 
round(avg(job_satisfaction),2) as avg_job_sat 
from employee_trends where business_travel= 'travel_frequently' 
group by education 
order by avg_job_sat DESC;
/*
Associates Degree	3.11
High School	3.08
Doctoral Degree	2.90
Master's Degree	2.85
Bachelor's Degree	2.52
*/
#---------------------------------------------------------------------------------------------
# Q10 How many active employees are there in each department? Display the result in descending order of headcount.
select department, 
count(case when active_employee=1 then 1 end) as active_employee 
from employee_trends 
group by department 
order by active_employee DESC;
/*
R&D	828
Sales 354
HR	51
*/
#---------------------------------------------------------------------------------------------
# Q11 What is the distribution of employees by gender and marital status? 
select gender,marital_status, count(*) 
from employee_trends 
group by gender,marital_status 
order by gender;
/*
Female	Divorced 117
Female	Married	272
Female	Single	199
Male	Divorced 210
Male	Married	401
Male	Single	271
*/
#---------------------------------------------------------------------------------------------
# Q12 Is there a correlation between business travel frequency and attrition? Show attrition rate by business travel category.
select business_travel, 
round(sum(CASE when attrition='yes' then 1 else 0 end)*100/count(*),2) as attrition_rate 
from employee_trends 
group by business_travel 
order by attrition_rate DESC;
/*
Travel_Frequently	24.91
Travel_Rarely	14.96
Non-Travel	8.00
*/
#---------------------------------------------------------------------------------------------
# Q13 List the number of inactive employees (active_employee = 0) by department and job role.
select department, job_role, 
count(CASE WHEN active_employee=0 then 1 end) as Inactive_employee 
from employee_trends 
group by department, job_role 
order by Inactive_employee DESC;
/*
R&D	Laboratory Technician	62
Sales	Sales Executive	57
R&D	Research Scientist	47
Sales	Sales Representative	33
HR	Human Resources	12
R&D	Manufacturing Director	10
R&D	Healthcare Representative	9
R&D	Manager	3
Sales	Manager	2
R&D	Research Director	2
HR	Manager	0
*/
#---------------------------------------------------------------------------------------------
# Q14 Compare attrition rates between male and female employees.
select gender, 
round(sum(case when attrition='yes' then 1 else 0 end)*100/count(*),2) as attrition_rate 
from employee_trends 
group by gender;
/*
Female	14.80
Male	17.01
*/
#---------------------------------------------------------------------------------------------
# Q15 Which education fields have the highest number of inactive employees?
select education_field, 
count(case when active_employee=0 then 1 end) as Inactive_employee 
from employee_trends 
group by education_field 
order by inactive_employee DESC;
/*
Life Sciences	89
Medical	63
Marketing	35
Technical Degree	32
Other	11
Human Resources	7
*/
#---------------------------------------------------------------------------------------------
