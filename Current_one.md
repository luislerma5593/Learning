# Hypothesis testing

* ANOVA - Is a test for differences between groups (Is mean annual compensation different for different levels of job satisfaction?)

** ANOVA extends the t-tests for more than wo groups**

It's between a categorical variable and a numeric variable 

pingouin.anova(data, dv=numeric_var, between=categorical_var)

- $H_0 :$ No significant difference
- $H_1 :$ At least two categories have a significant difference

* Chi squared - Is a test 

** Chi-squared tests of independence extend proportion tests to more than two groups**

```py
feather.read_feather(path+'\dem_votes_potus_12_16.feather') - Read feather files

t.cdf(t_stat, df=x) - Calculate p-values from t-distribution

pingouin.ttest(z=sample_data['diff'], y=0, alternative='less') - Easier way to perform a ttest

stat, p_value = proportions_ztest(count=success_counts, nobs=n, alternative="larger") - For two smaples proportions test
```

## Examples

```py

```




