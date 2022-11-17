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