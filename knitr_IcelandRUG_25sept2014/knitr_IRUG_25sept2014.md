# Creating reproducible research with `knitr`
Christopher David Desjardins  
26 September 2014  

## What is reproducible research?
 

 
"The final product of research is not only the paper itself, but also the full __computation environment__ used to produce the results in the paper such as the __code__ and __data__ necessary for reproduction of the results and building upon the research." (Xie, 2014).

Articles submitted for journals should include:

- Manuscript
- Code 
- Data

Obviously, this is not always possible!

## Tools for reproduciblity

- [R](http://r-project.org)
- [knitr](http://yihui.name/knitr/)
- [Markdown](http://daringfireball.net/projects/markdown/) or [LaTeX](http://www.latex-project.org/)

Which one should you use, see [Yihue Xie's post](http://yihui.name/en/2013/10/markdown-or-latex/). 

- [Rstudio](http://www.rstudio.com) (_recommended_)

The developers of Rstudio are often the first to integrate the latest and greatest from `R`.

## Why `knitr`?


```r
install.packages("knitr")
```

How can `knitr` help us achieve reproducibility?

1. We __never__ need to copy and paste results into reports.
2. If the data changes, our models, figures, and tables are __automatically updated__.
3. From a `knitr` document we can automatically generate the output using `knit()` or extract the `R` code from an input document using `purl()`.
5. Generate a document for an `R` script with `stitch()`.
4. It is much more feature rich than Sweave.

## Markdown demonstration


```r
if(!require("shiny"))
  install.packages("shiny")
demo("notebook", package = "knitr")
```

## Input syntax

Input is evaluated in chunks. Either __code chunks__

    ```{r}
    <insert R code for Markdown>
    ```

    <<>>=
    <insert R code for LaTeX>
    @

Or as __inline R code__

```
`r <insert R for Markdown> `

\Sexpr{ <insert R code for LaTeX> }
```


## Chunks


Chunks have a plethora of options. These options include: setting labels, whether the input/output should be hidden, whether all/some of the code should be evaluated, how to handle messages, etc. 


```r
length(opts_chunk$get())
```

```
## [1] 52
```

```r
opts_chunk$get("engine")
```

```
## [1] "R"
```

## Tables

Tables are easily handled with `xtable`. Make sure to specify `results = "asis"` to render the table. 
<!-- html table generated in R 3.1.1 by xtable 1.7-3 package -->
<!-- Fri Sep 19 19:04:58 2014 -->
<TABLE border=1>
<TR> <TH>  </TH> <TH> Estimate </TH> <TH> Std. Error </TH> <TH> t value </TH> <TH> Pr(&gt;|t|) </TH>  </TR>
  <TR> <TD align="right"> (Intercept) </TD> <TD align="right"> -17.5791 </TD> <TD align="right"> 6.7584 </TD> <TD align="right"> -2.60 </TD> <TD align="right"> 0.0123 </TD> </TR>
  <TR> <TD align="right"> speed </TD> <TD align="right"> 3.9324 </TD> <TD align="right"> 0.4155 </TD> <TD align="right"> 9.46 </TD> <TD align="right"> 0.0000 </TD> </TR>
   </TABLE>
<p>
</p>
Finer control of tables with LaTeX. Finally, we insert our fitted model using inline code:

$\hat{dist_i} = -17.5791 + 3.9324 speed_i$

## Code used
    ```{r, results = "asis", echo=FALSE}
    library(xtable)
    mod1 <- lm(dist ~ speed, data = cars)
    coef_tab <- summary(mod1)$coef
    print(xtable(mod1), type = "html")
    ```
    
For the inline code:

```
$\hat{dist_i} = `r coef_tab[1,1]` + `r coef_tab[2,1] ` speed_i$
```


## Using an ioslides table

-------------------------------------------------------------
Coefficients     Estimate     Standard    t-value     Pr(>|t|)
                              Error   
-------------- ------------ ----------- ----------- ------------
(Intercept)    -17.5791       6.7584       -2.6011       0.0123  

speed            3.9324       0.4155       9.464       1.4898 &times; 10<sup>-12</sup>  
-------------------------------------------------------------


