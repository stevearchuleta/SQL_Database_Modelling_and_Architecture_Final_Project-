/*

-----------------------------------------------------------------------------------------------------------------------------------
                                               Guidelines
-----------------------------------------------------------------------------------------------------------------------------------

The provided document is a guide for the project. Follow the instructions and take the necessary steps to finish
the project in the SQL file			
-----------------------------------------------------------------------------------------------------------------------------------

											Database Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------
*/

-- [1] To begin the project, first create the database.
--     Write the Query below to create a crime Database.

--     FUNCTIONALITY: Drop Database if it already exisits (or if I need to correct any of my errors and then re-run the CREATE code).
--     OBSERVATIONS: Without a current wheels database, the DROP command will throw an Action Output warning because no database yet exists.
--     INSIGHTS: Two Databases with the same name cannot be created (MySQL Schema namespaces are reserved for unique database names)
--               Ingestion Layer of Data Modelling and Architecture
DROP DATABASE IF EXISTS wheels;
CREATE DATABASE wheels;


-- [2] After creating the database, tell MYSQL which database is to be used.
--     Write the Query below to call the wheels Database.

-- FUNCTIONALITY: USE <database namespace> will use the named database as the active/current schema. 
-- OBSERVATIONS: Within the mySQL Navigator field, the database name in use will be bold typed.
-- INSIGHTS:  By double clicking on a database name, that particular database will then become the active/current/bold-typed schema.
--               Ingestion Layer of Data Modelling and Architecture
use wheels;


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Tables Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [3] Creating the tables:

/*Note:
---> To create the table, refer to the ER diagram and the solution architecture. 
---> Refer to the column names along with the data type while creating a table from the ER diagram.
---> Make sure the column you assign as a primary key should uniquely identify each row.
*/
-- FUNCTIONALITY: 	DROP TABLE if it already exisits (or if I need to correct any of my errors and then re-run the CREATE code).
-- 					CREATE temp_t table.
--                  Herein, I've organized temp_t columns by the smaller, normalized tables that I'll be creating later in the project.
-- OBSERVATIONS:    Herein, the datatypes of each column name must be delcared
-- INSIGHTS:		In essence, this is the same code that will be used to CREATE the vehicles TABLE.
 -- 			    
 --                 This is the Ingestion Layer of Data Modelling and Architecture.
 --                 These are the Data Definiton Languages (DDL)
                                                                              

/* List of tables to be created.

 Create a table temp_t, vehicles_t, order_t, customer_t, product_t, shipper_t */

 
-- Create a table temp_t-
DROP TABLE IF EXISTS temp_t;
CREATE TABLE temp_t
(
    -- SHIPPER_t 
    shipper_id INTEGER,
    shipper_name VARCHAR(50),
    shipper_contact_details VARCHAR(30),
      
    -- PRODUCT_t
    product_id INTEGER,
    vehicle_maker VARCHAR(60),
    vehicle_model VARCHAR(60),
    vehicle_color VARCHAR(60),
    vehicle_model_year INTEGER,
     vehicle_price DECIMAL(14,2),
    
	-- ORDER_t
    order_id VARCHAR(25),
    -- customer_id (FK),
	-- shipper_id (FK),
    -- product_id (FK),
    quantity INTEGER,
    -- vehicle_price DECIMAL(10, 2),
    order_date DATE,
    ship_date DATE,
    discount DECIMAL(4,2),
    offender_sex CHAR(1),
    ship_mode VARCHAR(25),
    shipping VARCHAR(30),
    customer_feedback VARCHAR(20),
    quarter_number INTEGER,
         
    -- CUSTOMER_t
    customer_id VARCHAR(25),
    customer_name VARCHAR(25),
    gender VARCHAR(15),
    job_title VARCHAR(50),
    phone_number VARCHAR(20),
    email_address VARCHAR(50),
	city VARCHAR(50),
    country VARCHAR(25),
    state VARCHAR(40),
	customer_address VARCHAR(50),
	postal_code INTEGER,
    credit_card_type VARCHAR(40),
    credit_card_number BIGINT,
    
	PRIMARY KEY(order_id)
);


