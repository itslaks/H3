use StockDB;

create table stulist (
stuid INT NOT NULL PRIMARY KEY,
name VARCHAR(234),
sub VARCHAR(1222),
marks INT NOT NULL);

INSERT INTO stulist (stuid, name, sub, marks) VALUES
(1, 'Alice', 'Math', 87),
(2, 'Bob', 'Science', 92),
(3, 'Charlie', 'English', 75),
(4, 'David', 'History', 89),
(5, 'Eva', 'Math', 92),
(6, 'Frank', 'Science', 70);


SELECT stuid, name, sub, marks, RANK() OVER (ORDER BY marks DESC) AS rank
FROM stulist;


SELECT 
    stuid,
    name,
    sub,
    marks,
    (
        SELECT COUNT(*) 
        FROM (
            SELECT DISTINCT marks 
            FROM stulist 
            WHERE marks > s.marks
        ) AS higher_marks
    ) + 1 AS rank
FROM 
    stulist s
ORDER BY 
    rank;


Create table sales(
sale_id INT,
name VARCHAR(223),
location VARCHAR(223),
sale INT);

INSERT into sales values 
(1, 'alice' , 'north', 10000),
(2, 'bob' , 'south', 2000),
(3, 'alice' , 'north', 10000),
(4, 'bob' , 'south', 2000),
(5, 'alice' , 'north', 10000),
(6, 'bob' , 'south', 2000);

--total sales by employees
select name, sum(sale) as totalsales from sales
group by name;


select sale_id , name, location, sale, sum(sale) over (partition by name) as total_sale_by_employee 
from sales;


select sale_id, name, location, sale,
RANK() over (partition by name order by sale desc) as
rank_in_sqles
from sales;


