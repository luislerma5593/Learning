# SQL Functions

### Basic
```sql
SHOW DATABASES - Show DB available
SHOW TABLES - Show tables available
SHOW COLUMNS - Show columns available
SELECT DISTINCT country - To get all unique values for a column
SELECT CONCAT(a, ', ' , b) FROM - Concatenate strings
UPPER(Name) - Comverts string to upercase
LOWER(Name) - Converts string to lowercase
SQRT() - Square root
AVG() - Avergae
UNION - Combines multiple datasets into a single dataset, and removes any existing duplicates.
UNION ALL - Combines multiple datasets into one dataset, but does not remove duplicate rows.
```

### Other functions
```sql
coalesce(NULL, 1, 3) - coalesce() checks arguments in order and returns the first non-NULL value, if one exists.
SELECT COALESCE(a, b, 'Unknown') - Unknown as "fallback" value	
SELECT left/right(string,x) - Gets x characters from the left/right
HAVING x > y - Having is used instead of WHERE, when using aggregate functions
```
#### Example
```sql
SELECT release_year, COUNT(title)
FROM films
GROUP BY release_year
HAVING COUNT(title) > 10;
```

### Insert data
```sql
INSERT INTO table_name
VALUES (value1, value2, value3,...);
```

### Update data
```sql
UPDATE table_name
SET column1=value1, column2=value2, ...
WHERE condition;

# Example
UPDATE company
SET salary = salary*1.2
WHERE rating > 5;
```

### Delete data
```sql
DELETE FROM table_name
WHERE condition; 
```

### Create table
```sql
CREATE TABLE ​table_name
(
column_name1 data_type(size),
column_name2 data_type(size),
column_name3 data_type(size),
....
columnN data_type(size)
)

# Example
CREATE TABLE Users (
id int NOT NULL AUTO_INCREMENT,
username varchar(40) NOT NULL, 
password varchar(10) NOT NULL,
PRIMARY KEY(id)
);
```

### Data Types
```sql
Data types specify the type of data for a particular column.

If a column called "LastName" is going to hold names, then that particular column should have a "varchar" (variable-length character) data type.
The most common data types:
Numeric
INT -A normal-sized integer that can be signed or unsigned.
FLOAT(M,D) - A floating-point number that cannot be unsigned. You can optionally define the display length (M) and the number of decimals (D).
DOUBLE(M,D) - A double precision floating-point number that cannot be unsigned. You can optionally define the display length (M) and the number of decimals (D).

Date and Time
DATE - A date in YYYY-MM-DD format.
DATETIME - A date and time combination in YYYY-MM-DD HH:MM:SS format.
TIMESTAMP - A timestamp, calculated from midnight, January 1, 1970
TIME - Stores the time in HH:MM:SS format.

String Type
CHAR(M) - Fixed-length character string. Size is specified in parenthesis. Max 255 bytes.
VARCHAR(M) - Variable-length character string. Max size is specified in parenthesis.
BLOB - "Binary Large Objects" and are used to store large amounts of binary data, such as images or other types of files.
TEXT - Large amount of text data.
```

### Modify a table
```sql
ALTER TABLE People ADD DateOfBirth date - Add column to a table
ALTER TABLE People RENAME FirstName TO name - Rename a column in a table
RENAME TABLE ​People TO Users - Rename a table
```

### Dropping
```sql
ALTER TABLE People DROP COLUMN DateOfBirth - Delete column
DROP TABLE ​People - Drop table
```

### Modify table and update
```sql
ALTER TABLE cities ADD AttractivePlace varchar(100);

UPDATE cities
SET AttractivePlace = 'Belem Tower' WHERE name = 'Lisbon';
UPDATE cities
SET AttractivePlace = 'Plaza Mayor' WHERE name = 'Madrid';
UPDATE cities
SET AttractivePlace = 'Eiffel Tower' WHERE name = 'Paris';

SELECT * FROM cities;
```