-- Create a table vehicles_t-
DROP TABLE IF EXISTS vehicles_t;
CREATE TABLE vehicles_t
(
   -- SHIPPER_t 
    shipper_id INTEGER,
    shipper_name VARCHAR(50),
    shipper_contact_details VARCHAR(30),
    
    -- PRODUCT_t
    product_id INTEGER,
    vehicle_maker VARCHAR(60),
    vehicle_model VARCHAR(60),
    vehicle_color VARCHAR(60),
    vehicle_model_year INTEGER,
     vehicle_price DECIMAL(14,2),
    
	-- ORDER_t
    order_id VARCHAR(25),
    -- customer_id (FK),
	-- shipper_id (FK),
    -- product_id (FK),
    quantity INTEGER,
    -- vehicle_price DECIMAL(10, 2),
    order_date DATE,
    ship_date DATE,
    discount DECIMAL(4,2),
    offender_sex CHAR(1),
    ship_mode VARCHAR(25),
    shipping VARCHAR(30),
    customer_feedback VARCHAR(20),
    quarter_number INTEGER,
         
     -- CUSTOMER_t
    customer_id VARCHAR(25),
    customer_name VARCHAR(25),
    gender VARCHAR(15),
    job_title VARCHAR(50),
    phone_number VARCHAR(20),
    email_address VARCHAR(50),
	city VARCHAR(50),
    country VARCHAR(25),
    state VARCHAR(40),
	customer_address VARCHAR(50),
	postal_code INTEGER,
    credit_card_type VARCHAR(40),
    credit_card_number BIGINT,
    
	PRIMARY KEY(order_id)
);


-- Create a shipper_t- table

DROP TABLE IF EXISTS shipper_t;
CREATE TABLE shipper_t
(
	shipper_id INTEGER,
	shipper_name VARCHAR(50),
    shipper_contact_details VARCHAR(30),
	PRIMARY KEY(shipper_id)
);

-- Create a product_t table

DROP TABLE IF EXISTS product_t;
CREATE TABLE product_t
(
	product_id INTEGER,
    vehicle_maker VARCHAR(60),
    vehicle_model VARCHAR(60),
    vehicle_color VARCHAR(60),
    vehicle_model_year INTEGER,
     vehicle_price DECIMAL(14,2),
	PRIMARY KEY(product_id)
);

-- Create a order_t table

DROP TABLE IF EXISTS order_t;
CREATE TABLE order_t
(
	order_id VARCHAR(25),
    customer_id VARCHAR(25),
	shipper_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    vehicle_price DECIMAL(10, 2),
    order_date DATE,
    ship_date DATE,
    discount DECIMAL(4,2),
    offender_sex CHAR(1),
    ship_mode VARCHAR(25),
    shipping VARCHAR(30),
    customer_feedback VARCHAR(20),
    quarter_number INTEGER,
	PRIMARY KEY(order_id)
);

-- Create a customer_t table

DROP TABLE IF EXISTS customer_t;
CREATE TABLE customer_t
(
	customer_id VARCHAR(25),
    customer_name VARCHAR(25),
    gender VARCHAR(15),
    job_title VARCHAR(50),
    phone_number VARCHAR(20),
    email_address VARCHAR(50),
	city VARCHAR(50),
    country VARCHAR(25),
    state VARCHAR(40),
	customer_address VARCHAR(50),
	postal_code INTEGER,
    credit_card_type VARCHAR(40),
    credit_card_number BIGINT,
	PRIMARY KEY(customer_id)
);

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Stored Procedures Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [4] Creating the Stored Procedures:
-- FUNCTIONALITY: CREATE PROCEDURE vehicles_p() will insert the columns and, when called, the column data from the temp_t table into the main vehicles_t ingestion table.
--                For the Nomralized tables, each respective procedure will populated each respective table with the specified columns and, when called, the column data from the vehicles_t table.
-- OBSERVATIONS:  Herein, there is no need to re-define column datatypes.
--               For calls on shipper_p(), product_p(), order_p(), and customer_p(), their respective tables only get populated when new data is dumped into it.
--               Hence, no duplicate data loading; the distinct area codes of locations where primary key was already populated into vehicles_t table are not duplicated.  
-- INSIGHTS:	 The veehicles_p() procedure must be called, in order to populate the main vehicles_t(); refresh the Navigator Schema then verify the rows.
--               Transactional Layer of Data Modelling and Architecture

/* List of stored procedures to be created.
   vehicles_p, shipper_p, product_p, order_p, customer_p */
   
DROP PROCEDURE IF EXISTS vehicles_p;

DELIMITER $$
CREATE PROCEDURE vehicles_p()
BEGIN
	INSERT INTO vehicles_t(
    shipper_id,
    shipper_name,
    shipper_contact_details,
    product_id,
    vehicle_maker,
    vehicle_model,
    vehicle_color,
    vehicle_model_year,
    vehicle_price,
    order_id,
    quantity,
    order_date,
    ship_date,
    discount,
    offender_sex,
    ship_mode,
    shipping,
    customer_feedback,
    quarter_number,
    customer_id,
    customer_name,
    gender,
    job_title,
    phone_number,
    email_address,
	city,
    country,
    state,
	customer_address,
	postal_code,
    credit_card_type,
    credit_card_number
     ) 
