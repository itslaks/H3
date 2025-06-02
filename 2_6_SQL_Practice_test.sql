create database dataset;

use dataset;

-- Create Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Create Projects Table
CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    start_date DATE,
    end_date DATE
);

-- Create Employees Table with Foreign Keys
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    join_date DATE,
    manager_id INT,
    project_id INT NULL,
    CONSTRAINT fk_project FOREIGN KEY (project_id) REFERENCES projects(project_id)
);


-- Departments
INSERT INTO departments VALUES 
(1, 'IT'), (2, 'HR'), (3, 'Finance'), (4, 'Sales'), (5, 'Marketing'), (6, 'strategy Analyzer');

-- Projects
INSERT INTO projects VALUES
(101, 'Apollo', '2023-01-01', '2023-12-31'),
(102, 'Zeus', '2022-06-01', '2023-05-31'),
(103, 'Hermes', '2024-01-15', '2024-12-15'),
(104, 'Hendry', '2025-02-10','2025-05-12'),
(105, 'Ronald', '2024-02-10','2025-04-12');

-- Employees
INSERT INTO employees VALUES
(1, 'Alice', 'Smith', 'IT', 90000, '2022-01-15', NULL, 101),
(2, 'Bob', 'Singh', 'strategy Analyzer', 88000, '2021-12-01', 1, 102),
(3, 'Carol', 'Suresh', 'Finance', 60000, '2023-03-12', 1, NULL),
(4, 'David', 'Jones', 'HR', 55000, '2024-04-10', 2, 104),
(5, 'Eva', 'Brown', 'Sales', 40000, '2023-06-20', 2, 103),
(6, 'Frank', 'Stone', NULL, 75000, '2020-08-01', NULL, NULL),
(7, 'Grace', 'Sharma', 'IT', 88000, '2021-01-10', 1, 105),
(8, 'Hank', 'Lee', 'HR', 39000, '2024-01-05', 4, NULL),
(9, 'Ivy', 'Sinha', 'Finance', 62000, '2023-09-15', 3, 101),
(10, 'John', 'Doe', 'Marketing', 90000, '2022-10-10', 1, 102);


--1. Find employees whose last name starts with 'S'.
SELECT first_name , last_name from employees where last_name LIKE 's%';

-- 2. Display first_name and last_name concatenated as full_name in uppercase.
SELECT UPPER(first_name + ' ' + last_name) AS full_name
FROM employees;

--3. Show employees with a 5-character first name.
SELECT first_name , last_name FROM employees WHERE LEN(first_name) = 5;



--4. List employees who joined in the last 2 years.
SELECT * FROM employees
WHERE join_date >= DATEADD(YEAR, -2, GETDATE());

--5. Show number of days since each employee joined.
SELECT first_name, last_name, DATEDIFF(DAY, join_date, GETDATE()) AS days_worked
FROM employees;

-- 6. Find the month name and year from each employee's join_date.
SELECT DATENAME(MONTH, join_date) AS join_month, YEAR(join_date) AS join_year
FROM employees;




-- 7. Round off each employee's salary to the nearest thousand.
SELECT first_name, last_name, FLOOR(salary / 1000.0) * 1000 AS round_off_salary
FROM employees;

-- 8. Find employees whose salary is above the average salary.
SELECT * FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 9. Show absolute difference from company average salary.
SELECT first_name, last_name, ABS(salary - (SELECT AVG(salary) FROM employees)) AS diff_from_avg
FROM employees;

-- 10. Find departments with more than 3 employees.
SELECT department, emp_count FROM (
  SELECT department, COUNT(*) AS emp_count
  FROM employees
  GROUP BY department) AS temp
WHERE emp_count > 3;

--11. Show total and average salary per department with avg salary > 60000.
SELECT department, SUM(salary) AS total_salary, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;



-- 12. Find the employee(s) with the maximum salary.
SELECT * FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- 13. List employees earning more than avg salary in their department.
SELECT * FROM employees e
WHERE salary > (
    SELECT AVG(salary) FROM employees
    WHERE department = e.department
);

--14. Show employees who joined before the earliest join date in IT.
SELECT * FROM employees
WHERE join_date < (
    SELECT MIN(join_date) FROM employees WHERE department = 'IT'
);

-- 15. Show each employee's name and manager's name.
SELECT e.first_name + ' ' + e.last_name AS employee,
       m.first_name + ' ' + m.last_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

-- 16. List employees with their department name.
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department = d.department_name;

--17. List employees not assigned any project.
SELECT * FROM employees WHERE project_id IS NULL;




-- 18. Assign a row number to employees in each department based on salary.
SELECT *, ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num
FROM employees;

-- 19. Show running total salary within each department.
SELECT *, SUM(salary) OVER (PARTITION BY department ORDER BY join_date) AS running_total
FROM employees;

--20. Show difference in salary between employee and previous by join date.
SELECT *, salary - LAG(salary) OVER (ORDER BY join_date) AS salary_diff_prev
FROM employees;

--21. Use CTE to calculate total salary per department, filter total > 200000.
WITH dept_salary AS (
    SELECT department, SUM(salary) AS total_salary
    FROM employees
    GROUP BY department
)
SELECT * FROM dept_salary
WHERE total_salary > 200000;

--22. Create a recursive CTE to generate numbers 1 to 10.
WITH numbers(n) AS (
    SELECT 1
    UNION ALL
    SELECT n + 1 FROM numbers WHERE n < 10
)
SELECT * FROM numbers;

--23. Use a CTE to find employees with duplicate first names.
WITH dup_names AS (
    SELECT first_name, COUNT(*) AS cnt
    FROM employees
    GROUP BY first_name
    HAVING COUNT(*) > 1
)
SELECT e.* 
FROM employees e
JOIN dup_names d ON e.first_name = d.first_name;





--24. Label employees as 'Junior', 'Mid', or 'Senior' based on salary.
SELECT first_name, last_name, salary,
       CASE 
           WHEN salary < 40000 THEN 'Junior'
           WHEN salary BETWEEN 40000 AND 80000 THEN 'Mid'
           ELSE 'Senior'
       END AS level
FROM employees;

--25. Count employees in salary categories using CASE.
SELECT 
    COUNT(CASE WHEN salary < 40000 THEN 1 END) AS junior_count,
    COUNT(CASE WHEN salary BETWEEN 40000 AND 80000 THEN 1 END) AS mid_count,
    COUNT(CASE WHEN salary > 80000 THEN 1 END) AS senior_count
FROM employees;





--26. Replace NULL department values with 'Unknown'.
SELECT ISNULL(department, 'Unknown') AS department
FROM employees;

--27. Show employees with no department.
SELECT * FROM employees WHERE department IS NULL;

--28. Use COALESCE to provide default for missing projects.
SELECT first_name, last_name, COALESCE(project_id, 0) AS project_assigned
FROM employees;