### Views
```sql
CREATE VIEW view_name AS
SELECT column_name(s)
FROM table_name
WHERE condition;
```

### Create or replace View
```sql
CREATE OR REPLACE VIEW List AS
SELECT FirstName, LastName, Salary
FROM  Employees;
```

### Drop view
```sql
DROP VIEW ​List;
```

### Stored Procedures
```sql
CREATE DEFINER=`lldlt`@`%` PROCEDURE `insert_row`(IN a VARCHAR(1), IN b INT, IN c INT)
BEGIN
	INSERT INTO users2 (gender, age, occupation)
	VALUEs	(a,b,c);
	SELECT * FROM users2;
END

CALL insert_row("F",9, 2);
```

## Examples

### REGEX
```sql
SELECT DISTINCT(city) FROM station WHERE city REGEXP "^[aeiou]"
```
### Substract not null
```sql
SELECT count(*) - count(industry) AS missing FROM fortune500;
```

# Datacamp - SQL for Database Administrators

### INSERT DISTINCT columns into new table
```sql
INSERT INTO table2
SELECT DISTINCT column, column2
FROM table1;
```

### Drop a Column
```sql
ALTER TABLE table_name 
DROP COLUMN colmn_name;
```

### Casting
```sql
SELECT temp * CAST(speed AS integer) AS wind_chill
FROM weather;
```

### Alter Data types
```sql
ALTER TABLE table_name
ALTER COLUMN column_name
TYPE varchar(128);

ALTER TABLE table_name
ALTER COLUMN column_name
TYPE integer
--Turnos 5.54 into 6
USING ROUND(average_grade);

-- Convert the values in firstname to a max. of 16 characters
ALTER TABLE professors 
ALTER COLUMN firstname 
TYPE varchar(16)
USING SUBSTRING(firstname FROM 1 FOR 16)
```

### NULL
```sql
CREATE TABLE students(
	ssn integer not null,
	lastname varchar(64) not null,
	phone integer,
	office_phone integer
	)

-- Add null constraint
ALTER TABLE students
ALTER COLUMN home_number
SET NOT  NULL;

-- Remove null constraint
ALTER TABLE students
ALTER COLUMN home_number
DROP NOT  NULL;
```

### UNIQUE
```sql
CREATE TABLE table_name (
	column_name UNIQUE
	);
	
ALTER TABLE table_name 
ADD CONSTRAINT some_name UNIQUE (column_name);
```

### Different combinations to get a key
```sql
-- Try out different combinations
select COUNT(distinct(firstname, lastname)) 
FROM professors;
```

### Setting a PK
```sql
CREATE TABLE table_name(
	id integer PRIMARY  KEY,...
	)

-- Multiple PKs
CREATE TABLE table_name(
	a integer,
	b integer,
	c integer,
	PRIMARY KEY (a,c)
	)
```

### Surrogate Primary Key (New column PK)
```sql
UPDATE table_name
SET column_c = CONCAT(colmn_a,column_b);
ALTER TABLE table_name
ADD CONSTRAINT pk PRIMARY KEY (column_c);
```

### Specifying foreign keys
```sql
INSERT INTO manufacturers
VALUES (''),(''),('');

CREATE TABLE cars (
model varchar(255) PRIMARY KEY,
manufacturer_name varchar(255) REFERENCES manufacturers (name));

INSERT INTO cars
VALUES ('x'),('y');
```

### Specifying foreign keys for existing tables
```sql
ALTER TABLE a
ADD CONTRAINT a_fkey FOREGIN KEY (b_id) REFERENCES b (id);

-- Add a foreign key on professors referencing universities
ALTER TABLE professors 
ADD CONSTRAINT professors_fkey FOREIGN KEY (university_id) REFERENCES universities (id);
```

### How to implement N:M relationships
```sql
CREATE TABLE affiliations (
 profesor_id integer REFERENCES professors (id),
 organization_id varchar(256) REFERENCES organization (id),
 function varchar(256)
);
```

