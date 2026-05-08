-- 1. Insert 25 Customers
INSERT INTO ecommerce.customers (name, email, created_at) VALUES
('Alice Smith', 'alice@example.com', '2023-01-15 08:30:00'),
('Bob Jones', 'bob@example.com', '2023-02-20 10:15:00'),
('Charlie Brown', 'charlie@example.com', '2023-03-05 14:20:00'),
('Diana Prince', 'diana@example.com', '2023-03-12 09:45:00'),
('Evan Wright', 'evan@example.com', '2023-04-01 11:10:00'),
('Fiona Gallagher', 'fiona@example.com', '2023-04-18 16:05:00'),
('George Miller', 'george@example.com', '2023-05-22 13:50:00'),
('Hannah Abbott', 'hannah@example.com', '2023-06-11 08:00:00'),
('Ian Malcolm', 'ian@example.com', '2023-07-04 17:30:00'),
('Julia Roberts', 'julia@example.com', '2023-07-19 12:25:00'),
('Kevin Hart', 'kevin@example.com', '2023-08-05 09:15:00'),
('Laura Dern', 'laura@example.com', '2023-08-21 14:40:00'),
('Michael Scott', 'michael@example.com', '2023-09-02 10:00:00'),
('Nina Simone', 'nina@example.com', '2023-09-15 15:55:00'),
('Oscar Isaac', 'oscar@example.com', '2023-10-10 11:20:00'),
('Pam Beesly', 'pam@example.com', '2023-10-28 08:45:00'),
('Quincy Jones', 'quincy@example.com', '2023-11-05 13:10:00'),
('Rachel Green', 'rachel@example.com', '2023-11-20 16:30:00'),
('Steve Rogers', 'steve@example.com', '2023-12-01 09:05:00'),
('Tina Fey', 'tina@example.com', '2023-12-15 14:50:00'),
('Ursula K.', 'ursula@example.com', '2024-01-05 10:25:00'),
('Victor Stone', 'victor@example.com', '2024-01-22 11:40:00'),
('Wanda Maximoff', 'wanda@example.com', '2024-02-14 15:15:00'),
('Xavier Woods', 'xavier@example.com', '2024-03-01 08:50:00'),
('Yara Shahidi', 'yara@example.com', '2024-03-15 12:00:00');

-- 2. Insert 25 Products across different categories
INSERT INTO ecommerce.products (name, price, category, is_active) VALUES
('Wireless Mouse', 25.50, 'Electronics', TRUE),
('Mechanical Keyboard', 85.00, 'Electronics', TRUE),
('Coffee Mug', 12.00, 'Home', TRUE),
('Gaming Monitor', 300.00, 'Electronics', TRUE),
('Ergonomic Chair', 150.00, 'Furniture', TRUE),
('Desk Lamp', 35.00, 'Home', TRUE),
('Noise Cancelling Headphones', 250.00, 'Electronics', TRUE),
('Water Bottle', 15.00, 'Accessories', TRUE),
('Yoga Mat', 20.00, 'Fitness', TRUE),
('Dumbbell Set', 45.00, 'Fitness', TRUE),
('Running Shoes', 120.00, 'Apparel', TRUE),
('Cotton T-Shirt', 18.00, 'Apparel', TRUE),
('Denim Jeans', 60.00, 'Apparel', TRUE),
('Winter Jacket', 110.00, 'Apparel', FALSE), -- Inactive product
('Backpack', 55.00, 'Accessories', TRUE),
('Notebook', 8.00, 'Office', TRUE),
('Gel Pens (Pack of 5)', 6.50, 'Office', TRUE),
('Smart Watch', 199.99, 'Electronics', TRUE),
('Bluetooth Speaker', 45.00, 'Electronics', TRUE),
('Throw Blanket', 30.00, 'Home', TRUE),
('Scented Candle', 14.50, 'Home', TRUE),
('Protein Powder', 40.00, 'Fitness', TRUE),
('Sunglasses', 125.00, 'Accessories', TRUE),
('Standing Desk', 400.00, 'Furniture', TRUE),
('Mouse Pad', 10.00, 'Office', TRUE);

