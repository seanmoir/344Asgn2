DROP TABLE employee_phone_num;
DROP TABLE customer_phone_num;
DROP TABLE contains;
DROP TABLE orders;
DROP TABLE products;
DROP TABLE categorys;
DROP TABLE payment;
DROP TABLE delivery;
DROP TABLE employees;
DROP TABLE customer;
DROP TABLE address;


CREATE TABLE address 
      (address_ID INT PRIMARY KEY,
       street_num VARCHAR(30) NOT NULL,
       street_name VARCHAR(30) NOT NULL,
       suburb VARCHAR(30) NOT NULL,
       country VARCHAR(30) NOT NULL);

INSERT INTO address(address_ID, street_num, street_name, suburb, country)
	VALUES(34, '660', 'castle', 'north dunedin', 'new zealand');

INSERT INTO address(address_ID, street_num, street_name, suburb, country)
	VALUES(29, '616', 'castle', 'north dunedin', 'new zealand');

INSERT INTO address(address_ID, street_num, street_name, suburb, country)
	VALUES(68, '59', 'union', 'north dunedin', 'new zealand');

COMMIT;

CREATE TABLE customer
       (customer_ID INT PRIMARY KEY,
       address_ID INT REFERENCES address(address_ID),
       fname VARCHAR(25) NOT NULL,
       mname VARCHAR(25),
       lname VARCHAR(25) NOT NULL,
       dob DATE NOT NULL,
       email VARCHAR(25) NOT NULL
       );
       
INSERT INTO customer(customer_ID, address_ID, fname, mname, lname, dob, email)
	VALUES(582, 34, 'john', 'william', 'smith', to_date('04/01/2001', 'DD/MM/YYYY'), 'john@email.com');
INSERT INTO customer(customer_ID, address_ID, fname, mname, lname, dob, email)
	VALUES(684, 29, 'henry', 'alan', 'robb', to_date('08/12/1995', 'DD/MM/YYYY'), 'henry@email.com');
INSERT INTO customer(customer_ID, address_ID, fname, mname, lname, dob, email)
	VALUES(194, 68, 'sarah', 'georgia', 'cole', to_date('31/03/1987', 'DD/MM/YYYY'), 'georgia@email.com');
	
COMMIT;	

CREATE TABLE delivery
       (delivery_ID INT PRIMARY KEY,
       delivery_date DATE NOT NULL,
       address_ID INT REFERENCES address(address_ID));
					
INSERT INTO delivery(delivery_ID, delivery_date, address_ID) 
	VALUES(98, to_date('31/10/2020', 'DD/MM/YYYY'), 34);
INSERT INTO delivery(delivery_ID, delivery_date, address_ID) 
	VALUES(87, to_date('27/11/2020', 'DD/MM/YYYY'), 29);
INSERT INTO delivery(delivery_ID, delivery_date, address_ID) 
	VALUES(13, to_date('4/10/2020', 'DD/MM/YYYY'), 68);

COMMIT;
				
CREATE TABLE categorys
       (category_ID INT PRIMARY KEY,
       category_name VARCHAR(15) NOT NULL);
					
INSERT INTO categorys(category_ID, category_name)
	VALUES(5, 'hoodies');
INSERT INTO categorys(category_ID, category_name)
	VALUES(8, 'pants');
INSERT INTO categorys(category_ID, category_name)
	VALUES(2, 'shorts');

COMMIT;

CREATE TABLE products
       (product_name VARCHAR(25) PRIMARY KEY, 
       category_ID INT REFERENCES categorys(category_ID),
       item_description VARCHAR(20),
       price NUMERIC(15,2) NOT NULL,
       wholesale_cost NUMERIC(15,2) NOT NULL);
					
INSERT INTO products(product_name, category_ID, item_description, price, wholesale_cost)
	VALUES('cool hoodie', 5, 'black hoodie', 24.9, 12.5);
INSERT INTO products(product_name, category_ID, item_description, price, wholesale_cost)
	VALUES('branded pants', 8, 'warm pants', 19.9, 9.7);
INSERT INTO products(product_name, category_ID, item_description, price, wholesale_cost)
	VALUES('soccer shorts', 2, 'sports shorts', 22.9, 11.3);
					
COMMIT;

