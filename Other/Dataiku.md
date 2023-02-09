
# Dataiku - Data Scientist Quick Start

## Read recipe inputs

customers_web_joined = dataiku.Dataset("customers_web_joined")
df = customers_web_joined.get_dataframe()

#Import from Project variables
var = int(dataiku.get_custom_variables()["revenue_value"])

## Scenarios

### Automated Python Example

	import dataiku
	from dataiku.scenario import Scenario

	#The Scenario object is the main handle from which you initiate steps
	scenario = Scenario()

	#Building a dataset
	scenario.build_dataset("customers_revenue",build_mode='NON_RECURSIVE_FORCED_BUILD')
	scenario.build_dataset("train")

	#Controlling the train of a dataset
	model_id = "GtTMqkLX" # target deployment model to challenge

	#Define function that gets active model id and version
	def get_active_model_auc():
		saved_model = dataiku.Model(model_id)
		for model in saved_model.list_versions():
			if model['active']:
				model_score = model['snippet']['auc']
				version_id = model['versionId']
		return version_id, model_score

	#get active model id and version
	past_version_id, past_model_score = get_active_model_auc()

	#retrain model (this will activate it by default)
	scenario.train_model(model_id)

	#get newly activated model id and version
	new_version_id, new_model_score = get_active_model_auc()

	if new_model_score <= past_model_score:
	   #reactivate previous version of the model if the new model performance isn't better
	   dataiku.Model(model_id).activate_version(past_version_id)
		
	#Building datasets
	scenario.build_dataset("scored")
	scenario.build_dataset("metrics")
	scenario.build_dataset("Predictions")

---

** Tips **

# Get the column names
numerical_columns = list(df.select_dtypes(include=[np.number]).columns)
categorical_columns = list(df.select_dtypes(include=[object]).columns)
date_columns = list(df.select_dtypes(include=['<M8[ns]']).columns)
