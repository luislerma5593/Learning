# PySpark

> Functions

```py
# Import SparkSession from pyspark.sql
from pyspark.sql import SparkSession

# Create my_spark
spark = SparkSession.builder.getOrCreate()

# Print my_spark
print(spark)

# Return names of tables in cluster as a list
spark.catalog.listTables()

# Don't change this query
query = "FROM flights SELECT * LIMIT 10"

# Get the first 10 rows of flights
flights10 = spark.sql(query)

# Show the results
flights10.show()

# To convert into pandas df
df = = flights10.toPandas()

```

---
## 1. Introduction to PySpark

General information
* Operations using DataFrames are automatically optimized

### Getting to know PySpark

The first step in using Spark is connecting to a cluster.

In practice, the cluster will be hosted on a remote machine that's connected to all other nodes. There will be one computer, called the master that manages splitting up the data and the computations. The master is connected to the rest of the computers in the cluster, which are called worker. The master sends the workers data and calculations to run, and they send their results back to the master.

Creating the connection is as simple as creating an instance of the `SparkContext` class.

1. Create a instance of the `SparkContext` class (like a connection to the cluster)


```py

```



### Manipulating data

### Getting started with machine learning pipelines

### Model tuning and selection

---
## 2. Big Data Fundamentals with PySpark

---
## 3. Cleaning data with PySpark

---
## 4. Feature Engineering with PySpark

---
## 5. Machine Learning with PySpark

....

```py
```