SELECT
	DISTINCT
	shipper_id,
    shipper_name,
    shipper_contact_details,
    product_id,
    vehicle_maker,
    vehicle_model,
    vehicle_color,
    vehicle_model_year,
    vehicle_price,
    order_id,
    quantity,
    order_date,
    ship_date,
    discount,
    offender_sex,
    ship_mode,
    shipping,
    customer_feedback,
    quarter_number,
    customer_id,
    customer_name,
    gender,
    job_title,
    phone_number,
    email_address,
	city,
    country,
    state,
	customer_address,
	postal_code,
    credit_card_type,
    credit_card_number
FROM temp_t;
END;


-- Create a Stored Procedure shipper_p

DROP PROCEDURE IF EXISTS shipper_p;

DELIMITER $$
CREATE PROCEDURE shipper_p()
BEGIN
       INSERT INTO shipper_t(
		shipper_id,
		shipper_name,
		shipper_contact_details
) SELECT 
      DISTINCT 
		shipper_id,
		shipper_name,
		shipper_contact_details
  FROM
     vehicles_t
  WHERE shipper_id NOT IN(SELECT DISTINCT shipper_id FROM shipper_t);
END;


-- Create a Stored Procedure product_p

DROP PROCEDURE IF EXISTS product_p;

DELIMITER $$
CREATE PROCEDURE product_p()
BEGIN
       INSERT INTO product_t(
		product_id,
		vehicle_maker,
		vehicle_model,
		vehicle_color,
		vehicle_model_year,
		vehicle_price
) SELECT 
      DISTINCT 
	product_id,
    vehicle_maker,
    vehicle_model,
    vehicle_color,
    vehicle_model_year,
    vehicle_price
FROM
     vehicles_t
  WHERE product_id NOT IN(SELECT DISTINCT product_id FROM product_t);
END;


-- Create a Stored Procedure order_p

DROP PROCEDURE IF EXISTS order_p;

DELIMITER $$
CREATE PROCEDURE order_p(quarter_number INTEGER)
BEGIN
	INSERT INTO order_t
(   
   order_id,
    quantity,
    order_date,
    ship_date,
    discount,
    offender_sex,
    ship_mode,
    shipping,
    customer_feedback,
    quarter_number
) SELECT  
	order_id,
    quantity,
    order_date,
    ship_date,
    discount,
    offender_sex,
    ship_mode,
    shipping,
    customer_feedback,
    quarter_number
FROM 
    vehicles_t
WHERE quarter_number = quarter_number;
END;


-- Create a Stored Procedure customer_p

DROP PROCEDURE IF EXISTS customer_p;

DELIMITER $$
CREATE PROCEDURE customer_p()
BEGIN
       INSERT INTO customer_t(
		  customer_id,
    customer_name,
    gender,
    job_title,
    phone_number,
    email_address,
	city,
    country,
    state,
	customer_address,
	postal_code,
    credit_card_type,
    credit_card_number
) SELECT 
      DISTINCT 
	  customer_id,
    customer_name,
    gender,
    job_title,
    phone_number,
    email_address,
	city,
    country,
    state,
	customer_address,
	postal_code,
    credit_card_type,
    credit_card_number
  FROM
     vehicles_t
  WHERE customer_id NOT IN(SELECT DISTINCT customer_id FROM customer_t);
END;


/* List of stored procedures to be created.

   Creating the stored procedure for vehicles_p, order_p, customer_p, product_p, shipper_p*/

/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Data Ingestion
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [5] Ingesting the data:
-- This quarterly_temp_dump file will load the subsequent quarter's-worth of data (and since previous data is already in the temp_t file, it should not be reloaded).
-- Truncate is like a "refresh"; Truncate empties the temporary table, which will drop the previous quarter's data dump. Then the subsequest quarter's data can be appended.
-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------
TRUNCATE temp_t;

LOAD DATA LOCAL INFILE 'C:/Users/steve/Documents/SQL_and_Databases/SQL_Database_Modelling_and_Architecture_Final_Project/Data/new_wheels_sales_qtr_1.csv' -- w1,w2,w3,w4 to load that week's data
INTO TABLE temp_t
FIELDS TERMINATED by ','
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

call vehicles_p();
call customer_p();
call product_p();
call shipper_p();
call order_p();

/* Note: 

---> With the help of the above code, you can ingest the data into temp_t table by ingesting the quarterly data and by calling the stored 
     procedures you can ingest the data into separate table.
---> You have to run the above ingestion code 4 times as 4 quarters of data are present and you also need to call all the stored procedures 
     4 times. Please change the argument value while calling the stored procedure order_p(n). (n = 1,2,3,4)
---> If needed revisit the videos: Week 2: Data Modeling and Architecture: Ingesting data into the main table and Ingesting future weeks of data
---> Also revisit the codes used to ingest the data for the gl_eats database. 
     This will help in getting a better understanding of how to ingest the data into various respective tables.*/


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Views Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [6] Creating the views:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating views for answers to business questions
---> Also revisit the codes used to create views for the gl_eats database. 
	 This will help in getting a better understanding of the creation of views.*/

