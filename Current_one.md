# Sampling in Python

## Simple Sampling	

```py
series.sample(n)

series.hist(bins=np.arange(59,93,2)

np.random.seed() 
series.sample(n=x, random_state=y) #Another way to set a seed

np.random.(distribution).(parameters, size) - To generate pseudo-random numbers

series.sample(frac=1) # Randomly samples the whole dataset (1 -> 100%)

series[::interval] #Sampling by picking rows at regular intervals.
```

### Systematic Sampling
```py
# Shuffle the rows of attrition_pop
attrition_shuffled = attrition_pop.sample(frac=1)

# Reset the row indexes and create an index column
attrition_shuffled = attrition_shuffled.reset_index(drop=True).reset_index()

attrition_shuffled.reset_index()

# Plot YearsAtCompany vs. index for attrition_shuffled
attrition_shuffled.plot(x='index',y='YearsAtCompany', kind='scatter')
plt.show()
```

### Stratified Sampling
```py
series.sample(frac=0.1, random_state=2021) #Randomly samples the 10%)
series.value_counts(normalize=True)

df2 = df.groupby(col).sample(frac=0.1)
df2.value_counts(normalize=True)

df = df.groupby(col).sample(n=15)

condition = series == 'x'
df['weight'] = np.where(condition,1,2)
df.sample(frac=0.1, weights='weight')

```

#### Equal proportion on every group
```py
# Proportion of employees by Education level
education_counts_pop = attrition_pop['Education'].value_counts(normalize=True)

# Print education_counts_pop
print(education_counts_pop)

# Proportional stratified sampling for 40% of each Education group
attrition_strat = attrition_pop.groupby('Education')\
	.sample(frac=0.4, random_state=2022)

# Calculate the Education level proportions from attrition_strat
education_counts_strat = attrition_strat['Education'].value_counts(normalize=True)

# Print education_counts_strat
print(education_counts_strat)
```

### Equal sampling on every group
```py
# Get 30 employees from each Education group
attrition_eq = attrition_pop.groupby('Education')\
	.sample(n=30, random_state=2022)      

# Get the proportions from attrition_eq
education_counts_eq = attrition_eq['Education'].value_counts(normalize=True)
# Print the results
print(education_counts_eq)
```

### Clusters

1. Randomly sample subgroups 
2. Randomly sample rows from those subgroups

```py
varieties = random.sample(series,k=n) # Get n random varieties

variety_condition = series.isin(varieties)
result = ratings[variety_condition]

result['variety'].cat.remove_unused_categories() # To remove levels with zero rows

result.groupby('variety').sample(n=5, random_state=x)

---

# Create a list of unique JobRole values
job_roles_pop = list(attrition_pop['JobRole'].unique())

# Randomly sample four JobRole values
job_roles_samp = random.sample(job_roles_pop, k=4)

# Filter for rows where JobRole is in job_roles_samp
jobrole_condition = attrition_pop['JobRole'].isin(job_roles_samp)
attrition_filtered = attrition_pop[jobrole_condition]

# Remove categories with no rows
attrition_filtered['JobRole'] = attrition_filtered['JobRole'].cat.remove_unused_categories()

# Randomly sample 10 employees from each sampled job role
attrition_clust = attrition_filtered.groupby('JobRole').sample(n=10, random_state=2022)
```

#### Mean from data
```py
# Calculate the same thing for the cluster sample 
mean_attrition_clust = attrition_clust.groupby('RelationshipSatisfaction')['Attrition'].mean()

# Print the result
print(mean_attrition_clust)
```

## Relative errors and distributions

- As the sample size increases, the range of calculated sample means tends to decrease. So, increasing the sample size results in better accuracy.

* Number of replicates affects the shape
* Number of samples affects the range

