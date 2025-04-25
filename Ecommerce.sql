create database Ecommerce;

use Ecommerce;

-- creating table color and inserting data to it
CREATE TABLE color (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    hex_code VARCHAR(7)
);

INSERT INTO color (id, name, hex_code) VALUES 
(1, 'Red', '#FF0000'),
(2, 'Blue', '#0000FF'),
(3, 'Green', '#00FF00');

-- creating table product_category and inserting data to it
CREATE TABLE product_category (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO product_category (id, name) VALUES 
(1, 'Clothing'),
(2, 'Electronics');

-- creating table brand and inserting data into it
CREATE TABLE brand (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

INSERT INTO brand (id, name, description) VALUES 
(1, 'Nike', 'Athletic wear and sports gear'),
(2, 'Samsung', 'Electronics and smart devices');

-- creating table product and inserting data
CREATE TABLE product (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

INSERT INTO product (id, name, brand_id, category_id, base_price) VALUES 
(1, 'Air Max 90', 1, 1, 120.00),
(2, 'Galaxy S22', 2, 2, 799.99);

-- creating table product_image and inserting data
CREATE TABLE product_image (
    id INT PRIMARY KEY,
    product_id INT,
    image_url VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

INSERT INTO product_image (id, product_id, image_url) VALUES 
(1, 1, 'https://example.com/images/airmax90.jpg'),
(2, 2, 'https://example.com/images/galaxys22.jpg');

-- creating table size_category
CREATE TABLE size_category (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO size_category (id, name) VALUES 
(1, 'Clothing Sizes'),
(2, 'Shoe Sizes');

-- creating table size_option
CREATE TABLE size_option (
    id INT PRIMARY KEY,
    size_category_id INT,
    label VARCHAR(10),
    FOREIGN KEY (size_category_id) REFERENCES size_category(id)
);

INSERT INTO size_option (id, size_category_id, label) VALUES 
(1, 1, 'S'),
(2, 1, 'M'),
(3, 1, 'L'),
(4, 2, '42'),
(5, 2, '43');

-- creating table product_variation
CREATE TABLE product_variation (
    id INT PRIMARY KEY,
    product_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);

INSERT INTO product_variation (id, product_id, color_id, size_option_id) VALUES 
(1, 1, 1, 5),  -- Air Max 90, Red, size 43
(2, 1, 2, 4),  -- Air Max 90, Blue, size 42
(3, 2, 2, NULL); -- Galaxy S22, Blue, no size

-- creating table product_item and inserting data
CREATE TABLE product_item (
    id INT PRIMARY KEY,
    variation_id INT,
    sku VARCHAR(100),
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (variation_id) REFERENCES product_variation(id)
);

INSERT INTO product_item (id, variation_id, sku, price, stock_quantity) VALUES 
(1, 1, 'AM90-RED-43', 125.00, 10),
(2, 2, 'AM90-BLU-42', 120.00, 15),
(3, 3, 'GS22-BLU', 799.99, 5);

-- creating table attribute_category and inserting data
CREATE TABLE attribute_category (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO attribute_category (id, name) VALUES 
(1, 'Physical'),
(2, 'Technical');

-- creating table attribute_type and inserting data
CREATE TABLE attribute_type (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO attribute_type (id, name) VALUES 
(1, 'Text'),
(2, 'Number'),
(3, 'Boolean');

-- creating table product_attribute and inserting data
CREATE TABLE product_attribute (
    id INT PRIMARY KEY,
    product_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    name VARCHAR(100),
    value VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
);

INSERT INTO product_attribute (id, product_id, attribute_category_id, attribute_type_id, name, value) VALUES 
(1, 1, 1, 1, 'Material', 'Leather'),
(2, 2, 2, 2, 'Battery Life', '24'),
(3, 2, 2, 3, 'Waterproof', '1');
