# Numpy

```py
np.array() - Creates an array
arr.reshape(rows,cols) - New shape to the array
np.hstack((a1,a2)) - Combine arrays horizontally
np.vstack((a1,a2)) - Combine arrays vertically
np.concatenate((a1,a2)) - Concatentes arrays (Can use axis = 0/1)
array.sum( axis = 0/1) 
array.min()
array.max()
array.mean()
np.nanmean(x) - Calculates the mean ignoring NaNs
np.isna(x) - Return True or False
df.dropna(how = any/all)
df.fillna(x)
np.around(array,n) - Round the numbers of an array

# Random

np.random.seed() - Set seed
np.random.rand() - Generates a random number between 0 and 1
np.random.randint(min,max-1) - Random intteger


np.logical_and(x,y)
np.logical_or(x,y)

np.linalg.inv() - Return inverse when det != 0
np.linalg.pinv() -Return inverse when det != 0 or pseudo inverse when det = 0

np.sin(x) - Creates the values for y from x

np.linspace(a,b,c) - Creates c numbers from a to b 
```

```py
# Example to get two numbers in one line

n, p = [int(x) for x in input().split()]
```

# Pandas

```py

df.index = [a,b,c,...]
pd.read_csv("...", index_col = 0, parse_dates=["date_col"])

df.head()
df.tail()
df.info() - Shows Column names and Data types
df.describe() - Describe df
df.min()
df.max()
df.mean()
df.quantile([0.25 0.5 0.74 1])
df.median()
df.var()
df.std()
df.mode()
df.sum()

#Cumulatives
df.cumsum() 
df.cummax()
df.cummin()
df.cumprod()

df.drop_duplicates(subset=cols)

df["letters"].isin([x,y])

df[col].sort_values()
df[col].sort_index()

df.groupby("col").mean()
df.groupby("col")["col2"].agg([min, max])

# Same
df.groupby(col1)[col2]
df.pivot_table(values=col2, index=col1, aggfunc = x) - Can add columns = y, fill_value = 0, margins = True (totals)

# Categorical
df["col"].value_counts() - Count ocurrencies (Can use sort, normalize)
df["col"].describe() - Count, unique, top, freq

#Dictionaries
del(dict["x"]) - Delete an item from a dictionary

# DataFrames
df.set_index(col)
df.reset_index(drop = True) - To undo
df.set_index(pd.Index(["2","4","6","8","10"]))
df.loc[[index_1, index_2]]

```

### Summary Statistic
```py
df[col].agg([x,y,z])

```

List - Order matters
Dictionary - When you need a lookup table

## For loop
```py
for key, value in dict.items(): - Dictionary
for val in np.nditer(my_array): - Numpy array}

for lab,row in df.iterrows(): - DataFrame

for lab, row in cars.iterrows(): - DataFrame 
    cars.loc[lab, "COUNTRY"] = str(row["country"]).upper()
#OR
cars["COUNTRY"] = cars["country"].apply(str.upper)

```
---

# Matplotlib

## Introduction

```py
plt.style.use('ggplot') - Change style as R

plt.plot(x,y)

plt.hist(x)
- bins = number_of_bins
- range = (min, max)
- density = True/False (probability)
- alpha = 0-1 // For transparency

plt.boxplot(x)

plt.barplot(x,y)
- bottom = df.x
- yerr = df.error

plt.barh(x,y)
plt.scatter(x, y, c='m')

plt.title('Lab') - Title
plt.xlabel('x') - X Label
plt.ylabel('y') - Y Label
plt.yticks([a,b,c,...]) - Add labels/values to axis
plt.grid(True)

plt.plot(..., label	 = "Leg_1")
plt.legend() - Add legend

Example
plt.legend(["Female","Male"])

plt.text(x_cord,y_cord,text) - Add a text
plt.xlim() - X limit
plt.ylim() - Y limit
plt.show() - Show a plot

plt.savefig("Img.png")

df.plot(kind = 'scatter',x = 'x',y = 'y') - Plot with Pandas
df.plot(kind = "hist"...) - Histogram
df.plot(kind = "bar"...)
df.plot(kind="line", x="x", y="y")
- rot = degrees


plt.plot(x, y, c='b'); - Plot x and y
plt.axvline(x.mean(), c='y') - Vertical line

plt.plot(..., linestyle = "--") #Or next to the color (plt.plot(x, np.cos(x), 'r--'...))
plt.scatter(..., marker='<', color='b') - Change the marker and the color

https://matplotlib.org/stable/api/markers_api.html

```

### Colors

```py
plt.plot(...,color = "Orange")

k for black 
r for red
b for blue
g for green
c for cyan
```