### Update a null column from another table
```sql
-- Update professor_id to professors.id where firstname, lastname correspond to rows in professors
UPDATE affiliations
SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname AND affiliations.lastname = professors.lastname;

-- Have a look at the 10 first rows of affiliations again
select * from affiliations limit 10;
```

### ** Referential integrity
```sql
--Dealing with violations

-- No action (Throw an error)
CREATE TABLE cars (
model varchar(255) PRIMARY KEY,
manufacturer_name varchar(255) REFERENCES manufacturers (name) ON DELETE NO ACTION);

--Cascade (Will delete the reference and referenced)
CREATE TABLE cars (
model varchar(255) PRIMARY KEY,
manufacturer_name varchar(255) REFERENCES manufacturers (name) ON DELETE CASCADE);

RESTRICT is like NO ACTION

SET NULL - Will set the value of the foreign key for NULL

SET DEFAULT - Wet the referencing column to its default value


Examples


-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';

-- Drop the right foreign key constraint
ALTER TABLE affiliations
DROP CONSTRAINT affiliations_organization_id_fkey;

-- Add a new foreign key constraint from affiliations to organizations which cascades deletion
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES organizations (id) ON DELETE CASCADE;

-- Delete an organization 
DELETE FROM organizations 
WHERE id = 'CUREM';

-- Check that no more affiliations with this organization exist
SELECT * FROM affiliations
WHERE organization_id = 'CUREM';
```

### Roundup
```sql
 -- Filter the table and sort it
SELECT COUNT(*), organizations.organization_sector, 
professors.id, universities.university_city
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
JOIN organizations
ON affiliations.organization_id = organizations.id
JOIN universities
ON professors.university_id = universities.id
WHERE organizations.organization_sector = 'Media & communication'
GROUP BY organizations.organization_sector, 
professors.id, universities.university_city
order BY COUNT DESC;
```

### Examples
```sql
-- Rename the organization column to id
ALTER TABLE organizations
RENAME COLUMN organization TO id;

-- Make id a primary key
ALTER TABLE organizations
ADD CONSTRAINT organization_pk PRIMARY KEY (id);

-- Add the new column to the table
ALTER TABLE professors 
ADD COLUMN id serial;

-- Make id a primary key
ALTER TABLE professors 
ADD CONSTRAINT professors_pkey PRIMARY KEY (id);

-- Have a look at the first 10 rows of professors
SELECT *
FROM professors
LIMIT 10;

---

-- Add a professor_id column
ALTER TABLE affiliations
ADD COLUMN professor_id integer REFERENCES professors (id);

-- Rename the organization column to organization_id
ALTER TABLE affiliations
RENAME organization TO organization_id;

-- Add a foreign key on organization_id
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_fkey FOREIGN KEY (organization_id) REFERENCES organizations (id);
```


## Database Design

ETL - Oriented for smaller-scale analyticsand warehouses

ELT - Oriented to big data projects and Deep Learning (Data loaded and transformed in the Data Lake) 

### Dimentional model

Includes:
* Fact tables (mainy ids/foreign keys)
* Dimensional tables (Inormation from the foreign keys in the fact table)

Normalization is a technique that divides tables into smalles tables and connects them via relationships

Star schema: Denormalized

* Good for OLAP (Data Warehouses), for quicker queries

Snowflake schema: Normalized

* Good for OLTP (Operational Databases), for quicker and safer insertion

- It´s better to avoid data redundancy (repeat a lot of times the same value)
- Enfocs data consistency ('California' instead of 'CA')
- Safer updating, removing and inserting
- Easier to redesign by extending

