/* Task1 : LIBRARY MANAGEMENT SYSTEM
 Create a database for managing a library's book inventory, members, and
 borrow/return transactions. This project helps to learn basic SQL commands
 and database design. Design tables for books, members, and transactions.
 Write SQL queries to insert, update, delete, and retrieve data.
 */
 
CREATE DATABASE Library1;
USE Library1;

CREATE TABLE books (
book_id INT PRIMARY KEY AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
author VARCHAR(50) NOT NULL,
genre VARCHAR(50),
published_year INT,
available_copies INT DEFAULT 1
);

CREATE TABLE members(
member_id INT PRIMARY KEY AUTO_INCREMENT,
member_name VARCHAR(50) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
phone VARCHAR(15)
);

CREATE TABLE transactions (
transaction_id INT PRIMARY KEY AUTO_INCREMENT,
book_id INT,
member_id INT,
borrow_date DATE,
return_date DATE,
status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
FOREIGN KEY (book_id) REFERENCES books(book_id),
FOREIGN KEY (member_id) REFERENCES members(member_id)
);

INSERT INTO books (title, author, genre, published_year, available_copies)
VALUES ('The Alchemist', 'Paulo Coelho', 'Fiction', 1988, 23),
('Harry Potter', 'J K Rowling', 'Fantasy', 1997, 45),
('The Da Vinci Code', 'Dan Brown', 'Thriller', 2003, 51),
('Pride and Prejudice', 'Jane Austen', 'Romance', 1813, 15),
(1984, 'George Orwell', 'Sci-Fi', 1949, 34);

INSERT INTO members (member_name, email, phone)
VALUES ('Rachel Zane', 'rachelzane@gmail.com', '9987654321'),
('Mike Ross', 'michealross@gmail.com', '9123456700'),
('Harvey Specter', 'harveyspecter@gmail.com', '8963521378'),
('Jessica Pearson', 'jessicapearson@gmail.com', '7263829362');

INSERT INTO transactions (book_id, member_id, borrow_date, return_date)
VALUES (1, 3, '2024-05-08', '2024-05-31'),
(2, 1, '2024-01-03', '2024-01-31'),
(3, 2, '2024-10-26', '2024-11-15'),
(4, 4, '2024-05-29', '2024-06-26');

# Update
UPDATE books
SET available_copies = available_copies - 2
WHERE book_id = 3;

# Retrieve
SELECT * FROM books WHERE available_copies < 20;

# Delete
DELETE FROM transactions WHERE member_id = 4;
DELETE FROM members WHERE member_id = 4;

SHOW TABLES;