### Linestyles
```py
plt.plot(..., linestyle = 2)

-
--
-.
:
```

### Markers
```py
plt.plot(..., marker = "x")

w
s
o
d
*
h
```

### Style
```py
plt.style.use("x")

fivethirtyeight
ggplot
seabron
default
```


### Create a figure
```py
import matplotlib.pyplot as plt
fig = plt.figure()  #First fig
ax = plt.axes()     #Then axes
plt.savefig('fig.png')
plt.show()
```

### Examples
```py
avocados_2016.isna().sum().plot(kind = "bar")
```
---

## Data visualization with Matplotlib (Datacamp object oriented)

### General
```py
# Base format

fig, ax = plt.subplots()

#fig, ax = plt.subplots(figsize(x,y))
fig.set_size_inches([x,y])

ax.plot(x,y,
				marker = "o"
				linestyle = "--"
				color = "r")
ax.set_xlabel()
ax.set_ylabel()
ax.tick_params("x"/"y", colors="blue")
ax.set_xticklabels(df.index, rotation = 90)
ax.set_title()	
ax.annotate( "text", 
			  xy=(pd.Timestamp("yyyy-mm-dd",  y),
			  xytext = (pd.Timestamp("yyyy-mm-dd",y),
			  arrowprops = {
							  "arrowstyle":"->",
							  "color":"gray"} )
plt.show()		
```

### Stacked Bar plot format
```py
fig, ax = plt.subplots()

ax.bar(df.index, df["gold"], label="Gold")
ax.bar(df.index, df['silver'], bottom = df['gold'], label="Silver")
ax.bar(df.index, df['bronze'], bottom = df['gold'] + df['silver'], label="Bronze")
ax.set_xticklabels(df.index, rotation = 90)
ax.legend()
plt.show()
```

### To add an error bar
```py
ax.bar( "Rowing",
		rowing['Height'].mean(),
		yerr=rowing['Height'].std())
```

### Error bars to plots
```py
ax.errorbar( df['Month'],
			 df['AVG'],
			 yerr=df['std'])
```

### Boxplot
```py
fig, ax = plt.subplots()

ax.boxplot([df["col"],df2["col"]])
ax.set_xticklabels(["lab_1","lab2"])
ax.set_ylabel('ylab')
plt.show()
```

### Histogram
```py
fig, ax = plt.subplots()

ax.hist(	df['col'], 
			label=['lab'], 
			bins = n_bins / bins=[n1,n2,n3,n4],
			histtype="step")
ax.set_xlabel("lab")
ax.set_ylabel("# of observations")
ax.legend()
plt.show()
```

### Scatter plots
```py
fig, ax = plt.subplots()

ax.scatter(	df['var1'],
			df['var2'],
			color = "r",
			label='lab',
			c=df.index)
plt.show()
```

### Small multiples
```py
fig, ax = plt.subplots(a,b, sharey=True, sharex=True)
ax[0,0].plot()
```

### Time-series
```py
pd.read_csv(..., parse_dates=["date"]) / To identify correctly as date
ax.plot(df.index, df["col"])

# Using twin axes

ax2=ax.twinx()
ax2.plot(..., color="r")
ax2.set_ylabel(..., color="r")
```


#### Plot time-series function
```py
def plot_timeseries(axes, x, y, color, xlabel, ylabel):  # axes = ax

  axes.plot(x, y, color=color)
  axes.set_xlabel(xlabel)
  axes.set_ylabel(ylabel, color=color)
  axes.tick_params('y', colors=color)
```

### Examples
```py
fig, ax = plt.subplots()

# Plot the CO2 levels time-series in blue
plot_timeseries(ax, climate_change.index, climate_change["co2"], 'blue', "Time (years)", 'CO2 levels')

# Create an Axes object that shares the x-axis
ax2 = ax.twinx()

# Plot the relative temperature data in red
plot_timeseries(ax2, climate_change.index, climate_change['relative_temp'], 'red', 'Time (years)', "Relative temp (Celsius)")

# Annotate point with relative temperature >1 degree
ax2.annotate(">1 degree", xy=(pd.Timestamp('2015-10-06'), 1) ,xytext=(pd.Timestamp('2008-10-06'), -0.2), arrowprops={'arrowstyle':'->', 'color':'gray'})

plt.show()
```

### Styles 
```py
plt.style.use("default")
- fivethirtyeight
- grayscale (for black and white)
- ggplot
- seabron
- bmh
- seaborn-colorblind
- tableau-colorblind10
- Solarize_Light2
```

### Share visualizations 