```sql
-- EXAMPLEOF DIM TABLES

-- Create a route dimension table
CREATE TABLE route(
	route_id INTEGER PRIMARY KEY,
    park_name VARCHAR(160) NOT NULL,
    city_name  VARCHAR(160) NOT NULL,
    distance_km float NOT NULL,
    route_name  VARCHAR(160) NOT NULL
);
-- Create a week dimension table
CREATE TABLE week(
	week_id INTEGER PRIMARY KEY,
    week INTEGER NOT NULL,
    month  VARCHAR(160) NOT NULL,
    year  INTEGER NOT NULL
);
```
### Star Schema
```sql
-- Add the book_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_book
    FOREIGN KEY (book_id) REFERENCES dim_book_star (book_id);
    
-- Add the time_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_time
    FOREIGN KEY (time_id) REFERENCES dim_time_star (time_id);
    
-- Add the store_id foreign key
ALTER TABLE fact_booksales ADD CONSTRAINT sales_store
    FOREIGN KEY (store_id) REFERENCES dim_store_star (store_id);
```

### Querying from star schema
```sql
-- Output each state and their total sales_amount
SELECT dim_store_star.state, SUM(fact_booksales.sales_amount)
FROM fact_booksales
	-- Join to get book information
    JOIN dim_book_star on dim_book_star.book_id = fact_booksales.book_id
	-- Join to get store information
    JOIN dim_store_star on dim_store_star.store_id = fact_booksales.store_id
-- Get all books with in the novel genre
WHERE  
    dim_book_star.genre = 'novel'
-- Group results by state
GROUP BY
    dim_store_star.state;
```

### Querying from snowflake schema
```sql
-- Output each state and their total sales_amount
SELECT dim_state_sf.state, SUM(fact_booksales.sales_amount)
FROM fact_booksales
    -- Joins for genre
    JOIN dim_book_sf on fact_booksales.book_id = dim_book_sf.book_id
    JOIN dim_genre_sf on dim_book_sf.genre_id = dim_genre_sf.genre_id
    -- Joins for state 
    JOIN dim_store_sf on fact_booksales.store_id = dim_store_sf.store_id 
    JOIN dim_city_sf on dim_store_sf.city_id = dim_city_sf.city_id
	JOIN dim_state_sf on  dim_city_sf.state_id = dim_state_sf.state_id
-- Get all books with in the novel genre and group the results by state
WHERE  
    dim_genre_sf.genre = 'novel'
GROUP BY
    dim_state_sf.state;
```

###Add NOT NULL DEFAULT
```sql
-- Add a continent_id column with default value of 1
ALTER TABLE dim_country_sf
ADD continent_id int NOT NULL DEFAULT(1);

-- Add the foreign key constraint
ALTER TABLE dim_country_sf ADD CONSTRAINT country_continent
   FOREIGN KEY (continent_id) REFERENCES dim_continent_sf(continent_id);
   
-- Output updated table
SELECT * FROM dim_country_sf;
```

### 1NF (avoid two values in one cell)
```sql
-- Create a new table to hold the cars rented by customers
CREATE TABLE cust_rentals (
  customer_id INT NOT NULL,
  car_id VARCHAR(128) NULL,
  invoice_id VARCHAR(128) NULL
);

-- Drop column from customers table to satisfy 1NF
ALTER TABLE customers
DROP COLUMN cars_rented,
DROP COLUMN invoice_id;
```

### 2NF (Remove everything that does not depend on the PK)

In this case, this information depends on car_id, no the PK
```sql
-- Create a new table to satisfy 2NF
CREATE TABLE cars (
  car_id VARCHAR(256) NULL,
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128),
  condition VARCHAR(128),
  color VARCHAR(128)
);

-- Drop columns in customer_rentals to satisfy 2NF
ALTER TABLE customer_rentals
DROP COLUMN model,
DROP COLUMN manufacturer,
DROP COLUMN type_car,
DROP COLUMN condition,
DROP COLUMN color;
```

### 3NF (Remove data that depends on the non-key column)

So, we have to create another dimension
```sql
-- Create a new table to satisfy 3NF
CREATE TABLE car_model(
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128)
);

-- Drop columns in rental_cars to satisfy 3NF
ALTER TABLE rental_cars
DROP COLUMN manufacturer,
DROP COLUMN type_car;
```

## Views

It's recommended to use views, for read-only purposes.

