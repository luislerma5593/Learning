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



















