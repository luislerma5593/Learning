# Introduction to Importing Data in Python

* Flat files can be:
	* .csv	#Comma separated values
	* .txt
	* .tsv	#Tab separated values

## General
```py
! ls			#Show files in working directory
file.readline()	#To show one line
file.closed		#To check if a file is closed
```
---
## Reading a text file
```py
filename = 'name.txt'
file=open(filename, mode='r'/ #'r' is for read
					mode='w') #'w' is for write
text=file.read()
file.close()
print(text)

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

```py

```



















