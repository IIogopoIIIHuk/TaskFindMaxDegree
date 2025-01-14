CREATE TABLE Authors(
    author_id INT PRIMARY KEY,
    name VARCHAR NOT NULL,
    birthdate DATE
);

CREATE TABLE Books(
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    author_id INT REFERENCES Authors(author_id),
    price DECIMAL(10,2) NOT NULL,
    publication_date DATE
);

CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    book_id INT REFERENCES Books(book_id),
    quantity INT NOT NULL,
    order_date DATE
);


INSERT INTO Authors (author_id, name, birthdate)
VALUES
    (1, 'Лев Толстой', '1828-09-09'),
    (2, 'Фёдор Достоевский', '1821-11-11'),
    (3, 'Антон Чехов', '1860-01-29'),
    (4, 'Иван Тургенев', '1818-11-09');

INSERT INTO Books (book_id, title, author_id, price, publication_date)
VALUES
    (1, 'Война и мир', 1, 500.00, '1869-01-01'),
    (2, 'Анна Каренина', 1, 400.00, '1877-01-01'),
    (3, 'Преступление и наказание', 2, 350.00, '1866-01-01'),
    (4, 'Братья Карамазовы', 2, 450.00, '1880-01-01'),
    (5, 'Чайка', 3, 300.00, '1896-01-01'),
    (6, 'Отцы и дети', 4, 320.00, '1862-01-01');

INSERT INTO Orders (order_id, book_id, quantity, order_date)
VALUES
    (1, 1, 2, '2025-01-10'),  -- "Война и мир"
    (2, 3, 1, '2025-01-11'),  -- "Преступление и наказание"
    (3, 5, 3, '2025-01-12'),  -- "Чайка"
    (4, 2, 1, '2025-01-13'),  -- "Анна Каренина"
    (5, 4, 2, '2025-01-14'),  -- "Братья Карамазовы"
    (6, 6, 1, '2025-01-15');  -- "Отцы и дети"


SELECT*FROM Authors;

SELECT*FROM Books;

SELECT*FROM Orders;

-- 1 задание, все книги с автором
SELECT Books.title, Authors.name
FROM Books
LEFT JOIN Authors ON Books.author_id = Authors.author_id;

-- 2 задание, все книги выпущенные после 1 января 2020 года
UPDATE Books SET publication_date = '2021.04.01' WHERE book_id=3;
UPDATE Books SET publication_date = '2019.01.01' WHERE book_id=2;
UPDATE Books SET publication_date = '2020.05.01' WHERE book_id=1;
UPDATE Books SET publication_date = '2022.02.01' WHERE book_id=5;

SELECT title, publication_date FROM Books WHERE publication_date > '2020.01.01';

-- 3 задание, общее количество книг проданных в заказах
SELECT SUM(quantity) FROM Orders;

-- 4 задание, вывести 3 самые дорогие книги
SELECT title, price FROM Books ORDER BY price DESC LIMIT 3;

-- 5 задание, найти авторов, чьи книги были заказаны больше 10 раз
UPDATE Orders SET quantity = 6 WHERE book_id = 1;
UPDATE Orders SET quantity = 7 WHERE book_id = 2;
UPDATE Orders SET quantity = 9 WHERE book_id = 4;
UPDATE Orders SET quantity = 2 WHERE book_id = 3;


SELECT
    Authors.name,
    SUM(Orders.quantity) AS total_orders
FROM
    Authors
JOIN
    Books ON Authors.author_id = Books.author_id
JOIN
    Orders ON Books.book_id = Orders.book_id
GROUP BY
    Authors.name
HAVING
    SUM(Orders.quantity) > 10;

