## Data visualization with Matplotlib

### Lineplot
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

### Share visuaizations 

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






































