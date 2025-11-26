USE online_retail_db;

INSERT INTO Customers (first_name, last_name, email) 
VALUES
('John', 'Doe', 'john.doe@email.com'),
('Jane', 'Smith', 'jane.smith@email.com'),
('Bob', 'Johnson', 'bob.j@email.com');


INSERT INTO Products (name, price, stock_quantity)
VALUES
('Laptop', 1200.00, 50),
('Mouse', 25.00, 150),
('Keyboard', 75.00, 100),
('Headphones', 150.00, 75);


INSERT INTO Orders (Customers_customer_id, status) 
VALUES
(1, 'Shipped');



INSERT INTO Order_Items (Orders_order_id, Products_product_id, quantity, price_per_item)
VALUES
(1, 1, 1, 1200.00),
(1, 2, 1, 25.00);


INSERT INTO Payments (Orders_order_id, amount, payment_method)
VALUES
(1, 1225.00, 'Credit Card');


INSERT INTO Orders (Customers_customer_id, status) 
VALUES
(2, 'Pending');



INSERT INTO Order_Items (Orders_order_id, Products_product_id, quantity, price_per_item)
VALUES
(2, 3, 1, 75.00),
(2, 4, 1, 150.00);


INSERT INTO Payments (Orders_order_id, amount, payment_method)
VALUES
(2, 225.00, 'PayPal');