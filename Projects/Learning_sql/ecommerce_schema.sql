CREATE SCHEMA ecommerce;

CREATE TABLE ecommerce.customers (
    customer_id   SERIAL PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(255) UNIQUE NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE ecommerce.products (
    product_id    SERIAL PRIMARY KEY,
    name          VARCHAR(200) NOT NULL,
    price         DECIMAL(10, 2) NOT NULL,
    category      VARCHAR(50),
    is_active     BOOLEAN DEFAULT TRUE
);

CREATE TABLE ecommerce.orders (
    order_id      SERIAL PRIMARY KEY,
    customer_id   INT NOT NULL REFERENCES ecommerce.customers(customer_id),
    order_date    DATE NOT NULL DEFAULT CURRENT_DATE,
    total_amount  DECIMAL(10, 2) NOT NULL,
    status        VARCHAR(20) DEFAULT 'pending'
);

CREATE TABLE ecommerce.order_items (
    item_id       SERIAL PRIMARY KEY,
    order_id      INT NOT NULL REFERENCES ecommerce.orders(order_id),
    product_id    INT NOT NULL REFERENCES ecommerce.products(product_id),
    quantity      INT NOT NULL CHECK (quantity > 0),
    unit_price    DECIMAL(10, 2) NOT NULL
);

-- alter table ecommerce.order_items drop CONSTRAINT order_items_quantity_check;
-- alter table ecommerce.order_items ADD CONSTRAINT order_items_quantity_check check (quantity>10);