```py
fig.set_size_inches([x,y])

fig.savefig('name.png') - Lower quality 
fig.savefig('name.jpg') - Better quality
fig.savefig('name.svg') - Vector graphic, for ilustration softwares

ls - To list the files inside the directory

# Parameters
- quality = x
- dpi = 300 (Dots per inch, 300 is high quality)
```

### Automating figures
```py
fig, ax = plt.subplots()

# Loop over the different sports branches
for sport in sports:
  # Extract the rows only for this sport
  sport_df = summer_2016_medals[summer_2016_medals["Sport"] == sport]
  # Add a bar for the "Weight" mean with std y error bar
  ax.bar( sport, 
          sport_df["Weight"].mean(), 
          yerr=sport_df["Weight"].std())

ax.set_ylabel("Weight")
ax.set_xticklabels(sports, rotation=90)

# Save the figure to file
plt.show()
```

---

# Data Visualization with Seaborn

## General
```py
import seabron as sns
import matplotlib.pyplot as plt

sns.scatterplot(x,y)
sns.show()
```

## Types
```py
sns.scatterplot(x=x,y=y)

sns.countplot(	x = 'Col', data = df)	 #Counts automatically
				
sns.relplot(..., 
				kind= 'scatter'/'line', # Used for relations between 2 quantitative variables, can use lineplot or scatterplot
				col/row = 'var', # Create a sepparte column/row according to this cualtiative varaible
				col_wrap = x,
				col_order = list) #To wrap into x columns
				
sns.catplot(...,
				data = df,
				kind='count'/'bar'/'box'/'point'
				order = order_list,
				ci=None)
			
```
## Parameters
```py
x
y
data #Expects the dataframe
hue #Subgroups
size #Subgroups
style #Subgroups
hue_order =  ['Yes','No'] #Expects the order
palette = hue_colors #Expect a dictionary
col #Subgroups
row #Subgroups
col_wrap
col_order
alpha #To set the transparency {[0-1]
markers = True/False #Set a marker
dashes = True/False
ci #Confidence interval

#Boxplot
sym=???? #To omit the outliers
whis = x/percentiles #To modify the whiskers (instead of 1.5 IQR)

#Pointplot
join = True/False #To show the lines that join different categories
estimator #To change the calculated value insted of mean (like median from numpy)
capsize #To add caps to the confidence intervals
ci
```

## Examples of plots

### Scatterplot
```py
import matplotlib.pyplot as plt
import seaborn as sns

sns.scatterplot(x="absences", y="G3", 
                data=student_data, 
                hue="location",
                hue_order=['Rural', 'Urban'])

plt.show()
```

### Countplot
```py
import matplotlib.pyplot as plt
import seaborn as sns

palette_colors = {'Rural': "green", 'Urban': "blue"}

sns.countplot(x='school', data=student_data, hue='location', palette = palette_colors)
plt.show()
```

### Relplot (Relational plot, 2 quantitative variables)

Allows creating subplots with `col` and `row` parameters

```py
#Scatterplot

sns.relplot(x="G1", 
			y="G3", 
            data=student_data,
            kind="scatter", 
            col="schoolsup",
            col_order=["yes", "no"],
            row="famsup",
            row_order=["yes", "no"])

sns.relplot(x='acceleration',
            y='mpg',
            data=mpg,
            kind='scatter',
            hue='origin',
            style='origin')

----------
#Lineplot

import matplotlib.pyplot as plt
import seaborn as sns

sns.relplot(x="model_year", y="horsepower", 
            data=mpg, kind="line", 
            ci=None, style="origin", 
            hue="origin",
            markers=True,
            dashes=False)

plt.show()
```

### Catplot (Categorical plot, 1 categorical variable)

Allows creating subplots with `col` and `row` parameters

```py
#Countplot

sns.catplot(y="Internet usage", data=survey_data,
            kind="count",
            col='Age Category')

plt.show()

---
#Barplot

category_order = ["<2 hours", 
                  "2 to 5 hours", 
                  "5 to 10 hours", 
                  ">10 hours"]

sns.catplot(x="study_time", y="G3",
            data=student_data,
            kind="bar",
            order=category_order,
            ci=None) #Confidence intervals off

plt.show()
```

### Boxplot (Categorical)
```py
study_time_order = ["<2 hours", "2 to 5 hours", 
                    "5 to 10 hours", ">10 hours"]

sns.catplot(x='study_time',
            y='G3',
            data=student_data,
            kind='box',
            order=study_time_order)
			whis=[5, 95] #Set whiskers to extend to 5th and 95th percentiles
plt.show()
```

### Point plots (Categorical)
```py
sns.catplot(x="famrel", y="absences",
			data=student_data,
            kind="point",
            capsize=0.2,
            join=False)
            
plt.show()
```

## Customizing Plots

