# MLOps

## Introduction to MLOps

Design, deploy and maintain ML in production continuously, reliably and efficiently. It’s the lifecycle containing: Design > Development > Deployment.

It comes from DevOps:

DEV: Plan, create, verify, package
OPS: Release, configure, monitor

### Phases in MLOps

Design > Development > Deployment

* It's common to go back and forth
* Evaluate each phase with stakeholders

1. Design
	* Added value
	* Business requirements
	* Key metrics
	* Data processing

2 Development
	* Feature Engineering
	* Experminet tracking
	* Model training & evaluation
		
3 Deployment
	* Runtime environments
	* Microservices architecture
	* CI/CD pipeline
	* Monitoring & retraining

### Roles in MLOps

1 Business roles
	* Business stakeholder (Problem definition and requirements, model evaluation, monitoring)
	* Subject matter expert (EDA, Feature Engineering, validate data , monotoring)
	
2 Techincal roles
	* Data Engineer (Collecting, stroing and processing data. Check and maintain quality)
	* Data Scientist (Data analysis, model training and evaluation. Mostly during Development)
	* Software Engineer (Mostly in Deployment, Design, wirte software for deployment and follow guidelines)
	* ML Engineer (Expertise over the entiner ML lifecycle, involved in all phases)
	* Backend Engineer (Setting up the cloud infrastructure to enable developmentand deployment of ML models. DBs and PCs)

---

## Design and Development

### Design

Starts with determining the added value of building and running the ML model (expresed in terms of money and time).

* Business requirements
	- End User (Speed, accuracy, transparency)
	- Compliance and regulations)
	- Budget
	- Team size
	
* Key metrics
	- Accuracy ( Tada scientist)
	- Customer hapiness (Subject expert)
	- Generated value (Business stakeholder)

### Data quality and ingestion

* The core of a ML model
* Improve quality to improve performance

Data quality can be defined by the following dimensions:
- Accuracy (Representation of reality, Wrong information for one or more registers)
- Completness (Thorough description, no last name for all records)
- Consistency (Simple definitions, missmatching in different databases)
- Timeliness (Availability of data, real time information)

Data ingestion:
- ETL or ELT

### Feature Engineering

Selecting, manipulating and transofrming raw data into features.

More features:
* Produce a very accurate model
* Achieve more stability
* Be more expensive due to additional pre-processing steps
* Require more maintenance
* Lead to noise or over-engineering

 The **feature store** is a tool through which features can be managed and easily accessed by multiple people working of different projects.


### Experiment tracking

Factores to configure:
* ML models
* Model hyperparameters
* Versions of data
* Execution scripts
* Environment configuration

How to track experiments?
* Spreadsheet (easy but a lot of manual work)
* Propietary platform (Specific use but requires time and effort)
* Experiment tracking tool (Specially designed but expensive)

The experiment process:

1. Formulate a hypothesis
2. Gather images and labels
3. Define experiment (types of models, hyperparameters and datasets)
4. Setup experiment tracking
5. Train the ML model
6. Test models on a hold-out test set
7. Register the most suitable model
8. Visualize and report back to the teams and stakeholders, and determine next steps





















---
## Deploying ML into Production

---
## Maintaining ML in Production
