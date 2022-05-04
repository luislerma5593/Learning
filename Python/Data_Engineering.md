# Data Engineering

Extracts data through connections to several databases, transforms it using a cluster computing framework (Apache), and loads it into an analytical database. Also, it is scheduled to run in a specific order through a scheduing framework like Airflow

Sources can be external APIs or other file formats too.

## Data Engineering for Everyone

### Data worflow

1. Data collection (Data Engineer)
2. Data preparation
3. Exploration & Visualization
4. Experimentation & Prediction

Data piplelines,ensure an efficient flow of the data

Automate:
* Extracting
* Transforming
* Combining
* Validating
* Loading

Reduce:
* Human intervention
* Errors
* Time it takes data to flow

### Data Lakes & data warehouse

#### Data Lake
* Stores raw data
* Contains a lot of information
* Stores all data structures
* Requires up to date data
* Used by Data Scientists
* Big data, real time analytics

#### Data Warehouse
* Specific data for specific use
* Relatively small
* Stores mainly structured data
* More costly to update
* Optimized for data analysis
* Used by Analyst and Business Analysts
* Read-only queries

### Batch & Streaming Processing

#### Batch processing
With batch processing, data is collected in batches and then fed into an analytics system. A “batch” is a group of data points collected within a given time period.

Unlike stream processing, batch processing does not immediately feed data into an analytics system, so results are not available in real-time. With batch processing, some type of storage is required to load the data, such as a database or a file system.

#### Streaming processing

With stream processing, data is fed into an analytics system piece-by-piece as soon as it is generated. Instead of processing a batch of data over time, stream processing feeds each data point or “micro-batch” directly into an analytics platform. This allows teams to produce key insights in near real-time.

Stream processing is ideal for projects that require speed and nimbleness. The method is less relevant for projects with high data volumes or deep data analysis.

### Schedule data processing tasks

- Manual (Run a pipeline to test it)
- Time (Collecting data from google analytics every day at 00:00)
- Condition (Updating number of followers for a playlist after one user suscribes)

### Processing Data
- Clean data
- Aggregate data
- Join data

## Toolbox

1. Databases (MySQL or PostgreSQL)
2. Processing (Apache Spark or Hive)
3. Scheduling (Apache Airflow or Oozie)
- 'JoinOrder' needs to be run after 'CleanProduct' and 'CleanOrder'

* Note: Spark is the name of the engine to perform cluster computing, while PySpark is the Python library for using Spark.

## Cloud providers

Main companies are Amazon, Microsoft and Google.

### Services provided

1. Storage
2. Computation (Perform calculations on the cloud, like hosting a web server or using virtual machines)
3. Databases

![image](https://user-images.githubusercontent.com/78183885/166346654-1779461b-35f4-4d3c-a049-032fa731b97a.png)


## Schemas

- Star schema

Consist of one or more fact tables referencing any number of dimension tables. 

Fact tables: Contain records that represent things that happened in the world, like orders.
Dim tables: Contain information on the world itself, like customer names or product prices.

## Parallel computation frameworks

1. Apache Hadoop
The most important are:

	- MapReduce
Second, MapReduce was one of the first popularized big-data processing paradigms. It works similar to the example you saw in the previous video, where the program splits tasks into subtasks, distributing the workload and data between several processing units. For MapReduce, these processing units are several computers in the cluster. MapReduce had its flaws; one of it was that it was hard to write these MapReduce jobs. Many software programs popped up to address this problem, and one of them was Hive.

	- HDFS
First, HDFS is a distributed file system. It's similar to the file system you have on your computer, the only difference being the files reside on multiple different computers. HDFS has been essential in the big data world, and for parallel computing by extension. Nowadays, cloud-managed storage systems like Amazon S3 often replace HDFS.

## ETL

### Extraction

- Extraction can be by:
1. Text Files
 a. Unstructured (Text from a book)
 b. Flat files (.tsv, .csv)
 
2. Databases (most common way, use raw text like json)
 a. Aplication Databases (OLTP - Online transaction processing, Transactions, inserts or changes, row-oriented)
 b. Analytical databases (OLAP - Online analytical processing, optimized for analysis or online analytical processing, column-oriented)

```py
# Function to extract table to a pandas DataFrame
def extract_table_to_pandas(tablename, db_engine):
    query = "SELECT * FROM {}".format(tablename)
    return pd.read_sql(query, db_engine)

# Connect to the database using the connection URI
connection_uri = "postgresql://repl:password@localhost:5432/pagila" 
db_engine = sqlalchemy.create_engine(connection_uri)

# Extract the film table into a pandas DataFrame
extract_table_to_pandas("film", db_engine)

# Extract the customer table into a pandas DataFrame
extract_table_to_pandas("customer", db_engine)
```

3. APIs (using request library in Python)

```py
import requests

# Fetch the Hackernews post
resp = requests.get("https://hacker-news.firebaseio.com/v0/item/16222426.json")

# Print the response parsed as JSON
print(resp.json())

# Assign the score of the test to post_score
post_score = resp.json()["score"]
print(post_score)
```

### Transform

- Selection of attribute
- Translation of code values ("New York" into "NY")
- Data validation /e.g. input in 'created_at')
- Splitting columns in multiple columns (email into username & domain)
- Joining from multiple sources