### Styles
```py
sns.set_style(...)
	* white
	* dark
	* whitegrid
	* darkgrid
	* ticks
	
sns.set_palette(...)
	* RdBu
	* PRGn
	* RdBu_r
	* PRGn_r
	* Greys
	* Blues
	* Purples
	* PuRd
	* GnBu
	* custom_palette	#With colors or Hex codes
```

### Scale	
```py
sns.set_context()
	* paper	#Default
	* notebook
	* talk
	* poster
```

### Titles and axis
```py
g.fig.suptitle('Title', y=1) #For FacetGrid (subplots)
g.set_title('Title') #For AxesSubplot
g.set(	xlabel='xlab', #For labels
		ylabel='ylab')
plt.xticks(rotation = x) #To rotate x degrees
```

---

# Joining data with pandas

## Join / Merge

#### Parameters
- indicators = True/False - Return Both, only left or only right (tables)

### Inner Join
Matching values in both tables
```py
df1.merge(df2, on = "col") 
df1.merge(df2, on = "col")\.merge(df3, on = "col") - Merge 3 tables or more (adding "\")
# Parameters
suffixes = ("_suf1","_suf2") - Add suffixes to the new columns
on = ["col1","col2"]
```
### Left Join
Return all rows in left table, and just the values in the right table where key columns match
```py
df1.merge(df2, on = "col", how = "left") 
```

### Right Join
Return all rows in right table, and just the values in the left table where key columns match
```py
df1.merge(df2, how = "right", left_on= "id", right_on= "x_id") 
```

### Outer Join
Return all rows in both tables
```py
df1.merge(df2, on = "col", how = "outer", suffixes = ["_s2","_s1"]) 
```

### Self Join
Joining a table to itself
```py
df1.merge(df2, left_on = "sequel", right_on = "id", suffixes = ["_org",_seq"]) // Adding the sequels to the movies
```

### Examples
```py
print(licenses_zip_ward.groupby("alderman").agg({'income':'median'})) - With aggregations

# If merging with indexes, set left/right_index = True

#Use
merge > groupby > aggregations
```

### Semi Join
Returns intersection (similar to inner), but just values from left table
```py
df1.merge(df2, on= "col")
df1[df1["colx"].isin(genres_tracks["colx"])]
```

### Anti Join
Returns the left table, excluding intersection
```py
# Merge employees and top_cust
empl_cust = employees.merge(top_cust, on='srid', 
                                 how='left', indicator=True)

# Select the srid column where _merge is left_only
srid_list = empl_cust.loc[empl_cust['_merge'] == 'left_only', 'srid']

# Get employees not working with top customers
print(employees[employees["srid"].isin(srid_list)])
```
---

## Concatenate

Combining vertically

- df.concat()
- df.append()

#### Parameters
```py
- ignore_index = True/False
- keys = ["a","b","c"]
- sort = True/False - Sort columns in alphabetical order
- join = "inner"/"outer"
```
With merge()

- validate = 
			'one_to_one'
			'one_to_many'
			'many_to_one'
			'many_to_many'

with concat()

- verify_integrity = 
						False - Default
						True - Check if there are duplicate indexes, and raise an error

```py
pd.concat([df1, df2, df3], join = "inner", sort=True, keys = ["a","b","c"] )

df1.append([df2,df3], sort=False)
```

## Other merges for time-series

### pd.merge_ordered()

- pd.merge_ordered(df1,df2)
- Default is "outer"
- Data is ordered
- Good for time-series data

#### Parameters

- fill_method = 
				"ffill" - Forward fill, which fills the missing value with the prevoius one

#### Examples

```py
pd.merge_ordered(gdp,pop, how="inner", on = ["country","date"], fill_method="ffill")

```

### pd.merge_asof()

- Is like an ordered left join. Match on the nearest lower key column and not exact matches.
- "On" columns, must be sorted
- Used mainly for process which dates may not match exactly, or stock values

#### Parameters

- direction = 
				"forward" - Use de nearest greater key
				"backward" - Use de nearest lower key
				"nearest" - Use de nearest key

## .query()

It??s like a WHERE in SQL

