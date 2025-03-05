/* TASK TWO: STUDENT DATABASE MANAGEMENT
 Create a database to manage student records, including
 personal details, courses, and grades. This project helps to
 practice creating and managing relational databases. Design
 tables for students, courses, and enrollments. Write SQL
 queries to manage student records. Implement joins to
 combine data from multiple tables.
 */


CREATE DATABASE Student;
USE Student;

CREATE TABLE students (
student_id INT PRIMARY KEY AUTO_INCREMENT,
student_name VARCHAR(50) NOT NULL,
student_email VARCHAR(50) UNIQUE NOT NULL,
phone VARCHAR(15),
dob DATE,
join_date DATE
);

CREATE TABLE courses (
course_id INT PRIMARY KEY AUTO_INCREMENT,
course_name VARCHAR(50) NOT NULL,
instructor VARCHAR(50)
);

CREATE TABLE enrollment (
enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
student_id INT,
course_id INT,
grade VARCHAR(2),
FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

INSERT INTO students (student_name, student_email, phone, dob, join_date)
VALUES
('Juby Jayakumar', 'juby@gmail.com', '9876543212','1999-06-07', '2024-07-01'),
('Moumita Nath', 'moumita@gmail.com','8765432195', '1996-06-27', '2021-06-01'),
('Aashika','aashi@gmail.com','8976543240','1999-02-09','2024-06-01'),
('Nivitha','nivi@gmail.com','9807689543','1998-05-08','2023-06-14'),
('Krithika','krithi@gmail.com','7896543299','2001-09-24','2026-06-01');

INSERT INTO courses (course_name, instructor)
VALUES
('Immunology','Dr. Maxwell'),
('Oncology','Dr. Sharpe'),
('CA','Dr. Litt'),
('Aeronautical','Dr. Williams'),
('Law','Dr. Pearson');

INSERT INTO enrollment (student_id, course_id, grade)
VALUES
(2,1,'A'), (2,2,'A'), (2,3,'B'),(2,4,'B'),(2,5,'B'),
(1,3,'B'), (1,1,'A'),(1,4,'B'),
(3,3,'A'),(4,4,'A'),(5,5,'A');

#retreive data
#list all students with their coures and grades:
SELECT s.student_name AS Student, c.course_name AS Course, e.grade
FROM enrollment e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id;

#Find students enrolled in Immonology
SELECT s.student_name
FROM enrollment e
JOIN students s ON e.student_id=s.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Immunology';                           

#Count of students in each course
SELECT c.course_name, COUNT(e.student_id) AS Total_Students
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;