### Relative Error
```py
attrition_srs50 = attrition_pop.sample(n = 50, random_state=2022) 
mean_attrition_srs50 = attrition_srs50['Attrition'].mean()
rel_error_pct50 = 100 * abs(attrition_pop['Attrition'].mean() - mean_attrition_srs50) / attrition_pop['Attrition'].mean()
```

### Sampling Distribution
```py
expand_grid(dictionary) - To change the representation 

series.astype('category')
series.value_counts(sort=False).plot(kind='bar')

sample_means.append(np.random.choice(list(range(1,7)), size=4, replace=True).mean())

-->

sample_means_1000 = []
for i in range(1000):
    sample_means_1000.append(
  		np.random.choice(list(range(1, 9)), size=5, replace=True).mean()
    )

plt.hist(sample_means_1000, bins=20)
plt.show()
```

#### Exact distribution
```py
# Expand a grid representing 5 8-sided dice
dice = expand_grid(
  {'die1': [1, 2, 3, 4, 5, 6, 7, 8],
   'die2': [1, 2, 3, 4, 5, 6, 7, 8],
   'die3': [1, 2, 3, 4, 5, 6, 7, 8],
   'die4': [1, 2, 3, 4, 5, 6, 7, 8],
   'die5': [1, 2, 3, 4, 5, 6, 7, 8]
  })

# Add a column of mean rolls and convert to a categorical
dice['mean_roll'] = (dice['die1'] + dice['die2'] + 
                     dice['die3'] + dice['die4'] + 
                     dice['die5']) / 5
dice['mean_roll'] = dice['mean_roll'].astype('category')

# Draw a bar plot of mean_roll
dice['mean_roll'].value_counts(sort=False).plot(kind='bar')
plt.show()
```

#### Approximate distribution
```py
# Replicate the sampling code 1000 times
sample_means_1000 = []
for i in range(1000):
    sample_means_1000.append(
  		np.random.choice(list(range(1, 9)), size=5, replace=True).mean()
    )

# Draw a histogram of sample_means_1000 with 20 bins
plt.hist(sample_means_1000, bins=20)
plt.show()
```

The standard deviation of the sampling distribution is approximately equal to the population standard deviation divided by the square root of the sample size.
```py
series.std(ddof=x) - 0 for Populations / 1 for Samples or Distributions
```

## Bootstrap

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
# Systematic Sampling

# Shuffle the rows of attrition_pop
attrition_shuffled = attrition_pop.sample(frac=1)

# Reset the row indexes and create an index column
attrition_shuffled = attrition_shuffled.reset_index(drop=True).reset_index()

attrition_shuffled.reset_index()

# Plot YearsAtCompany vs. index for attrition_shuffled
attrition_shuffled.plot(x='index',y='YearsAtCompany', kind='scatter')
plt.show()

---

# Simple Sampling

# Perform simple random sampling to get 0.25 of the population
attrition_srs = attrition_pop.sample(frac=0.25, random_state=2022)

---

# Stratified

# Perform stratified sampling to get 0.25 of each relationship group
attrition_strat = attrition_pop.groupby('RelationshipSatisfaction').sample(frac=0.25, random_state=2022)

---

#Cluster

# Create a list of unique RelationshipSatisfaction values
satisfaction_unique = list(attrition_pop['RelationshipSatisfaction'].unique())

# Randomly sample 2 unique satisfaction values
satisfaction_samp = random.sample(satisfaction_unique, k=2)

# Filter for satisfaction_samp and clear unused categories from RelationshipSatisfaction
satis_condition = attrition_pop['RelationshipSatisfaction'].isin(satisfaction_samp)
attrition_clust_prep = attrition_pop[satis_condition]
attrition_clust_prep['RelationshipSatisfaction'] = attrition_clust_prep['RelationshipSatisfaction'].cat.remove_unused_categories()

# Perform cluster sampling on the selected group, getting 0.25 of attrition_pop
attrition_clust = attrition_clust_prep.groupby('RelationshipSatisfaction').sample(n=len(attrition_pop) // 4, random_state=2022)

```




