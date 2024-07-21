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