#### Split
```py

	# Get the rental rate column as a string
rental_rate_str = film_df.rental_rate.astype(str)

	# Split up and expand the column
rental_rate_expanded = rental_rate_str.str.split(".", expand=True)

	# Assign the columns to film_df
film_df = film_df.assign(
    rental_rate_dollar=rental_rate_expanded[0],
    rental_rate_cents=rental_rate_expanded[1],
)
```

#### Prepare and joining
```py
# Get data into Spark framework
## Connection with pyspark
spark.read.jdbc("jdbc:postgresql://localhost:5432/pagila",
                "customer",
                {"user":"repl","password":"password"})

# Join with pyspark
# Use groupBy and mean to aggregate the column
ratings_per_film_df = rating_df.groupby('film_id').mean('rating')

# Join the tables using the film_id column
film_df_with_ratings = film_df.join(
    ratings_per_film_df,
    film_df.film_id==ratings_per_film_df.film_id
)

# Show the 5 first results
print(film_df_with_ratings.show(5))
```

### Load

- Massively parrallel processing databases, there a column-oriented databases optimized for analytics. Some examples are:
	- Amazon Redshift
	- Azure SQL Data Warehouse
	- Google BigQuery
- Load into a PostgreSQL dataabase

The typical workflow is to write the data into columnar data files. These data files are then uploaded to a storage system and from there, they can be copied into the data warehouse. In case of Amazon Redshift, the storage system would be S3, for example.

#### Writing to a file
```py
# Write the pandas DataFrame to parquet
film_pdf.to_parquet("films_pdf.parquet")

# Write the PySpark DataFrame to parquet
film_sdf.write.parquet("films_sdf.parquet")
```
#### Load into PostgreSQL
```py
# Finish the connection URI
connection_uri = "postgresql://repl:password@localhost:5432/dwh"
db_engine_dwh = sqlalchemy.create_engine(connection_uri)

# Transformation step, join with recommendations data
film_pdf_joined = film_pdf.join(recommendations)

# Finish the .to_sql() call to write to store.film
film_pdf_joined.to_sql("film", db_engine_dwh, schema="store", if_exists="replace") #Can be ->  if_exists="append"

# Run the query to fetch the data
pd.read_sql("SELECT film_id, recommended_film_ids FROM store.film", db_engine_dwh)
```
---
### All together

```py
1. def extarct_Table_to_df(tablename, db_engine):
    return pd.read_sql("SELECT * FROM {}".format(tablename), db_engine)
2. def split_columns_transform(df, column, pat, suffixes):
	return rental_rate_str.str.split(".", expand=True)
3. def load_df_into_dbw(film_df, tablename, schema, db_engine):
	return film_pdf_joined.to_sql("film", db_engine_dwh, schema="store", if_exists="replace")

dg_engines = {...} #Need to be configured

def etl():
	#Extract
	film_df = extract_table_to_df("film", db_engine["store"]

	#Tranform
	film_df = split_columns_transform(film_df, "rental_rate", "-", ["_dollar","_cents"]

	#Load
	load_df_into_dwh(film_df, "film", "store", db_engines['dwh']

### Airflow

from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator

dag = DAG(dag_id="etl_pipeline",
          schedule_interval="0 * * * *") #Runs every minute 0

etl_task = PythonOperator(  task_id = "etl_task",
							python_callable = etl, #function created before
							dag=dag)
							
etl_task.set_upstream(wait_for_this_task) #etl_task will run after wait_for_this_task is completed

```
---
## Codes