-- 3. Insert 25 Orders (Note: Some customers order twice, some haven't ordered yet)
INSERT INTO ecommerce.orders (customer_id, order_date, total_amount, status) VALUES
(1, '2023-01-20', 110.50, 'delivered'),
(2, '2023-02-25', 12.00, 'delivered'),
(3, '2023-03-10', 300.00, 'delivered'),
(4, '2023-03-15', 150.00, 'delivered'),
(1, '2023-04-05', 250.00, 'shipped'), -- Alice's 2nd order
(5, '2023-04-10', 35.00, 'delivered'),
(6, '2023-05-01', 120.00, 'delivered'),
(7, '2023-05-25', 60.00, 'returned'),
(8, '2023-06-15', 78.00, 'delivered'),
(9, '2023-07-10', 55.00, 'delivered'),
(10, '2023-07-20', 14.50, 'delivered'),
(11, '2023-08-10', 400.00, 'shipped'),
(12, '2023-08-25', 125.00, 'delivered'),
(3, '2023-09-05', 40.00, 'delivered'), -- Charlie's 2nd order
(13, '2023-09-10', 199.99, 'pending'),
(14, '2023-09-20', 45.00, 'delivered'),
(15, '2023-10-15', 30.00, 'delivered'),
(16, '2023-11-01', 20.00, 'delivered'),
(17, '2023-11-10', 45.00, 'delivered'),
(18, '2023-11-25', 18.00, 'shipped'),
(19, '2023-12-05', 15.00, 'delivered'),
(20, '2023-12-20', 14.50, 'cancelled'),
(21, '2024-01-10', 85.00, 'delivered'),
(22, '2024-01-25', 25.50, 'pending'),
(23, '2024-02-20', 300.00, 'shipped');

-- 4. Insert 35 Order Items (linking the 25 orders to various products)
INSERT INTO ecommerce.order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 25.50),  -- Order 1: Mouse
(1, 2, 1, 85.00),  -- Order 1: Keyboard
(2, 3, 1, 12.00),  -- Order 2: Mug
(3, 4, 1, 300.00), -- Order 3: Monitor
(4, 5, 1, 150.00), -- Order 4: Chair
(5, 7, 1, 250.00), -- Order 5: Headphones
(6, 6, 1, 35.00),  -- Order 6: Lamp
(7, 11, 1, 120.00),-- Order 7: Shoes
(8, 13, 1, 60.00), -- Order 8: Jeans
(9, 12, 1, 18.00), -- Order 9: T-Shirt
(9, 13, 1, 60.00), -- Order 9: Jeans
(10, 15, 1, 55.00),-- Order 10: Backpack
(11, 21, 1, 14.50),-- Order 11: Candle
(12, 24, 1, 400.00),-- Order 12: Standing Desk
(13, 23, 1, 125.00),-- Order 13: Sunglasses
(14, 22, 1, 40.00), -- Order 14: Protein
(15, 18, 1, 199.99),-- Order 15: Watch
(16, 19, 1, 45.00), -- Order 16: Speaker
(17, 20, 1, 30.00), -- Order 17: Blanket
(18, 9,  1, 20.00), -- Order 18: Yoga Mat
(19, 10, 1, 45.00), -- Order 19: Dumbbells
(20, 12, 1, 18.00), -- Order 20: T-Shirt
(21, 8,  1, 15.00), -- Order 21: Water Bottle
(22, 21, 1, 14.50), -- Order 22: Candle
(23, 2,  1, 85.00), -- Order 23: Keyboard
(24, 1,  1, 25.50), -- Order 24: Mouse
(25, 4,  1, 300.00),-- Order 25: Monitor
-- Adding some bulk orders to test SUM() and GROUP BY later
(1, 16, 5, 8.00),  -- Alice bought 5 Notebooks
(3, 17, 3, 6.50),  -- Charlie bought 3 packs of pens
(5, 25, 2, 10.00), -- Alice bought 2 mouse pads
(12, 5, 2, 150.00),-- Laura bought 2 chairs
(15, 1, 4, 25.50), -- Oscar bought 4 mice
(20, 16, 10, 8.00),-- Rachel bought 10 notebooks
(22, 3,  6, 12.00),-- Victor bought 6 Mugs
(25, 2,  2, 85.00);-- Wanda bought 2 Keyboards