CREATE TABLE users (
	user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL UNIQUE,
    email_address VARCHAR(50) NOT NULL UNIQUE,
    membership_date DATE NOT NULL
);

CREATE TABLE books (
  title VARCHAR(100) NOT NULL,
  author VARCHAR(100) NOT NULL,
  ISBN VARCHAR(14) PRIMARY KEY,
  genre VARCHAR(100) NOT NULL,
  published_year INT NOT NULL,
  quantity_available INT NOT NULL
);


CREATE TABLE book_loans (
  loan_id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  ISBN VARCHAR(14),
  loan_date DATE NOT NULL,
  return_date DATE NOT NULL,
  book_loan_status VARCHAR(20) NOT NULL CHECK (book_loan_status IN ('borrowed', 'returned', 'overdue')),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  FOREIGN KEY (ISBN) REFERENCES books(ISBN)

);



INSERT INTO books (title, author, ISBN, genre, published_year, quantity_available)
VALUES 
('To Kill a Mockingbird', 'Harper Lee', '978-0061120084', 'Fiction', 1960, 5),
('Pride and Prejudice', 'Jane Austen', '978-0141439507', 'Romance', 1813, 3),
('The Lord of the Rings', 'J.R.R. Tolkien', '978-0547991029', 'Fantasy', 1954, 2);

INSERT INTO users (full_name, email_address, membership_date)
VALUES 
('Sean Ashton V. Regalado', 'sean@gmail.com', '2024-12-01'),
('Ash I. Regalado', 'ash@gmail.com', '2024-12-11');


INSERT INTO book_loans (user_id, ISBN, loan_date, return_date, book_loan_status)
VALUES
(1, '978-0061120084', '2024-12-09', '2024-12-20', 'borrowed'),
(1, '978-0141439507', '2024-12-11', '2024-12-16', 'overdue'),
(2, '978-0547991029', '2024-12-10', '2024-12-13', 'overdue');
  
  
SELECT b.title, b.author, bl.loan_date
FROM books b
JOIN book_loans bl ON b.ISBN = bl.ISBN
WHERE bl.user_id = 1;



SELECT u.full_name, b.Title, bl.loan_date, bl.return_date
FROM book_loans bl
JOIN users u ON bl.user_id = u.user_id
JOIN books b ON bl.ISBN = b.ISBN
WHERE bl.book_loan_status = 'overdue';

UPDATE book_loans
SET book_loan_status = 'returned'
WHERE loan_id = 1;



CREATE INDEX idx_status ON book_loans (book_loan_status);