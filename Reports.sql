USE online_retail_db;

SELECT 
    c.first_name, c.email,
    o.order_id, o.order_date, o.status,
    p.name AS product_name,
    oi.quantity, oi.price_per_item
FROM Orders o
JOIN Customers c ON o.Customers_customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.Orders_order_id
JOIN Products p ON oi.Products_product_id = p.product_id;

SELECT 
    SUM(quantity * price_per_item) AS total_revenue
FROM Order_Items;


SELECT 
    c.first_name, 
    SUM(oi.quantity * oi.price_per_item) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.Customers_customer_id
JOIN Order_Items oi ON o.order_id = oi.Orders_order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;


SELECT 
    p.name, 
    SUM(oi.quantity) AS total_sold
FROM Products p
JOIN Order_Items oi ON p.product_id = oi.Products_product_id
GROUP BY p.product_id
ORDER BY total_sold DESC;

CREATE VIEW v_SalesSummary AS
SELECT 
    o.order_id, o.order_date,
    c.first_name, c.email,
    p.name AS product_name,
    oi.quantity,
    (oi.quantity * oi.price_per_item) AS item_total
FROM Orders o
JOIN Customers c ON o.Customers_customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.Orders_order_id
JOIN Products p ON oi.Products_product_id = p.product_id;

SELECT * FROM v_SalesSummary;

DELIMITER $$
CREATE PROCEDURE sp_GetCustomerOrders(IN p_customer_email VARCHAR(100))
BEGIN
    SELECT 
        o.order_id, o.order_date, o.status,
        (SELECT SUM(oi.quantity * oi.price_per_item) 
         FROM Order_Items oi 
         WHERE oi.Orders_order_id = o.order_id) AS order_total
    FROM Orders o
    JOIN Customers c ON o.Customers_customer_id = c.customer_id
    WHERE c.email = p_customer_email;
END$$
DELIMITER ;

CALL sp_GetCustomerOrders('john.doe@email.com');

DELIMITER $$
CREATE TRIGGER tr_AfterOrderInsert
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock_quantity = stock_quantity - NEW.quantity
    WHERE product_id = NEW.Products_product_id;
END$$
DELIMITER ;