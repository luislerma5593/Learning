# Snowflake

* Identity - User - Authentication
* Access - Role - Authorization
* Role based access control (RBAC)
* ACCOUNTADMIN role is the highest one
* NEW ORGADMIN ROLE
* SEC & USER ADMINS are for enforcement
* SYS ADMIN is for creating

#### DAC
Beyond RBAC, there is another facet of Snowflake's access model called Discretionary Access Control (DAC), which means "you create it, you own it." If SYSADMIN creates a database, they own it and so they can delete it, change the name, and more.  

## Important notes

* Monitoring > Query History

## Databases

Databases are used to group datasets (tables) together. A second-level organizational grouping, within a database, is called a schema. Every time you create a database, Snowflake will automatically create two schemas for you.

The **INFORMATION_SCHEMA** schema holds a collection of views.  The INFORMATION_SCHEMA schema cannot be deleted (dropped), renamed, or moved.

The **PUBLIC** schema is created empty and you can fill it with tables, views and other things over time. The PUBLIC schema can be dropped, renamed, or moved at any time.  

### Intro to codes

```sql
SELECT 'hello';
SELECT 'hello' AS "Greeting";
SHOW databases;
SHOW schemas; -- Only schemas from current database
SHOW schemas IN ACCOUNT; -- All schemas from all databases are shown (based on current role).

--THESE ARE JUST EXAMPLES YOU SHOULD NOT RUN THIS CODE WITHOUT EDITING IT FOR YOUR NEEDS

--To add more than one row at a time
insert into root_depth (root_depth_id, root_depth_code
                        , root_depth_name, unit_of_measure
                        , range_min, range_max)  
values
 (5,'X','short','in',66,77)
,(8,'Y','tall','cm',98,99)
;

-- To remove a row you do not want in the table
delete from root_depth
where root_depth_id = 9;

--To change a value in a column for one particular row
update root_depth
set root_depth_id = 7
where root_depth_id = 9;

--To remove all the rows and start over
truncate table root_depth;
```

To get data ready for DBsd, it's necessary to use the following techniques:
1. Data Modeling
2. Normalization


## Warehouses
* In Snowflake, a warehouse isn't a place for storing data. It's the computing power.
* A warehouse is the machine that crunches the data.
* When increasing warehouse capacity, it is increasing the number of servers, keeping just one cluster per warehouse.
* Every warehouse has access to all the data all the time.
* Scalling up or Scalling down, is when you change between several or just a few servers.
* Scalling out, sometimes called "elastic data warehouses" or "Multi-cluster warehouses", because the warehouse will stretch out to take on extra work and then snap back to its original size once the work dies down. Only for Enterprise edition or above.
* A warehouse can be stretched up to 10 clusters wide during peak workloads.
* Snowflake Warehouse Sizes like eXtra-Small, Small, Medium, etc. all have one cluster. A small warehouse has one cluster made up of just a few servers. A larger warehouse has one cluster, made up of more servers.
* **Snap back** is the opposite of **scaling out**

### Creating a file format
```sql
create file format garden_plants.veggies.PIPECOLSEP_ONEHEADROW 
    TYPE = 'CSV'--csv is used for any flat file (tsv, pipe-separated, etc)
    FIELD_DELIMITER = '|' --pipes as column separators
    SKIP_HEADER = 1 --one header row to skip
    ;

create file format garden_plants.veggies.COMMASEP_DBLQUOT_ONEHEADROW 
    TYPE = 'CSV'--csv for comma separated files
    SKIP_HEADER = 1 --one header row  
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' --this means that some values will be wrapped in double-quotes bc they have commas in them
    ;
```

## DORA

For the setup:
1. API Integration
```sql
use role accountadmin;

create or replace api integration dora_api_integration
api_provider = aws_api_gateway
api_aws_role_arn = 'arn:aws:iam::321463406630:role/snowflakeLearnerAssumedRole'
enabled = true
api_allowed_prefixes = ('https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora');
```

2. Grader function
```sql
use role accountadmin;  

create or replace external function util_db.public.grader(
      step varchar
    , passed boolean
    , actual integer
    , expected integer
    , description varchar)
returns variant
api_integration = dora_api_integration 
context_headers = (current_timestamp, current_account, current_statement, current_account_name) 
as 'https://awy6hshxy4.execute-api.us-west-2.amazonaws.com/dev/edu_dora/grader'
; 
```

## Stagging data

**Stages** or **stagging Areas** are places to put things temporarily before moving them to a more stable location.

It's at the middle between Transaction (OLTP) and Reporting (OLAP). 
* Raw > Stagged > Reporting