- df.query("col >= 10" or type == "adjective" ")
- Can use "and" or "or"

## df.melt()

There exist wide format and long format

```py

df2 = df.melt( id_vars = "year", var_name="month", value_name="unempl_rate")
```

#### Parameters

- id_vars
- value_vars
- var_name
- value_name

##### Example
```py
# unpivot everything besides the year column
ur_tall = ur_wide.melt( id_vars = "year", var_name="month", value_name="unempl_rate")

# Create a date column using the month and year columns of ur_tall
ur_tall['date'] = pd.to_datetime(ur_tall['year'] + '-' + ur_tall['month'])
```
---

# Importing Data in Python

* Flat files can be:
	* .csv	#Comma separated values
	* .txt
	* .tsv	#Tab separated values

## General
```py
! ls			#Show files in working directory
file.readline()	#To show one line
file.closed		#To check if a file is closed

import os
wd = os.getcwd()
os.listdir(wd) #Get working directory

pd.ExcelFile(file)	#To read from an excel file
file.sheet_names)	#To get the names from the sheets
file.parse(index)	#Indexing in file
```
---

## Reading a text file (Flat Files)
```py
filename = 'name.txt'
file=open(filename, mode='r'/ #'r' is for read
					mode='w') #'w' is for write
text=file.read()
file.close()
print(text)

#Also

with open('name.txt', 'r') as file:
	print(file.read())
```

### With NumPy
Tends to break down when using combining columns of srings and floats

```py
data=np.loadtxt(filename, 
				delimiter=',' / '\t'
				skiprows=n,			#To skip n rows
				usecols=[0,2])		#To get only first and third columns
				dtype = str/float	#To specify the type of entries

np.genfromtxt(	'titanic.csv', 		#For mixed data types
				delimiter=',', 
				names=True,		#When there's a header 
				dtype=None)


# recfromcsv is like genfromtxt, but with default: 
*	dtype=None
*	delimiter=','
*	names=True

np.recfromcsv(	'titanic.csv'		
```

### With Pandas
```py
data.values	#To convert a pandas dataframe into a numpy matrix

pd.read_csv( 'file,csv', 
			 nrows=5, 
			 header=None,
			 sep='\t',				#Delimiter
			 comment='#',			#Character ysed for comments
			 na_values='Nothing')	# List of strings recognized as NA/NaN
```
---

## Reading from other type files
- Excel spreadsheets
- MATLAB files	(Matrix Laboratory)
- SAS files		(Statistical Analysis System)
- Stata files 	("Statistics" + "data")
- HDF5 files	(Hierarchical Data Format V5)	
* Pickled files (File type native to Python))

### Pickled files
```py
# Import pickle package
import pickle

# Open pickle file and load data: d
with open('data.pkl', 'rb') as file:
    d = pickle.load(file)

print(d)

print(type(d))
```

### Excel files (.xlsx)
```py
# Import pandas
import pandas as pd

# Assign spreadsheet filename: file
file = 'battledeath.xlsx'

# Load spreadsheet: xls
xls = pd.ExcelFile(file)

# Print sheet names
print(xls.sheet_names)
xls.parse(	'2004'/0			#Sheet name / index (sheet number)
			skiprows = [n],		#Skip n rows
			usecols=[p], 		#Select columns
			names = [a,b]) 		#Name the columns
```

### SAS/Stata files
- SAS: Statistical Analysis System	(Business analytics)
```py
import pandas as pd
from sas7bdat import SAS7BDAT
with SAS7BDAT('file.sas7bdat') ad file:
	df_sas = file.to_data_frame()
```

- Stata: "Statistics" + "data"		(Academic research)
```py
import pandas as pd
data=pd.read_stata('file.dta')
```

### HDF5 files (.hdf5)
```py
import h5py
filename = 'file.hdf5')
data=h5py.File(filename, 'r') #'r' is to read

for key in data.keys():
	print(key)

#meta
#quality
#strain

for key in data['meta'].keys():
	print(key)
```

### MATLAB files (.mat)

Use the method .keys() on the dictionary mat to print the keys. Most of these keys (in fact the ones that do NOT begin and end with '__') are variables from the corresponding MATLAB environment.
```py
import scipy.io
filename='file.mat')
mat=scipcy.io.loadmat(filename)

* scipy.io.loadmat()
* scipy.io.savemat()

mat.keys()
```
---

## Relational databases

### Creating a database engine
```py
from sqlalchemy import create_engine
engine = create_engine('sqlite:///Northwind.sqlite')

print(engine.table_names())	#To get the name of the available tables
```

### Querying in Python

1. Import packages and functions
2. Create the database engine
3. Connect to the engine
4. Query the database
5. Save query results to a DataFrame
6. Close the connection

```py
from sqlalchemy import create_engine
import pandas as pd

engine = create_engine('sqlite:///Northwind.sqlite')
con = engine.connect()
rs = con.execute('SELECT * FROM Orders')
df = pd.DataFrame(rs.fetchall())
df.columns = rs.keys()
con.close()

print(df.head())

#Or

with engine.connect() as con:
	rs=con.execute('SELECT * FROM Orders')
	df = pd.DataFrame(rs.fetchall()) #rs.fetchmany(size=5)
	df.columns = rs.keys()
```