#### Non-materialized view
* Stores the query

#### Materialized view
* Stores the result of the query
* Allows to run longs queries and get results quickly
* Particularly useful in data warehouses
* Has to be refreshed

```sql
CREATE VIEW view_name AS
```

### Looking for existing views
```sql
SELECT*FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');
```

### Granting and revoking with views
```sql
GRANT UPDATE ON ratings TO PUBLIC;
REVOKE INSERT ON films FROM db_user;

-- Revoke everyone's update and insert privileges
REVOKE UPDATE, insert on long_reviews FROM PUBLIC; 

-- Grant the editor update and insert privileges 
GRANT UPDATE, insert on long_reviews TO editor; 
```

### Create or replace

```sql
DROP VIEW view_name [CASCADE|RESTRICT];

CREATE OR REPLACE VIEW view_name AS new_query - But the table has to contain the same columns (more can be added)

-- Redefine the artist_title view to have a label column
create or replace view artist_title AS
SELECT reviews.reviewid, reviews.title, artists.artist, labels.label
FROM reviews
INNER JOIN artists
ON artists.reviewid = reviews.reviewid
INNER JOIN labels
ON artists.reviewid = labels.reviewid;
```

### Other
```sql
ALTERVIEW [ IF EXISTS ] name ALTER [ COLUMN ] column_name SET DEFAULT expression
ALTERVIEW [ IF EXISTS ] name ALTER [ COLUMN ] column_name DROP DEFAULT
ALTERVIEW [ IF EXISTS ] name OWNER TO new_owner
ALTERVIEW [ IF EXISTS ] name RENAME TO new_name
ALTERVIEW [ IF EXISTS ] name SET SCHEMA new_schema
ALTERVIEW [ IF EXISTS ] name SET ( view_option_name [= view_option_value] [, ... ] 
ALTERVIEW [ IF EXISTS ] name RESET ( view_option_name [, ... ] )1
```

### Materialized VIEWS
```sql
CREATE MATERIALIZED VIEW view_name AS ...;

REFRESH MATERIALIZED VIEW view_name;

### Refreshing example

-- Create a materialized view called genre_count 
create materialized view genre_count as
SELECT genre, COUNT(*) 
FROM genres
GROUP BY genre;

INSERT INTO genres
VALUES (50000, 'classical');

-- Refresh genre_count
REFRESH MATERIALIZED VIEW genre_count;

SELECT * FROM genre_count;
```

## Database management

### Roles 

* There is a list of different privileges that can be assigned
* A role is an entity that can work for a user or a group

A group, can contain different roles, that you can give privileges to.

```sql
CREATE ROLE data_analyst; -- Can be a group role

CREATE ROLE alex WITH PASSWORD 'password' VALID UNTIL '2022-01-01'; -- Can be a user role
GRANT data_analyst TO alex; -- To add Alex to the DA group role
REVOKE data_analyst FROM alex;

CREATE ROLE admin CREATEDB; --Attribute to create databases

ALTER ROLE admin CREATEROLE; -- To change an attribute from a role

GRANT UPDATE ON ratings TO data_analyst; -- To give access to roles

REVOKE UPDATE ON ratings FROM data_analyst;
```

### Tables partitioning

To divide big tables into smaller ones. It can be partitioned into vertical and horizontal

- Vertical partitioning
To move some redundant columns into another table

- Horizontal partitioning
To divide the table into multiple subtables, it can be done according by the timestamp

```sql
CREATE TABLE sales (
	...
	timestamp DATE NOT NULL
)
PARTITION BY RANGE (timestamp)

CREATE TEABLE sales_2019_q1 PARTITION OF sales
	FOR VALUES FROM ('2019-01-01') TO ('2019-03-31');
...
CREATE TEABLE sales_2019_q4 PARTITION OF sales
	FOR VALUES FROM ('2019-09-01') TO ('2019-12-31');
```