They are like "Cloud folders", so Snowflake services can pick them up and pull them into a DB.

There are two types of stages:

### Internal stages
Like directories inside a Snowflake account local storage

### External stages

Like a secure gateway between storage services (Google, Azure BLOLB, AWS S3) and Snowflake services. It's needed a **Cloud service account**

There are three components required:
1. Cloud storage location
2. Cloud storage access credentials
3. Stage definition

```sql
-- Link to course bucket: 
https://uni-lab-files.s3.us-west-2.amazonaws.com/

-- To see the files in the stage
list @name_of_stage; 
```

#### Pre-Stage Data Movement
Would be like the delivery of goods. So it's from the external service to Snowflake.

Amazon provides three applications/method to get external data loaded into the cloud directory:
* FTP
* CLI (Command line)
* Web browser interface

Remember that to use the COPY INTO statement, it is best to have 4 things in place:
* A table 
* A stage object
* A file
* A file format 

```sql
-- COPY INTO. 
-- Load a File from the S3 Bucket into the New Table
copy into my_table_name
from @like_a_window_into_an_s3_bucket
files = ( 'IF_I_HAD_A_FILE_LIKE_THIS.txt')
file_format = ( format_name='EXAMPLE_FILEFORMAT' );

-- Querying data before loading it
select $1
from @util_db.public.like_a_window_into_an_s3_bucket/LU_SOIL_TYPE.tsv;

-- Creating file format and then loading a table

create file format garden_plants.veggies.L8_CHALLENGE_FF 
    TYPE = 'CSV'--csv for comma separated files
    FIELD_DELIMITER = '\t' --pipes as column separators
    SKIP_HEADER = 1 --one header row to skip
    ;

-- Load a File from the S3 Bucket into the New Table
copy into LU_SOIL_TYPE
from @util_db.public.like_a_window_into_an_s3_bucket
files = ( 'LU_SOIL_TYPE.tsv')
file_format = ( format_name=GARDEN_PLANTS.VEGGIES.L8_CHALLENGE_FF );
```

## Data Storage Structures

```sql
-- Sequences
create sequence SEQ_AUTHOR_UID
    start = 1
    increment = 1
    comment = 'Use this to fill in AUTHOR_ID';

-- Query the Sequence
SELECT SEQ_AUTHOR_UID.nextval;

SHOW sequences;

-- Using an example
CREATE OR REPLACE SEQUENCE "LIBRARY_CARD_CATALOG"."PUBLIC"."SEQ_AUTHOR_UID" 
START 3 
INCREMENT 1 
COMMENT = 'Use this to fill in the AUTHOR_UID every time you add a row';

//Add the remaining author records and use the nextval function instead 
//of putting in the numbers
INSERT INTO AUTHOR(AUTHOR_UID,FIRST_NAME,MIDDLE_NAME, LAST_NAME) 
Values
(SEQ_AUTHOR_UID.nextval, 'Laura', 'K','Egendorf')
,(SEQ_AUTHOR_UID.nextval, 'Jan', '','Grover')
,(SEQ_AUTHOR_UID.nextval, 'Jennifer', '','Clapp')
,(SEQ_AUTHOR_UID.nextval, 'Kathleen', '','Petelinsek');

-- Setting the sequence as default
CREATE OR REPLACE TABLE BOOK
( BOOK_UID NUMBER DEFAULT SEQ_BOOK_UID.nextval
 ,TITLE VARCHAR(50)
 ,YEAR_PUBLISHED NUMBER(4,0)
);
```

## Intro to Semi-Structured Data

Snowflake is compatible with:
* JSON
* XML
* Parquet
* Avro
* Orc

```sql
-- File format for JSON ignoring square brackets
--Create File Format for JSON Data
CREATE FILE FORMAT LIBRARY_CARD_CATALOG.PUBLIC.JSON_FILE_FORMAT 
TYPE = 'JSON' 
COMPRESSION = 'AUTO' 
ENABLE_OCTAL = FALSE
ALLOW_DUPLICATE = FALSE 
STRIP_OUTER_ARRAY = TRUE
STRIP_NULL_VALUES = FALSE 
IGNORE_UTF8_ERRORS = FALSE;

-- Returns the data in a way that makes it look like a normalized table
SELECT 
 raw_author:AUTHOR_UID
,raw_author:FIRST_NAME::STRING as FIRST_NAME
,raw_author:MIDDLE_NAME::STRING as MIDDLE_NAME
,raw_author:LAST_NAME::STRING as LAST_NAME
FROM AUTHOR_INGEST_JSON;
```