### Querying directly with Pandas
```py
df = pd.read_sql_query('SELECT * FROM Orders", engine)
```
---

## Importing data from internet

### Flat files from internet 
```py
from urllib.request import urlretrieve

url = 'https://assets.datacamp.com/production/course_1606/datasets/winequality-red.csv'
urlretrieve(url, 'winequality-red.csv')
df = pd.read_csv('winequality-red.csv', sep=';')

#Or usaing pandas, can be
df = pd.read_csv(url, sep=',')
```
### Excel files from the web
```py
import pandas as pd

url = 'https://assets.datacamp.com/course/importing_data_into_r/latitude.xls'
xls=pd.read_excel(url,sheet_name = None)
print(xls.keys())

print(xls['1700'].head())
```

### HTTP requests from the web
```py
from urllib.request import urlopen, Request

url = '...'
request = Request(url)
response = urlopen(request)
html = response.read()
response.close()
```

### Using requests
```py
import requests 
url = '...'
r = requests.get(url)
text = r.text
```

### BeautifulSoup
```py
from bs4 import BeautifulSoup
import requests 
url = '...'
r = requests.get(url)
html_doc = r.text
soup = BeautifulSoup(html_doc)

print(soup.prettify()) # Is indented in the way you would expect written HTML to be

print(soup.title)		#title attribute to get the title
print(soup.get_text())	#get_text() method to get the text

---

#To get the hyperlinks

# Find all 'a' tags (which define hyperlinks): a_tags
a_tags = soup.find_all('a')

# Print the URLs to the shell
for link in a_tags:
    print(link.get('href'))
	
# Or

for link in soup.find_all('a'):
	print(link.get('href')
```
---

## APIs to import data from the web

An API is a set of protocols and routines for building and interacting with software applications.

### Introduction to JSON
Stands for JavaScript Object Notation

```py
import json

with open('snakes.json', 'r') as json_file:
	json_data = json.load(json_file)
type(json_data) #Is a dictionary

#EXPLORING
	
for key, value in json_data.items():
	print(key + ':', value)
	
for k in json_data.keys():
    print(k + ': ', json_data[k])
```

### Connecting an API in Python
```py
import requests
url = '...'
r = requests.get(url)
json_data = r.json()

for key, value in json_data.items():
	print(key + ':', value)
```

### Examples
```py
# Import requests package
import requests

# Assign URL to variable: url
url = 'http://www.omdbapi.com/?apikey=72bc447a&t=the+social+network'

# Package the request, send the request and catch the response: r
r = requests.get(url)

# Print the text of the response
print(r.text)


---


# Import package
import requests

# Assign URL to variable: url
url = 'http://www.omdbapi.com/?apikey=72bc447a&t=social+network'

# Package the request, send the request and catch the response: r
r = requests.get(url)

# Decode the JSON data into a dictionary: json_data
json_data = r.json()

# Print each key-value pair in json_data
for k in json_data.keys():
    print(k + ': ', json_data[k])
	
	
---


#Wikipedia API

# Import package
import requests

# Assign URL to variable: url
url = 'https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=pizza'

# Package the request, send the request and catch the response: r
r = requests.get(url)

# Decode the JSON data into a dictionary: json_data
json_data = r.json()

# Print the Wikipedia page extract
pizza_extract = json_data['query']['pages']['24768']['extract']
print(pizza_extract)
```

### Twitter API
```py
import tweempy, json
access_token = '...'
access_token_secret = '...'
consumer_key = '...'
consumer_secret = '...'

#Create streaming object
stream = tweepy.Stream(consumer_key, consumer_secret, access_token, access_token_secret)

#Filter Twitter Streams to capture data by keywords
stream.filter(track=['apples', 'oranges']


#Twitter data

# Import package
import json

# String of path to file: tweets_data_path
tweets_data_path = 'tweets.txt'

# Initialize empty list to store tweets: tweets_data
tweets_data = []

# Open connection to file
tweets_file = open(tweets_data_path, "r")

# Read in tweets and store in list: tweets_data
for line in tweets_file:
    tweet = json.loads(line)
    tweets_data.append(tweet)

# Close connection to file
tweets_file.close()

# Print the keys of the first tweet dict
print(tweets_data[0].keys())

---

#Get a df from dictionaries

# Import package
import pandas as pd

# Build DataFrame of tweet texts and languages
df = pd.DataFrame(tweets_data, columns=['text', 'lang'])

# Print head of DataFrame
print(df.head())
```
---