#### Vertical partitioning
```sql
-- Create a new table called film_descriptions
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);

-- Copy the descriptions from the film table
INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;
    
-- Drop the descriptions from the original table
ALTER TABLE film DROP COLUMN  long_description;

-- Join to view the original table
SELECT * FROM film 
JOIN film_descriptions 
USING(film_id);
```

#### Horizontal partitioning
```sql
-- Create a new table called film_partitioned
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);

-- Create the partitions for 2019, 2018, and 2017
CREATE TABLE film_2019
	PARTITION OF film_partitioned FOR VALUES IN ('2019');

CREATE TABLE film_2018
	PARTITION OF film_partitioned FOR VALUES IN ('2018');

CREATE TABLE film_2017
	PARTITION OF film_partitioned FOR VALUES IN ('2017');

-- Insert the data into film_partitioned
INSERT INTO film_partitioned
SELECT film_id, title, release_year FROM film;

-- View film_partitioned
SELECT * FROM film_partitioned;
```

### Data integration

When there are different data sources and is wanted to have a unified data model with all the information.
```sql
Data_Source_1 > Transformation_1  \
Data_Source_2 > Transformation_2  - > Unified Data Model
Data_Source_3 > Transformation_3  /
```

### DBMS

For the NoSQL, there are 4 typres of DB:

1. Key-valye (Redi)
2. Document (MongoDB)
3. Grpah (Neo4j)
4. ColumnStore

SQL DB are the best option for data integrity and consistency

NoSQL is better for big data analytics, because db are more scalable, less structure, no schemas needed, large quantities of data


## Creating PostgreSQL DB

### Structure

```sql

-- Databases
CREATE DATABASE db_name;

-- Tables
CREATE TABLE table_name(
	column_1 datatype [constraints]
	...);

-- Schema
CREATE SCHEMA schema_name;
CREATE TABLE schema.table ...;

-- Examples
-- Create a table named 'bank' in the 'loan_504' schema
CREATE TABLE loan_504.bank (
    id serial PRIMARY KEY,
    name VARCHAR (100) NOT NULL
);
```

### Data Types
```sql
SERIAL - For primary key
VARCHAR - Variable length
CHAR - Fixed length
INTEGER
DECIMAL(precision, scale) - 'Precision' is the total numbers, 'scale' is the total decimals
```

### Normalization
```sql
-- Create the contact table
create table contact (
  	-- Define the id primary key column
	id SERIAL primary key,
  	-- Define the name column
  	name varchar(50) NOT NULL,
    -- Define the email column
  	email VARCHAR(50) NOT NULL
);

-- Add contact_id to the client table
ALTER TABLE client ADD contact_id INTEGER NOT NULL;

-- Add a FOREIGN KEY constraint to the client table
ALTER TABLE client ADD CONSTRAINT fk_c_id FOREIGN KEY (contact_id) REFERENCES contact(id);
```

#### 1st Normal Form

* Divid into the smallest value possible; it's called, atomic values
* No muliple values, should be in one single column
* After 1NF, there are a lot of duplicted values, but that is ssolved in 2NF/3NF

1. Change to PK into an INT, so one id can be used in multiple records (like different courses for one student)
2. Divide complete name into first_name and last_name

#### 2nd Normal Form

* Satisfies 1NF
* Non-key columns only depend on the table's PK
* To avoid to delete information that there's only in the main table
* Move extra information into another table, and just keep a foreign key, that will be the connection to the new table with all the extra information

1. Move publisher data into it's own table
2. Delete it from the textbook table