CREATE TABLE payment
       (payment_ID INT PRIMARY KEY,
       credit_card_num INT NOT NULL,
       name_on_card VARCHAR(25) NOT NULL,
       expiry_month INT NOT NULL,
       expiry_year INT NOT NULL,
       crc_num INT NOT NULL);
					
INSERT INTO payment(payment_ID, credit_card_num, name_on_card, expiry_month, expiry_year, crc_num)
	VALUES(32485, 1111222233334444, 'J W Smith', 11, 24, 000);
INSERT INTO payment(payment_ID, credit_card_num, name_on_card, expiry_month, expiry_year, crc_num)
	VALUES(23987, 1111222233334444, 'H A Robb', 02, 23, 000);
INSERT INTO payment(payment_ID, credit_card_num, name_on_card, expiry_month, expiry_year, crc_num)
	VALUES(89133, 1111222233334444, 'S A Cole', 07, 23, 000);

COMMIT;
			      
CREATE TABLE employees
       (employee_ID INT PRIMARY KEY,
       employee_fname VARCHAR(30) NOT NULL,
       employee_mname VARCHAR(30),
       employee_lname VARCHAR(30) NOT NULL,
       employee_DOB DATE NOT NULL,
       start_date DATE NOT NULL,
       payment_account VARCHAR(20) NOT NULL,
       address_ID INT REFERENCES address(address_ID),
       employee_position VARCHAR(15) NOT NULL);
					
INSERT INTO employees(employee_ID, employee_fname, employee_mname, employee_lname, employee_DOB, start_date, payment_account, address_ID, employee_position)
	VALUES(98405, 'brodie', 'scott', 'bosceke', to_date('27/11/1983', 'DD/MM/YYYY'), to_date('21/10/2018', 'DD/MM/YYYY'), '0348570948356-00', 34, 'manager');

COMMIT;

CREATE TABLE orders
       (order_ID INT Primary KEY,
       order_Status VARCHAR(20) NOT NULL,
       order_Received DATE NOT NULL,
       price NUMERIC(15,2) NOT NULL,
       GST NUMERIC(15,2) NOT NULL,
       customer_ID INT REFERENCES customer(customer_ID),
       request_date DATE NOT NULL,
       payment_ID INT REFERENCES payment(payment_ID),
       payment_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       delivery_ID INT REFERENCES delivery(delivery_ID),
       employee_ID INT REFERENCES employees(employee_ID)
       );
					
INSERT INTO orders(order_ID, order_status, order_Received, price, GST, customer_ID, request_date, payment_ID, payment_timestamp, delivery_ID, employee_ID)
	VALUES(02835, 'packing', to_date('27/07/2020', 'DD/MM/YYYY'), 49.9, 11.4, 582, to_date('26/07/2020', 'DD/MM/YYYY'), 32485, CURRENT_TIMESTAMP, 98, 98405);

COMMIT;

CREATE TABLE contains
       (order_ID INT REFERENCES orders,
       product_name VARCHAR(25) REFERENCES products(product_name),
       product_price INT NOT NULL,
       product_quantity INT NOT NULL);
					
INSERT INTO contains(order_ID, product_name, product_price, product_quantity)
	VALUES(02835, 'soccer shorts', 22.9, 2);

COMMIT;

CREATE TABLE employee_phone_num
       (employee_ID INT REFERENCES employees(employee_ID),
       phone_number INT NOT NULL);
					
INSERT INTO employee_phone_num(employee_ID, phone_number) 
	VALUES(98405, 02405423940);
INSERT INTO employee_phone_num(employee_ID, phone_number) 
	VALUES(98405, 06105433650);
INSERT INTO employee_phone_num(employee_ID, phone_number) 
	VALUES(98405, 02430542365);

COMMIT

CREATE TABLE customer_phone_num
       (customer_ID INT REFERENCES customer(customer_ID),
       phone_number INT NOT NULL);
					
INSERT INTO customer_phone_num(customer_ID, phone_number) 
	VALUES(582, 02105323950);
INSERT INTO customer_phone_num(customer_ID, phone_number) 
	VALUES(684, 03105423650);
INSERT INTO customer_phone_num(customer_ID, phone_number) 
	VALUES(194, 0230542355);

COMMIT;
