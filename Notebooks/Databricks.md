
# Databricks

* https://www.databricks.com/glossary/data-lakehouse

## Introduction to Databricks

### Introduction to platform

#### Data Warehouse

Pros
* Great for structured data
* High performance
* Easy to keep data clean

Cons
* Expensive
* Cannot support modern apps
* Not built for ML

#### Data Lake

Pros
* Support for all use cases
* Flexile
* Cost effective

Cons
* Data can become messy
* Not very performant

Now, for datalakehouses, there is a combination between Data Warehouses (BI and Analyics) and Data Lakes (ML)

#### Databricks architecture benefits

* Every use case from AI to BI
* Benefits of data warehous and data lake
* Multi-cloud 
* Collaborative
* Open-source (by Apache Spark)
* Supports R, Python and SQL


### Core features

* Based on Spark and support many data sources

#### Databricks compute

Clusters
* Collection of VMs (computational resources)
* All workloads, any use case
* All-purpose vs jobs

SQL Wahrehouses
* SQL only
* BI use cases
* Photon

#### Cloud data storage

* Could be on servers or file formats

In databricks, it's used DELTA LAKE, which is an open-source sotrage format (around Parquet):
* ACID transactions
* Unified batch and streaming
* Table history
* Schema evolution

**Unity catalog**, is the data governance strategy co control access to data assets in Databricks platform.


### Administration of workspace

Account admin
* Creating and managing workspaces
* Enable unity catalog
* Managing accounts
* Account console, access to:
	* Workspaces
	* Data
	* Users and groups
	* Settings

Workspace admin
* Managing own workspace

There are:

* Databricks Cloud environment: Manage accouts, datasets and clusters
	* User interactions with the Databricks platform exist within the Control Plane, and is responsible for tasks such as launching clusters and initiating jobs.

* Customer Cloud environment: Data processing, data storage
	* The Data Plane is where customers store their data in the data lake, ensuring better data security.
	
---

## Data Engineering

Auto Loader
* Use Auto Loader to automatically ingest new data files as they come in. 
* Identify which tables are new and which were already loaded.
* It will enable your data engineer to only load the new data files when they come in, and the files are never reloaded.

Streaming
1. Gather information about a topic
2. Read data into Structured Streaming DataFrame
3. Clean the streaming data
4. Join datasets into the stream
5. Write the streams as a Delta table in a new data lake bucket

Databricks worflows
* Collection of built-in capabilities to orchestrate data processes.
* Can be with UI or programatically
* The benefits of developing piplelines with Delta Live Tables:
	* Combined process for batch and streaming datasets
	* Maintain better data quality with set expectations

--

## Databricks SQL and Data Warehousing

Databricks SQL
* Open file format (Delta)
* Separation of compute and storage
* ANSI SQL

Data quality
* Bronze: Raw integration
* Silver: Filtered, cleaned, augmented
* Gold: Business-level Aggregates

Type
* Classic: Basic SQL
* Pro: More advanced features
* Serverless: Cutting edge features, Databricks cloud, most cost performant

 Dashboard
 * Charts, text, etc.
 * Lightweight
 
--

## Databricks for Applications and ML


### Planning and preparation

EDA
* It has built-in visualizations and EDA tools
* Bamboo lib

ML Runtime
* Optimized for ML applications
* Contains most common libraries

Feature store
* Storage for featurized datasets
* Easily discover features for ML models

### Model training with MLFlow

MLflow simplifies the process of managing machine learning workflows, from experimentation to deployment, and promotes collaboration and reproducibility in machine learning projects.

Mainly for Model Engineering and Model Evaluation

Single-node ML
* Great for experimenting
* Easier setup
* Hard to implement in production
* Like Scikit learn

Multi-node ML
* Great for production workloads
* Easier maintenance long-term
* Highly scalable
* Like Apache Spark

There is **Auto ML**, a "Glass box" approach to auomated ML

MLFlow
* Open-source framework
* End-to-end ML lifecycle
* Track, evaluate, manage and deploy
* Can have multiple runs, and compare them to find the best model.

### Deploying a model

In MLOps, used for:
* Model Deployment
* Operations
* Monitor & Evaluate


### Wrap-Up

1. Databricks for Data Engineering
* Apache Spark
* Delta
* Delta Live Tables
* Auto Loader
* Structured Streaming
* Workflows


2. Databricks for data warehousing
* SparkSQL
* ANSI SQL
* SQL Warehouses
* Queries
* Visualizations
* Dashboards

3. Databricks for ML
* ML Flow