## Excercises
```py
# Import sas7bdat package
from sas7bdat import SAS7BDAT

# Save file to a DataFrame: df_sas
with SAS7BDAT('sales.sas7bdat') as file:
    df_sas=file.to_data_frame()

# Print head of DataFrame
print(df_sas.head())

# Plot histogram of DataFrame features (pandas and pyplot already imported)
pd.DataFrame.hist(df_sas[['P']])
plt.ylabel('count')
plt.show()
---

# Get the HDF5 group: group
group = data['strain']

# Check out keys of group
for key in group.keys():
    print(key)

# Set variable equal to time series data: strain
strain = np.array(data['strain']['Strain'])

# Set number of time points to sample: num_samples
num_samples=10000

# Set time vector
time = np.arange(0, 1, 1/num_samples)

# Plot data
plt.plot(time, strain[:num_samples])
plt.xlabel('GPS Time (s)')
plt.ylabel('strain')
plt.show()
---

# Print the keys of the MATLAB dictionary
print(mat.keys())

# Print the type of the value corresponding to the key 'CYratioCyt'
print(type(mat['CYratioCyt']))

# Print the shape of the value corresponding to the key 'CYratioCyt'
print(np.shape(mat['CYratioCyt']))

# Subset the array and plot it
data = mat['CYratioCyt'][25, 5:]
fig = plt.figure()
plt.plot(data)
plt.xlabel('time (min.)')
plt.ylabel('normalized fluorescence (measure of expression)')
plt.show()
---

# Import packages
import requests
from bs4 import BeautifulSoup

# Specify url: url
url = 'https://www.python.org/~guido/'

# Package the request, send the request and catch the response: r
r = requests.get(url)

# Extract the response as html: html_doc
html_doc = r.text

# Create a BeautifulSoup object from the HTML: soup
soup = BeautifulSoup(html_doc)

# Get the title of Guido's webpage: guido_title
guido_title = soup.tittle

# Print the title of Guido's webpage to the shell
print(guido_title)

# Get Guido's text: guido_text
guido_text = soup.get_text()

# Print Guido's text to the shell
print(guido_text)


---


# re, re.search, iterrows()

import re

def word_in_text(word, text):
    word = word.lower()
    text = text.lower()
    match = re.search(word, text)

    if match:
        return True
    return False
	
# Initialize list to store tweet counts
[clinton, trump, sanders, cruz] = [0, 0, 0, 0]

# Iterate through df, counting the number of tweets in which
# each candidate is mentioned
for index, row in df.iterrows():
    clinton += word_in_text('clinton', row['text'])
    trump += word_in_text('trump', row['text'])
    sanders += word_in_text('sanders', row['text'])
    cruz += word_in_text('cruz', row['text'])

# Import packages
import seaborn as sns
import matplotlib.pyplot as plt


# Set seaborn style
sns.set(color_codes=True)

# Create a list of labels:cd
cd = ['clinton', 'trump', 'sanders', 'cruz']

# Plot the bar chart
ax = sns.barplot(cd, [clinton, trump, sanders, cruz])
ax.set(ylabel="count")
plt.show()
```
---

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
					inplace = True)	#Drop duplicated rows directly inside DataFrame without creating new object
										
#How to treat duplicate values?

