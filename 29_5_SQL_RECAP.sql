-- Create database and switch to it
CREATE DATABASE students;
USE students;

-- Create the 'students' table
CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    grade VARCHAR(10),
    admission_date DATE
);

-- Insert records into the table
INSERT INTO students (id, name, grade, admission_date)
VALUES
    (1, 'Alice', 'A', '2023-06-01'),
    (2, 'Ram', 'B', '2023-06-01'),
    (3, 'Shyam', 'C', '2023-06-01');



-- Update grade for student named 'Ram'
UPDATE students
SET grade = 'A+'
WHERE name = 'Ram';

-- View all students
SELECT * FROM students;

-- View all students in descending order of ID
SELECT * FROM students
ORDER BY id DESC;

-- View only 2 records
SELECT TOP 2 * FROM students;

-- View unique grades
SELECT DISTINCT grade FROM students;
