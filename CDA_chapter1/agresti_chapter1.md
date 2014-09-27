## Chapter Overview
* If you've had a course in statistical theory, this chapter is likely entirely review.


*Categorical variable* : measurement scale consisting of a set of categories.

## Background
* Research studies in the social and biomedical science drove the development of categorical data analysis (CDA).
* Applications in a myriad fields - behavioral sciences, education, engineering, ecology, public health, advertising, etc.

## Types of Scales
* **Nominal** - No natural order.
	* County of Origin - Iceland, USA, Poland, ... 
	* Gender - Female, Male	
	* **Ordinal** - Natural order; distance between categories unknown. 
	* Poltical Views - Liberal, Moderate, Conservative
	* Health - Good, Fair, Poor
	* Rating Scales
* **Interval** - Natural order; distance between categories known.
* Interval > Ordinal > Nominal Hierarchy
	* Methods for ordinal data **can** be applied to interval data but **not** the other way around.
	* Best to use methods developed for a particular scale.
* **Continuous** vs. **Discrete** and **Qualitative** vs. *Quantitative* variables.

## Distributions

### Binomial
* Let $$$y\_1, y\_2, ..., y\_n$$$ be realizations of $$$Y\_1, Y\_2, Y\_n$$$ that are i.i.d. with a fixed number, *n*, of binary observations.  
* Then $$$P(Y_i = 1) = p$$$ (success) and $$$P(Y_i = 0) = 1 - p$$$ (failure).
* Each realization is a **Bernoulli** trial, where the total number of successes, $$$Y = \sum_{i = 1}^n Y_i$$$ is distributed with a Bin(n, p).
* The pmf for possible outcomes *y* for is *Y* is  
$$ Pr(y) = \binom{n}{y}p^y (1 - p)^{n - y} $$
Where $$$E(Y_i) = p$$$ and $$$var(Y_i)  = p(1 - p) = pq$$$ for a Bernoulli trial and $$$E(\sum_{i = 1}^n Y_i) = np$$$ and $$$var(\sum\_{i = 1}^n Y_i) = np(1 - p) = npq$$$.
* For a fixed *p*, as $$$n \rightarrow \infty$$$, Binomial $$$\rightarrow$$$ normal
* Hypergeometric appropriate when binary observations are not i.i.d.

### Multinomial
* *n* realizations with an outcome with *C* categories.
* Let $$$y\_{ij}$$$ = 1 if type *i* has outcome in category *j*, else $$$y\_{ij}$$$ = 0. Then $$$ \mathbf{y_i} = (y\_{i1}, y\_{i2}, .., y\_{ic}) $$$ and $$$y\_{ic}$$$ is linearly dependent on the other outcomes.
* Let $$$n_j = \sum\_{i}y\_{ij}$$$, then $$$(n_1, n_2, ..., n_c) \sim Multi(n, p\_1, p\_2, ..., p\_c)$$$  
* The pmf is:
$$Pr(n_1, n_2, ..., n\_{c-1}) = \frac{n!}{n_1!, n_2!, \cdots,n_c!}p_1^{n_1}p_2^{n_2}\cdots p_c^{n_c} $$
Where $$$E(n_j) = np_j$$$; $$$var(n_j) = np_j(1 - p_j) $$$; and $$$cov(n_j, n_k) =  -np_jp_k $$$
* Marginal distributions of $n_j$ are Binomial.

### Poisson
* Unbounded, non-negative counts (e.g. number of hérna in a heitur pottur in 15 minutes).
$$Pr(y) = \frac{e^{-\mu}\mu^y}{y!}$$
for *y* = 0, 1, 2, ...
* $$$E(y) = var(y) = \mu$$$.
* As $$$\mu \rightarrow \infty$$$, Poisson $$$\rightarrow$$$ normal.
* Approximation of the binomial when $n$ is large and $p$ is small ($$$\mu = np$$$).
* The sum of Poissons is also distributed with a Poission and if we condition on *n* then this has a multinomial distribution.

## Problems with these distributions

* Overdispersion
	* For Poission, may need negative binomial
* Models are too simplistic or misspecified.

## Parameter estimation
* Often use MLE
	* They have large-sample normal distributions
	* they are asymptotically consistent 
	* converging to the parameter as n increases;  
	* are asymptotically efficient, producing large-sample standard errors no greater than those from other estimation methods. 
* MLE of $$$\hat{\beta} = \frac{dL(\beta)}{d\beta} = 0$$$ and SEs are the square roots of the diagonal elements of the inverse information matrix. 

## Hypothesis testing and CIs
* Wald, LRT, and score tests

![fig1](fig1.png)

* Wald uses L($$$\beta$$$) behavior at MLE
* Score uses L($$$\beta$$$) behavior at H$$$_O$$$.
* LRT uses information at both.
* Can of course construct CIs. 
* LRT is the statistic **that has always been recommended to me** given it's better performance with small to moderate sample sizes.

## Single parameter tests
* Agresti derives hyptothesis tests/CIs for binomial parameter and multinomial parameters.
* 
### Binomial
* Demonstrates poor performance of these confidence intervals when parameter lies on/is close to the boundary of the parameter space.
* Presents Clopper-Pearson method for confidence intervals.
	
![fig2](fig2.png)

* mid-*P*-value = $$$1/2 Pr(T = t\_0) + P(T > t\_0)$$$
* Thus mid-*P*-value is less than the ordinary *P*-value by half the probability of the observed result.

### Multinomial 
* For multinomial parameters, presents Pearson's chi-squared statistic, X$$$^2$$$ - $$$\sum\frac{(obs-exp)^2}{exp}$$$ with df = c - 1 and LRT chi-squared statistic (G$$$^2$$$) - $$$2 \sum n\_j log(n\_j/np\_{j0})$$$, for large *n*, df = c - 1. 
	* Mendel's data
* Chi-squared approximation of G$$$^2$$$ poor when $$$n / c < 5$$$ and fine for X$$$^2$$$ when c is large and $$$n/c$$$ is as small as 1 if exp freq aren't too big or too small. 

### Pearson vs. LRT


	
	