-- Syntax to create view-

-- To drop the views if already exists- 
DROP VIEW IF EXISTS view_name;

-- To create a view-
CREATE VIEW view_name AS
    SELECT
	n1.column_name1,
    n2.column_name2,
    ..
    ..
    ..
FROM table_name1 n1
	INNER JOIN table_name2 n2
	    ON n1.column_name1 = n2.column_name2;

-- List of views to be created are "veh_prod_cust_v" , "veh_ord_cust_v"


/*-----------------------------------------------------------------------------------------------------------------------------------

                                               Functions Creation
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/

-- [7] Creating the functions:

/*Note: 

---> If needed revisit the videos: Week-2: Data Modeling and Architecture: Creating User Defined Functions
---> Also revisit the codes used to create functions for the gl_eats database. 
     This will help in getting a better understanding of the creation of functions.*/

-- Create the function calc_revenue_f

-- Syntax to create function-

DELIMITER $$  
CREATE FUNCTION calc_revenue_f (column_name1 datatype, column_name2 datatype, column_name3 datatype) 
RETURNS DECIMAL
DETERMINISTIC  
BEGIN  

-- statements  

END;


-- Create the function days_to_ship_f-

DELIMITER $$
CREATE FUNCTION days_to_ship_f (column_name1 datatype, column_name2 datatype) 
RETURNS INTEGER
DETERMINISTIC
BEGIN  

-- statements

END;

/*-----------------------------------------------------------------------------------------------------------------------------------
Note: 
After creating tables, stored procedures, views and functions, attempt the below questions.
Once you have got the answer to the below questions, download the csv file for each question and use it in Python for visualisations.
------------------------------------------------------------------------------------------------------------------------------------ 

  
  
-----------------------------------------------------------------------------------------------------------------------------------

                                                         Queries
                                               
-----------------------------------------------------------------------------------------------------------------------------------*/
  
/*-- QUESTIONS RELATED TO CUSTOMERS
     [Q1] What is the distribution of customers across states?
     Hint: For each state, count the number of customers.*/



-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q2] What is the average rating in each quarter?
-- Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

Hint: Use a common table expression and in that CTE, assign numbers to the different customer ratings. 
      Now average the feedback for each quarter. 

Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question.*/





-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q3] Are customers getting more dissatisfied over time?

Hint: Need the percentage of different types of customer feedback in each quarter. Use a common table expression and
	  determine the number of customer feedback in each category as well as the total number of customer feedback in each quarter.
	  Now use that common table expression to find out the percentage of different types of customer feedback in each quarter.
      Eg: (total number of very good feedback/total customer feedback)* 100 gives you the percentage of very good feedback.
      
Note: For reference, refer to question number 10. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions from this question*/
      




-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q4] Which are the top 5 vehicle makers preferred by the customer.

Hint: For each vehicle make what is the count of the customers.*/





-- ---------------------------------------------------------------------------------------------------------------------------------

/*[Q5] What is the most preferred vehicle make in each state?

Hint: Use the window function RANK() to rank based on the count of customers for each state and vehicle maker. 
After ranking, take the vehicle maker whose rank is 1.*/






-- ---------------------------------------------------------------------------------------------------------------------------------

/*QUESTIONS RELATED TO REVENUE and ORDERS 

-- [Q6] What is the trend of number of orders by quarters?

Hint: Count the number of orders for each quarter.*/






-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q7] What is the quarter over quarter % change in revenue? 

Hint: Quarter over Quarter percentage change in revenue means what is the change in revenue from the subsequent quarter to the previous quarter in percentage.
      To calculate you need to use the common table expression to find out the sum of revenue for each quarter.
      Then use that CTE along with the LAG function to calculate the QoQ percentage change in revenue.
      
Note: For reference, refer to question number 5. Week-2: Hands-on (Practice)-GL_EATS_PRACTICE_EXERCISE_SOLUTION.SQL. 
      You'll get an overview of how to use common table expressions and the LAG function from this question.*/
      
      
      
      
      

-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q8] What is the trend of revenue and orders by quarters?

Hint: Find out the sum of revenue and count the number of orders for each quarter.*/







-- ---------------------------------------------------------------------------------------------------------------------------------

/* QUESTIONS RELATED TO SHIPPING 
    [Q9] What is the average discount offered for different types of credit cards?

Hint: Find out the average of discount for each credit card type.*/




-- ---------------------------------------------------------------------------------------------------------------------------------

/* [Q10] What is the average time taken to ship the placed orders for each quarters?
   Use days_to_ship_f function to compute the time taken to ship the orders.

Hint: For each quarter, find out the average of the function that you created to calculate the difference between the ship date and the order date.*/





-- --------------------------------------------------------Done----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------



