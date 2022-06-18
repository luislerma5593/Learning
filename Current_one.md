# Cleaning Data in Python

When working with new data, it's always recommended to check the data types using:
* .dtypes
* .info()
* .describe()

For cleaning:
* Remove characters
* Change data type
* Remove duplicates
* Remove non existing categories
* Value consistency (All in upper or lower)
* Creating new categories
* Remapping existing categories
* Clean text data


## Common data problems
```py
df['col'].str.strip('$') - To remove a character/string from a string
df['col'].astype('int') - For integers
df['col'].astype('category') - For categorical data

movies.drop(movies[movies['avg_rating'] > 5].index, inplace = True)	#Delete registers
movies.loc[movies['avg_rating'] > 5, 'avg_rating'] = 5

pd.to_datetime(user_signups['subscription_date']).dt.date #To convert into a date type
today_date = dt.date.today()

df.duplicated() - To check if there's a duplicated register. Return a True/False list

df.duplicated(	subset = column_list, 
				keep = 	'first', #Keep first duplicated
						'last',	 #Keep last duplicated
						False)	 #Keep all duplicated
						
df.drop_duplicates(	subset = column_list,
					keep = 	'first', #Keep first duplicated
							'last',	 #Keep last duplicated
							False	 #Keep all duplicated
					inplace = True)	#Drop duplicated rows directly inside DataFra,e without creating new object
										
#How to treat duplicate values?

column_names = ['first_name', 'last_name', 'address'[
summaries = {'height':'max', 'weight':'mean}
height_weight = height_weight.groupby(by=column_names).agg(summaries).reset_index()
```

When there are complete and incomplete duplicates:

1. Remove complete duplicates
2. Create a new df, grouping by desired column, and aggregate the different values for the incomplete duplicate rows
```py
# Drop complete duplicates from ride_sharing
ride_dup = ride_sharing.drop_duplicates()

# Create statistics dictionary for aggregation function
statistics = {'user_birth_year': 'min', 'duration': 'mean'}

# Group by ride_id and compute new statistics
ride_unique = ride_dup.groupby('ride_id').agg(statistics).reset_index()

# Find duplicated values again
duplicates = ride_unique.duplicated(subset = 'ride_id', keep = False)
duplicated_rides = ride_unique[duplicates == True]

# Assert duplicates are processed
assert duplicated_rides.shape[0] == 0
```

## Text and categorical data problems
```py
inconsistent_categories = set(study_data['blood_type').difference(categories['blood_type']) #It´s like Anti Join
inconsistent_rows = study_data['blood_type'].isin(inconsistent_categories) #Returns a boolean Series
inconsistent_data = study_data[inconsistent_rows]
consistent_data = study_data[~inconsistent_rows] #ALT+126

# VALUE CONSISTENCY
df['col'].str.upper()
df['col'].str.lower()
df['col'].str.strip() #For spaces
```

### Data into categories
```py
#qcut
pd.qcut(df['col'], q=3, labels = names_list) #Divides automtically into the number of 'q' argument

#cut
ranges=[0,200000,500000,np.inf)
names=[0-200K', '200K-500K', '500K+']]
pd.cut(df['col'], bins=ranghes, labels=names)
```

### Remapping categories

To Reduce amount of categories
```py
mapping_dict
df['col'] = df['col'].replace(mapping_dict)
```

### Cleaning text data
```py
df['col'].str.replace('a','b')
df['col'].str.replace('-','')

digits = phones['number'].str.len()
phones.loc[digits <10, 'number'] = np.nan
```

## Advanced Data Problems
```py

```

```py

```

```py

```

```py

```

```py

```

```py

```

```py

```

```py

```

```py

```

## Examples 
```py
# CONVERT INTO INT, THEN MODIFY DF AND CONVERTO AGAIN INTO CATEGORY|
# Convert tire_sizes to integer
ride_sharing['tire_sizes'] = ride_sharing['tire_sizes'].astype('int')

# Set all values above 27 to 27
ride_sharing.loc[ride_sharing['tire_sizes'] > 27, 'tire_sizes'] = 27

# Reconvert tire_sizes back to categorical
ride_sharing['tire_sizes'] = ride_sharing['tire_sizes'].astype('category')

# Print tire size description
print(ride_sharing['tire_sizes'].describe())

---

CONVERT FUTURES DATES INTO TODAY'S DATE

# Convert ride_date to date
ride_sharing['ride_dt'] = pd.to_datetime(ride_sharing['ride_date']).dt.date

# Save today's date
today = dt.date.today()

# Set all in the future to today's date
ride_sharing.loc[ride_sharing['ride_dt'] > today, 'ride_dt'] = today

# Print maximum of ride_dt column
print(ride_sharing['ride_dt'].max())

---

TEXT AND CATEGORICAL DATA PROBLEMS

# Print unique values of both columns
print(airlines['dest_region'].unique())
print(airlines['dest_size'].unique())

# Lower dest_region column and then replace "eur" with "europe"
airlines['dest_region'] = airlines['dest_region'].str.lower() 
airlines['dest_region'] = airlines['dest_region'].replace({'eur':'europe'})

# Remove white spaces from `dest_size`
airlines['dest_size'] = airlines['dest_size'].str.strip()

# Verify changes have been effected
print(airlines['dest_region'].unique())
print(airlines['dest_size'].unique())

# Create ranges for categories
label_ranges = [0, 60, 180, np.inf]
label_names = ['short', 'medium', 'long']

# Create wait_type column
airlines['wait_type'] = pd.cut(airlines['wait_min'], bins = label_ranges, 
                                labels = label_names)

# Create mappings and replace
mappings = {'Monday':'weekday', 'Tuesday':'weekday', 'Wednesday': 'weekday', 
            'Thursday': 'weekday', 'Friday': 'weekday', 
            'Saturday': 'weekend', 'Sunday': 'weekend'}

airlines['day_week'] = airlines['day'].replace(mappings)


# Replace "Dr." with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Dr.","")

# Replace "Mr." with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Mr.","")

# Replace "Miss" with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Miss","")

# Replace "Ms." with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Ms.","")

# Assert that full_name has no honorifics
assert airlines['full_name'].str.contains('Ms.|Mr.|Miss|Dr.').any() == False


# Store length of each row in survey_response column
resp_length = airlines['survey_response'].str.len()

# Find rows in airlines where resp_length > 40
airlines_survey = airlines.loc[resp_length > 40]

# Assert minimum survey_response length is > 40
assert airlines_survey['survey_response'].str.len().min() > 40

# Print new survey_response column
print(airlines_survey['survey_response'])
```