column_names = ['first_name', 'last_name', 'address']
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
inconsistent_categories = set(study_data['blood_type').difference(categories['blood_type']) #It??s like Anti Join
inconsistent_rows = study_data['blood_type'].isin(inconsistent_categories) #Returns a boolean Series
inconsistent_data = study_data[inconsistent_rows]
consistent_data = study_data[~inconsistent_rows] #ALT+126

# VALUE CONSISTENCY
df['col'].str.upper()
df['col'].str.lower()
df['col'].str.split()
df['col'].str.contains()
df['col'].str.replace()
df['col'].str.startswith()
df['col'].str.strip() #To delete characters
```

### Data into categories
```py
#qcut
pd.qcut(df['col'], q=3, labels = names_list) #Divides automtically into the number of 'q' argument

#cut
ranges=[0,200000,500000,np.inf)
names=[0-200K', '200K-500K', '500K+']]
pd.cut(df['col'], bins=ranges, labels=names)
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

### Uniformity
```py
col2 = df['col1']
colx = col2 * function
df.loc['col1'] = colx

pd.to_datetime(	df['col'],
				infer_datetime_format = True	#Attempt to infer format of each date
				errors = 'coerce') # Return NA for rows there conversion failed

#Or it can be used
col.dt.strftime('%d-%m-%Y') - For converting format, or can be used for Y,m or d extraction
```

### Cross field validation
```py
col = pd.to_datetime(col2)
today = dt.date.today()

age = today.year - col.dt.year
```

### Completeness
```py
import missingno as msno

msno.matrix(airquality)
plt.show()

missing = df[col.isna()]
complete = df[~col.isna()]
```

## Record linkage

### Comparing strings
```py
from fuzzywuzzy import fuzz

fuzz.WRatio('Reeding', Reading') #Comparison score

#Or can be done with mutiple strings
string = a
choices = [b,c,d]
process.extract(string,choices, limit=df.shape[0])
```

### Generating DataFrames
```py
import recordlinkage

indexer = recordlinkage.Index()
indexer.block('state')
pairs = indexer.index(df_a,df_b)

compare_cl = recordlinkage.Compare()

compare_cl.exact(??state??, 'state', label = 'state')
compare_cl.string('surname', 'surname', threshold=0.85, label='surname')

potential_matches = compare_cl.compute(pairs, df_a, df_b)

potential_matches[potential_matches.sum(axis=1) => 2]
```

### Linking DataFrames
```py
duplicate_rows = matches.index.get_level_values(1)
df_b_duplicates = df_b[df_b.index.isin(duplicate_rows)]

df_b_dup = df_b[df_b.index.isin(duplicate_rows)]
df_b_new = df_b[~df_b.index.isin(duplicate_rows)]

full_df = df_b.append(df_b_new)
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
---


ADVANCED DATA PROBLEMS

# Find values of acct_cur that are equal to 'euro'
acct_eu = banking['acct_cur'] == 'euro'

# Convert acct_amount where it is in euro to dollars
banking.loc[acct_eu, 'acct_amount'] = banking.loc[acct_eu, 'acct_amount'] * 1.1

# Unify acct_cur column by changing 'euro' values to 'dollar'
banking.loc[acct_eu, 'acct_cur'] = 'dollar'

# Assert that only dollar currency remains
assert banking['acct_cur'].unique() == 'dollar'


# Print the header of account_opend
print(banking['account_opened'].head())

# Convert account_opened to datetime
banking['account_opened'] = pd.to_datetime(banking['account_opened'],
                                           # Infer datetime format
                                           infer_datetime_format = True,
                                           # Return missing value for error
                                           errors = 'coerce') 

# Get year of account opened
banking['acct_year'] = banking['account_opened'].dt.strftime('%Y')

# Print acct_year
print(banking['acct_year'])

# Store fund columns to sum against
fund_columns = ['fund_A', 'fund_B', 'fund_C', 'fund_D']

# Find rows where fund_columns row sum == inv_amount
inv_equ = banking[fund_columns].sum(axis=1) == banking['inv_amount']

# Store consistent and inconsistent data
consistent_inv = banking[inv_equ]
inconsistent_inv = banking[~inv_equ]

# Store consistent and inconsistent data
print("Number of inconsistent investments: ", inconsistent_inv.shape[0])


# Print number of missing values in banking
print(banking.isna().sum())

# Visualize missingness matrix
msno.matrix(banking)
plt.show()

# Isolate missing and non missing values of inv_amount
missing_investors = banking[banking['inv_amount'].isna()]
investors = banking[~banking['inv_amount'].isna()]

# Print number of missing values in banking
print(banking.isna().sum())

# Visualize missingness matrix
msno.matrix(banking)
plt.show()

# Isolate missing and non missing values of inv_amount
missing_investors = banking[banking['inv_amount'].isna()]
investors = banking[~banking['inv_amount'].isna()]

# Sort banking by age and visualize
banking_sorted = banking.sort_values('age')
msno.matrix(banking_sorted)
plt.show()

---

# Import process from fuzzywuzzy
from fuzzywuzzy import fuzz, process

# Store the unique values of cuisine_type in unique_types
unique_types = restaurants['cuisine_type'].unique()

# Calculate similarity of 'asian' to all values of unique_types
print(process.extract('asian', unique_types, limit = len(unique_types)))
```


















---

# Machine Learning
```py
df.corr().round(x) - Creates a correlation matrix

model.intercept_ - To get the intercept_
model.coef_ - To get the coefficient/slope
model.score() - R-squared
```
## Linear Regressi??n

To evalutae you cane either use:
- MSE
- R-squared

Compare different models

## Classification

KN Neighbors Classifier
- https://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html

## Clustering 

### Clustering methods
- https://scikit-learn.org/stable/modules/clustering.html#overview-of-clustering-methods

### Pre-processing
- https://scikit-learn.org/stable/auto_examples/preprocessing/plot_scaling_importance.html


## Other

```py
is_recession = ['r' if s=='recession' else 'g' for s in gdp_recession['econ_status']] - List with expressions
```

---

### Full Data Analyst Track in DataCamp

1. Introduction to SQL
2. Streamlined Data Ingestion with pandas
3. Introduction to Relational Databases in SQL
4. Joining Data in SQL
5. Introduction to Databases in Python




