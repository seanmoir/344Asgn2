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
       VALUES(34, '1', 'test', 'suburbia', 'NZ');

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
	VALUES(1, 34, 'test', 'm', 'test', to_date('01/01/2001', 'DD/MM/YYYY'), 'test@xyz.com');
	
COMMIT;	

CREATE TABLE delivery
       (delivery_ID INT PRIMARY KEY,
       delivery_date DATE NOT NULL,
       address_ID INT REFERENCES address(address_ID));
				
CREATE TABLE categorys
       (category_ID INT PRIMARY KEY,
       category_name VARCHAR(15) NOT NULL);

CREATE TABLE products
       (product_name VARCHAR(25) PRIMARY KEY, 
       category_ID INT REFERENCES categorys(category_ID),
       item_description VARCHAR(20),
       price NUMERIC(15,2) NOT NULL,
       wholesale_cost NUMERIC(15,2) NOT NULL);

CREATE TABLE payment
       (payment_ID INT PRIMARY KEY,
       credit_card_num INT NOT NULL,
       name_on_card VARCHAR(25) NOT NULL,
       expiry_month INT NOT NULL,
       expiry_year INT NOT NULL,
       crc_num INT NOT NULL);
			      
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

CREATE TABLE contains
       (order_ID INT REFERENCES orders,
       product_name VARCHAR(25) REFERENCES products(product_name),
       product_price INT NOT NULL,
       product_quantity INT NOT NULL);

CREATE TABLE employee_phone_num
       (employee_ID INT REFERENCES employees(employee_ID),
       phone_number INT NOT NULL);
					
INSERT INTO customer_phone_num(customer_ID, phone_number) 
	VALUES(942, 02405423940);
INSERT INTO customer_phone_num(customer_ID, phone_number) 
	VALUES(130, 06105433650);
INSERT INTO customer_phone_num(customer_ID, phone_number) 
	VALUES(348, 02430542365);

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
					
INSERT INTO address(address_ID, street_num, street_name, suburb, country)
	VALUES(34, '660', 'castle', 'north dunedin', 'new zealand');
INSERT INTO address(address_ID, street_num, street_name, suburb, country)
	VALUES(29, '616', 'castle', 'north dunedin', 'new zealand');
INSERT INTO address(address_ID, street_num, street_name, suburb, country)
	VALUES(68, '59', 'union', 'north dunedin', 'new zealand');
				
COMMIT;