```py
# Function to apply a function over multiple cores
@print_timing
def parallel_apply(apply_func, groups, nb_cores):
    with Pool(nb_cores) as p:
        results = p.map(apply_func, groups)
    return pd.concat(results)

# Parallel apply using 1 core
parallel_apply(take_mean_age, athlete_events.groupby('Year'), 1)
--------
import dask.dataframe as dd

# Set the number of partitions
athlete_events_dask = dd.from_pandas(athlete_events, npartitions=4)

# Calculate the mean Age per Year
print(athlete_events_dask.groupby('Year').Age.mean().compute())
--------
#PySpark
# Group by the Year, and find the mean Age
print(athlete_events_spark.groupBy('Year').mean('Age').show())
--------
# Airflow DAG

# Create the DAG object

from airflow.models import DAG

dag = DAG(dag_id="car_factory_simulation",
          default_args={"owner": "airflow","start_date": airflow.utils.dates.days_ago(2)},
          schedule_interval="0 * * * *") #Runs every minute 0

* About cron: https://cloud.google.com/scheduler/docs/configuring/cron-job-schedules#:~:text=Cron%20jobs%20are%20scheduled%20at,on%20specific%20days%20and%20months.

# Task definitions
assemble_frame = BashOperator(task_id="assemble_frame", bash_command='echo "Assembling frame"', dag=dag)
place_tires = BashOperator(task_id="place_tires", bash_command='echo "Placing tires"', dag=dag)
assemble_body = BashOperator(task_id="assemble_body", bash_command='echo "Assembling body"', dag=dag)
apply_paint = BashOperator(task_id="apply_paint", bash_command='echo "Applying paint"', dag=dag)

# Complete the downstream flow
assemble_frame.set_downstream(place_tires)
assemble_frame.set_downstream(assemble_body)
assemble_body.set_downstream(apply_paint)

### DAGs

In Airflow, a DAG – or a Directed Acyclic Graph – is a collection of all the tasks you want to run, organized in a way that reflects their relationships and dependencies.

```

---

## Case

### Extract
```py
# Complete the connection URI
connection_uri = "postgresql://repl:password@localhost:5432/datacamp_application" 
db_engine = sqlalchemy.create_engine(connection_uri)

# Get user with id 4387
user1 = pd.read_sql("SELECT * FROM rating WHERE user_id=4387", db_engine)

# Get user with id 18163
user2 = pd.read_sql("SELECT * FROM rating WHERE user_id=18163", db_engine)

# Get user with id 8770
user3 = pd.read_sql("SELECT * FROM rating WHERE user_id=8770", db_engine)

# Use the helper function to compare the 3 users
print_user_comparison(user1, user2, user3)
```

### Transform
```py
# Complete the transformation function
def transform_avg_rating(rating_data):
    # Group by course_id and extract average rating per course
    avg_rating = rating_data.groupby('course_id').rating.mean()
    # Return sorted average ratings per course
    sort_rating = avg_rating.sort_values(ascending=False).reset_index()
    return sort_rating

# Extract the rating data into a DataFrame    
rating_data = extract_rating_data(db_engines)

# Use transform_avg_rating on the extracted data and print results
avg_rating_data = transform_avg_rating(rating_data)
print(avg_rating_data) 

---

course_data = extract_course_data(db_engines)

# Print out the number of missing values per column
print(course_data.isna().sum())

# The transformation should fill in the missing values
def transform_fill_programming_language(course_data):
    imputed = course_data.fillna({"programming_language": "R"})
    return imputed

transformed = transform_fill_programming_language(course_data)

# Print out the number of missing values per column of transformed
print(transformed.isna().sum())

---

# Complete the transformation function
def transform_recommendations(avg_course_ratings, courses_to_recommend):
    # Merge both DataFrames
    merged = courses_to_recommend.merge(avg_course_ratings) 
    # Sort values by rating and group by user_id
    grouped = merged.sort_values("rating", ascending=False).groupby("user_id")
    # Produce the top 3 values and sort by user_id
    recommendations = grouped.head(3).sort_values("user_id").reset_index()
    final_recommendations = recommendations[["user_id", "course_id","rating"]]
    # Return final recommendations
    return final_recommendations

# Use the function with the predefined DataFrame objects
recommendations = transform_recommendations(avg_course_ratings, courses_to_recommend)
```

### Load

```py
connection_uri = "postgresql://repl:password@localhost:5432/dwh"
db_engine = sqlalchemy.create_engine(connection_uri)

def load_to_dwh(recommendations):
    recommendations.to_sql("recommendations", db_engine, if_exists="replace")
	
# Define the DAG so it runs on a daily basis
dag = DAG(dag_id="recommendations",
          schedule_interval="0 0 * * *")

# Make sure `etl()` is called in the operator. Pass the correct kwargs.
task_recommendations = PythonOperator(
    task_id="recommendations_task",
    python_callable=etl,
    op_kwargs={"db_engines": db_engines},
)

```

### Query from the recommendations table (From Data Warehouse)

```py
def recommendations_for_user(user_id, threshold=4.5):
    # Join with the courses table
    query = """
    SELECT title, rating FROM recommendations
    INNER JOIN courses ON courses.course_id = recommendations.course_id
    WHERE user_id=%(user_id)s AND rating>%(threshold)s
    ORDER BY rating DESC
    """
    # Add the threshold parameter
    predictions_df = pd.read_sql(query, db_engine, params = {"user_id": user_id, 
                                                             "threshold": threshold})
    return predictions_df.title.values

# Try the function you created
print(recommendations_for_user(12, 4.65))
```
---