```sql
///FROM///
CREATE TABLE meal (
    id INTEGER,
    name VARCHAR(50) NOT NULL
    ingredients VARCHAR(150), -- comma seperated list
    avg_student_rating NUMERIC,
    date_served DATE,
    total_calories SMALLINT NOT NULL
);

///INTO///
CREATE TABLE ingredient (
  -- Add PRIMARY KEY for table
  id serial primary key,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE meal (
    -- Make id a PRIMARY KEY
	id serial primary key,
    name VARCHAR(50) NOT NULL,

	-- Remove the 2 columns (below) that do not satisfy 2NF
  	--ingredients VARCHAR(150), -- comma separated list
    avg_student_rating NUMERIC,
    --date_served DATE,
    total_calories SMALLINT NOT NULL
);

CREATE TABLE meal_date (
    -- Define a column referencing the meal table
  	meal_id INTEGER REFERENCES meal(id),
    date_served DATE NOT NULL
);

CREATE TABLE meal_ingredient (
  	meal_id INTEGER REFERENCES meal(id),
  
    -- Define a column referencing the ingredient table
    ingredient_id INTEGER REFERENCES ingredient(id)
);
```

#### 3rd Normal Form

* Satisfies 2NF
* All nom-key columns are only dependent on the PRIMARY KEY
* No "transitive dependencies" exist
	A -> B -> C; A -> C (transitive dependency)

***Example: *** Correct. city and state are dependent on zip_code and this transitive dependency must be removed to satisfy 3rd Normal Form. Great job!

```sql
-- Add columns to the borrower table
ALTER TABLE borrower
ADD COLUMN first_name VARCHAR (50) NOT NULL,
ADD COLUMN last_name VARCHAR (50) NOT NULL;

-- Remove column from borrower table to satisfy 1NF
ALTER TABLE borrower
DROP COLUMN full_name;

-- Add a new column called 'zip' to the 'bank' table 
ALTER TABLE bank
ADD COLUMN zip VARCHAR(10) NOT NULL;

-- Remove a corresponding column from 'loan' to satisfy 2NF
ALTER TABLE loan
DROP COLUMN bank_zip;

-- Define 'program' table with max amount for each program
CREATE TABLE program (
  	id serial PRIMARY KEY,
  	description text NOT NULL,
  	max_amount DECIMAL(9,2) NOT NULL
);

-- Alter the 'loan' table to satisfy 3NF
ALTER TABLE loan
ADD COLUMN program_id INTEGER REFERENCES program (id), 
DROP COLUMN max_amount,
DROP COLUMN program;
```

### Access control in PostgreSQL

- Default **superuser** role
	* Creating DB
	* Dropping DB
	* Inserting records
	* Deleting records
	* Dropping tables

#### Users
```sql
- CREATE USER new_user; --No access to tables created by other users
	
- CREATE USER new_user WITH PASSWORD "password";

- ALTER USER new_user WITH PASSWORD "new_password";
```

#### Access privileges

- GRANT (SELECT - Query, INSERT - Add, DELETE, UPDATE)
- REVOKE

GRANT p ON obj TO grantee;

* Modifying a table, requires owernship, but can transfer the ownership

ALTER TABLE account OWNER TO fin_user;

#### Hierarchical access control
```sql
CREATE SCHEMA schema_name;

CREATE TABLEschema.table (...);

GRANT USAGE ON SCHEMA schema_name TO user_name;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA schema_name TO user_name;

CREATE GROUP family; -- Access control can be applied at group level

GRANT USAGE ON SCHEMA x TO family;
GRANT SELECT ON ALL TABLES IN SCHEMA x to family;
ALTER GROUP famili ADD USER user;
```

Example of all teh above:
```sql
-- Create a user account for Ronald Jones
CREATE USER rjones WITH PASSWORD 'changeme';

-- Create a user account for Kim Lopez
CREATE USER klopez WITH PASSWORD 'changeme';

-- Create a user account for Jessica Chen
CREATE USER jchen WITH PASSWORD 'changeme';

-- Create the dev_team group
CREATE GROUP dev_team;

-- Grant privileges to dev_team group on loan table
GRANT INSERT, UPDATE, DELETE, SELECT ON loan TO dev_team;

-- Add the new user accounts to the dev_team group
ALTER GROUP dev_team ADD USER rjones, klopez, jchen;

////////////////////

-- Create the development schema
create schema development;

-- Grant usage privilege on new schema to dev_team
grant USAGE ON SCHEMA development TO dev_team;

-- Create a loan table in the development schema
CREATE TABLE development.loan (
	borrower_id INTEGER,
	bank_id INTEGER,
	approval_date DATE,
	program text NOT NULL,
	max_amount DECIMAL(9,2) NOT NULL,
	gross_approval DECIMAL(9, 2) NOT NULL,
	term_in_months SMALLINT NOT NULL,
	revolver_status BOOLEAN NOT NULL,
	bank_zip VARCHAR(10) NOT NULL,
	initial_interest_rate DECIMAL(4, 2) NOT NULL
);

-- Grant privileges on development schema
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA development TO dev_team;
```

