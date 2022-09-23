# Sampling in Python

## Simple Sampling	

```py
series.sample(n)

series.hist(bins=np.arange(59,93,2)

np.random.seed() 
series.sample(n=x, random_state=y) #Another way to set a seed

np.random.(distribution).(parameters, size) - To generate pseudo-random numbers

series.sample(frac=1) # Randomly samples the whole dataset (1 -> 100%)

```

### Systematic Sampling

One sampling method that avoids randomness is called systematic sampling. Here, you pick rows from the population at regular intervals.

```py
# Set the sample size to 70
sample_size = 70

# Calculate the population size from attrition_pop
pop_size = len(attrition_pop)

# Calculate the interval
interval = pop_size // sample_size

# Systematically sample 70 rows
attrition_sys_samp = attrition_pop[::interval]

# Print the sample
print(attrition_sys_samp)
```

### Stratified Sampling

If you are interested in subgroups within the population, then you may need to carefully control the counts of each subgroup within the population. 
Proportional stratified sampling results in subgroup sizes within the sample that are representative of the subgroup sizes within the population. 
It is equivalent to performing a simple random sample on each subgroup.

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

With bootstraping, we treat the dataset as a sammple and use it to build up a theoretical population.

There are three steps:

1. Make a resample of the dame size as the original sample (replacing)
2. Calculate the statistic of interest for this bootstrap sample
3. Repet steps 1 and 2 many times

The key to deciding whether to sample without or with replacement is whether or not your dataset is best thought of as being the whole population or not.

In the folowing excercise, the mean from "mean_danceability_1000", is the estimated population mean:

```py
# Replicate this 1000 times
mean_danceability_1000 = []
for i in range(1000):
	mean_danceability_1000.append(
        np.mean(spotify_sample.sample(frac=1, replace=True)['danceability'])
	)

# Draw a histogram of the resample means
plt.hist(mean_danceability_1000)
plt.show()
```
If the original sample wasn't colsely representative of the population, then the boostrap distribution won't be a good estimate. Bootstraping is good to estimate the population std.

population_std = std_error * sqrt(n) - Where 'n' is sample size

The standard error is the standard deviation of the statistic of interest.

The std of a boostrap is a good approximation of the standard error.

#### Sampling distribution vs bootstrap distribution

The sampling distribution mean is the best estimate of the true population mean; the bootstrap distribution mean is closest to the original sample mean.

The calculation from the bootstrap distribution is the best estimate of the population standard deviation.

So, boostraping is not too good for estimating mean, but is great for estimating std

```py

###### Sampling
mean_popularity_2000_samp = []

# Generate a sampling distribution of 2000 replicates
for i in range(2000):
    mean_popularity_2000_samp.append(
    	# Sample 500 rows and calculate the mean popularity 
    	np.mean(spotify_population.sample(n=500, replace=False)['popularity'])
    )

# Print the sampling distribution results
print(mean_popularity_2000_samp)


###### Boostrap
mean_popularity_2000_boot = []

# Generate a bootstrap distribution of 2000 replicates
for i in range(2000):
    mean_popularity_2000_boot.append(
    	# Resample 500 rows and calculate the mean popularity     
    	np.mean(spotify_sample.sample(n=500, replace=True)['popularity'])
    )

# Print the bootstrap distribution results
print(mean_popularity_2000_boot)
```

The calculation from the bootstrap distribution is the best estimate of the population standard deviation.

```py
# Calculate the population std dev popularity
pop_sd = spotify_population['popularity'].std(ddof=0)

# Calculate the original sample std dev popularity
samp_sd = spotify_sample['popularity'].std()

# Calculate the sampling dist'n estimate of std dev popularity
samp_distn_sd = np.std(sampling_distribution, ddof=1) * np.sqrt(5000)

# Calculate the bootstrap dist'n estimate of std dev popularity
boot_distn_sd = np.std(bootstrap_distribution, ddof=1) * np.sqrt(5000)
```
 
### Confidence Intervals

```py
# Quantile Method

np.quantile(series, 0.025)
np.quantile(series, 0.975)

# Std error method (Assuming the distribution is normal)

norm.ppf(quantile, loc=o, scale=1) - To get the inverted CDF (Flip 'x' and 'y' axis)

point_estimate = np.mean(x)
std_error = np.std(x, ddof=1)

lower = norm.ppf(0.025, loc=point_estimate, scale= std_error)
upper = norm.ppf(0.975, loc=point_estimate, scale=std_error)

```

```py

```

```py

```
## Examples

```py
# Systematic Sampling

# Set the sample size to 70
sample_size = 70

# Calculate the population size from attrition_pop
pop_size = len(attrition_pop)

# Calculate the interval
interval = pop_size // sample_size

# Systematically sample 70 rows
attrition_sys_samp = attrition_pop[::interval]

# Print the sample
print(attrition_sys_samp)

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




