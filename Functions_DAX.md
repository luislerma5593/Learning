# DAX Functions

- Know your audience
- Evoke an emotional response
- Less is more
- Reduce cognitive load
- Tracking focal points
- Accesibility
- Ready for production
- Paginated reports
- Add all the measures in one single table like _MEASURES (To see it on top of the list)
- It's possible to create subfolders inside a MMeasures table

It´s possible to use measures in measures, for example:

VAR
	EXP
RETURN

Sales = [Sales] - VAR


---

## DAX
```sql
CALCULATE(Aggregation, filter_1, filter_2, ...) 
FILTER(table, filter)
CROSSFILTER(col1, col2, direction)
COUNT(col) - Count rows with numbers, dates, strings in a column
COUNTA(col) - Count rows with numbers, dates, strings, or bools in a column
COUNTBLANK() - in a column
DISTINCT() - Get unique rows
DISTINCTCOUNT() - in a column
COUNTROWS([x]) - Count the rows in a table
SUMX (table, expresion) - Iterate over each row of a given table to performm an expression
RANKX(column, expression) - Ranks from 1 to n
SUBSTITUTE(column,Old_text,New_text) - Substitute a string
RELATED(Table[Column]) - Add a column from another table
SELECTCOLUMNS(Col1,Col2,...) - Select columns function
MOD(Number, Divisor) - Returns the remainder after a number is divided by a divisor
USERELATIONSHIP(Col1,Col2) - Specify an existing relation (Not active)
ALL(table) - Use to avoid filters

SWITCH(Expresion, Value, Result, [Value, Result], ..., Else) 
HASONEVALUE(Col) - Returns True or False

# TABLES

ADDCOLUMNS(table, "Profit", R - C) - Returns the input table appended with columns from other table
SUMMARIZE(table, groupby_colname, name, expresion)


# DATES

CALENDAR() - Return all dates in a range
DATE(yyyy,mm,dd) - Creates a date
SAMEPERIODLASTYEAR(Date)
DATEADD(Dates,NumberOfIntervls,Interval) - DATEADD(Date,-1,YEAR) Like same period last year
NEXTDAY(Date) 
DATESBETWEEN(dates_col,start_date,end_date)

# TIME INTELLIGENCE

TOTALYTD(exp, dates) - Returns the year to date value of the expression
TOTALQTD(exp, dates) - Returns the quarter to date value of the expression
TOTALMTD(exp, dates) - Returns the month to date value of the expression

# Other

SHFT + ENTER - Start a new line
TAB - Ident
// - Comments
```

To avoid the filters, you can use
```sql
CALCULATE(
	SUM(table[col],
	ALL(table))
```

Calculating with a filter (Filter with columns in others tables)
```sql
Total Sales Chiller = 
CALCULATE([Total Sales], 
	FILTER(Fact_Sales, 
		RELATED(Dim_StockItem[Is Chiller Stock]) = TRUE() ))
```

Crossfiltering
```
 CALCULATE(
	DISTINCTCOUNT(col),
	CROSSFILTER(dim_table[key], fact_table[key], BOTH)
```

Summarize should be used like the following, to avoid unexpected results
```
ADDCOLUMNS(
	SUMMARIZE( Amounts,
			   Amounts[Year],
			   Amounts[Category]),
	"Total Amounts",
	SUM(Amounts[Amount])
)		
```

For Time intelligence. It should be used a table with all the dates available, not the Dates from the Fact table
```
TOTALYTD(
	SUM(ORDERS)
	DIM_DATE[Date_key])
)		
```

SWITCH
```
Employee Performance Analysis = 
SWITCH(
    TRUE,
    AND([Average Discount Rate] < .3296, [Profit Ratio] > .5380), "High",
    AND([Average Discount Rate] < .3300, [Profit Ratio] > .5370), "Med",    
    "Low"
)
```

Typicaly used:
``` 
SUMX(
	FILTER(
		order_table, //table
		order_table[Region] = "East") // filter
	sales - profit) // expresion
	
RANKX(
	ALL(Dim_Sales[Region]), //column
	[Total Costs]) //expresion
	
# To avoid rank in Total

IF(HASONEVALUE(Col),
	RANKX(
		ALL(Dim_Sales[Region]), //column
		[Total Costs]), //expresion
	BLANK()
  )
	```

### Operators
```sql
# Comparison
=	Equal to
==	Strict equal to
<>	Not equal to

# Text
&	Concatenates text and values

# Logical
&&	AND
||	OR
IN {}	OR for each row // Like SQL
```

### Examples
```sql
Related number of employees = CALCULATE(SUM('Summary Statistics Double NAICS'[Number of employees]), USERELATIONSHIP('NAICS Code'[2017 NAICS code],'Summary Statistics Double NAICS'[NAICS Code Related])) 
Slicer summary stats = INT(NOT ISEMPTY('Summary Statistics')) -  Cross filtering most efficient option
Use calendar - CALENDAR(MIN(Date),MAX(Date))
SUMMARIZE(Amounts, Amounts[Year], "Total Amount", SUM(...[Amounts])
```

---
## Information

### RLS (Row Level Security)

Row-level security, helps to let a role visualize some information but not to others
- Ensure users only see the information appropiate dor their roles
- Personalize dashboards

Inside "Manage Roles"

```sql
[Email] = USERPRINCIPALNAME()

#Example 

[Is Salesperson] = TRUE  && [Email] = USERPRINCIPALNAME()

```

### Chart examples

Line and stacked column chart could be for visualizing the Sales (bar) and Sales YoY% (line), to appreciate the changed over the years

## Database schemas

-  Star schema - One Fact table aurounded by dimensional tables
-  Snowflake schema - Allow relationships between dimensions

## Tables

### Fact tables
- Measurements from business process
- Keys to establish relations with other dim tables
- Long and narrow

### Dimensional tables
- Provide context
- Who, what, when, where, why?
- Short and wide
- Few rows but lots of columns

![image](https://user-images.githubusercontent.com/78183885/153962359-9adc0f3e-cb54-4d49-89fe-60cfd5bfd43b.png)