Other example
```sql
-- Create the new analysis schema
CREATE SCHEMA analysis;

-- Create a table unapproved loan under the analysis schema
CREATE TABLE analysis.unapproved_loan (
    id serial PRIMARY KEY,
    loan_id INTEGER REFERENCES loan(id),
    description TEXT NOT NULL
);

-- Create 'data_scientist' user with password 'changeme'
CREATE USER data_scientist WITH password 'changeme';

-- Give 'data_scientist' ability to use 'analysis' schema
GRANT USAGE ON SCHEMA analysis TO data_scientist;

-- Grant read-only access to table for 'data_scientist' user
GRANT SELECT ON analysis.unapproved_loan TO data_scientist;
```

#### Removing access
```sql
REVOKE DELETE, TRUNCATE ON finances.* FROM cousin;
REVOKE ALL PRIVILEGES ON finances.* FROM cousin;
REVOKE family FROM cosuin;
```

## Query Optimization

#### CTEs (Common table expressions)
- Available for one query
- Can return one result
- Creates a temporary table

```sql
WITH english_cte AS
(
 SELECT word_lenth, COUNT(word) AS word_count AS english_word_count
 FROM english_language
)
```

#### Temporary tables

- They are available for the duration of the DB session, using temporarily DB resources
- Only available for the creator
- Materializes a view (which stores just the query) for the duration of the session

```sql
CREATE TEMP TABLE usa_holidays AS
 SELECT holiday, holiday_type
 FROM world_holidays
 WHERE country_code = 'USA';
 
 ANALYZE usa_holidays; --Is a good practice to add this after the table creation. No output, but helps with the query execution plan
```

#### SQL Logical order

1. FROM
2. WHERE
3. GROUP BY
4. SUM(), COUNT()
5. SELECT
6. DISTINCT
7. ORDER BY
8. LIMIT

How to use ANY:
```sql
WHERE country LIKE ANY(ARRAY["a", "b"])
WHERE county IN (a,b)
```

### Databases properties

Table - base storage
Temp table - speeds query using big table, lasts for the duration of the session
View - complicated logic or calculated fields, stores the query
Materializedview - complicated logic that slows performance, stores the data

#### Row-Oriented storage and partitions

Row-oriented - Relation between columns remains
Column-oriented - Relation between rows remains

* Partitions
Method of splitting one parent table into many. Any query with a WHERE clause, outputs a children table, which are not visible in the front end, just can be queried

* Indexes
Method of creating sorted column keys to improve search

```sql
EXPLAIN - Is used to estimate the query cost
```

#### Indexes

* Method to create sorted column keys to improve search
* The index is a reference to data location
* To speed queries
* Often used for filtering such as date or location.
* Helpful when working with large tables or any table that is slow to query.
* Columns that are common filter conditions, are good candidates for indexes.
* Often used in primary keys

Not recommended in:
1. Small tables
2. Columns with many nulls
3. Frequently updated tables
	- Index will become fragmented, and will need to re-index to fix this (but it's an additional step)
	- Writes data in two places

```sql
CREATE INDEX index_name ON table_name (column_name);

CREATE INDEX CONCURRENTLY ON table_name (column1_name, column2_name); - Prevents the table from being locked while the index is being built
```
#### Column-oriented

Is ideal for analytics, column aggregations, reporting. It's not suited for transactional databases needs. 
