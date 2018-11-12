rmarkdown
================
Sue Song
2018-11-04

# R environment

# Structure

## 1\. Header

### Metadata in the Header (YAML)

![](/slide/slide_files/structure.png)

translate the argument into YAML using `yaml::as.yaml`.

``` r
cat(yaml::as.yaml(list(
  title = "example document",
  author = "su so"
)))
```

    ## title: example document
    ## author: su so

## 2\. Code chunks

### Step 1. Insert code chunks

Keyboard shortcuts: - Ctrl + Alt + I (Windows) - Cmd + Option + I (Mac)

### Step 2. Define *chunk options*

#### Options for the output documents

A full list of options available
[here](https://yihui.name/knitr/options/).

| chunk options | description                                                                                                 |
| ------------- | ----------------------------------------------------------------------------------------------------------- |
| `eval`        | execute a code chunk?                                                                                       |
| `echo`        | include the code in the output document?                                                                    |
| `results`     | include the result of the code chunk in the output document?<br>use `asis` for reporting                    |
| `warning`     | show warning messages in the output document?                                                               |
| `message`     | show console messages in the output document?                                                               |
| `include`     | show code & result in the output document? <br>equivalent to `echo=F, results='hide', warning=F, message=F` |
| `cache`       | save the output of a code chunk?                                                                            |
| `fig.width`   | figure width                                                                                                |
| `fig.height`  | figure height                                                                                               |

#### Useful tips & tricks

1.  selective inclusion  
    e.g., `echo=3:5`

<!-- end list -->

``` r
x <- c("a", "b", "c") #3
y <- c(1:3) #4
cbind(x, y) #5
```

    ##      x   y  
    ## [1,] "a" "1"
    ## [2,] "b" "2"
    ## [3,] "c" "3"

2.  using `child` option

This is an example plot from a child document.

``` r
library(ggplot2)
qplot(carat, price, colour = cut, data = diamonds)
```

![](slide_files/figure-gfm/unnamed-chunk-6-1.png)<!-- -->

### Step 3. Code away

#### Create a plot

``` r
plot(cars)
```

![](slide_files/figure-gfm/fig1-1.png)<!-- -->

#### APA-formatted Plot

``` r
ggplot(mtcars, aes(x = mpg, y = disp, colour = as.factor(mtcars$gear))) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(x = "My Pony is Great (MPG)",
       y = "Dispicable (Disp)") +
  scale_color_discrete("Gear") +
  papaja::theme_apa(box = T) +
  theme(legend.position = c(0.8, 0.75))
```

![](slide_files/figure-gfm/apa_graph-1.png)<!-- -->

``` r
ggsave("plot.png", width = 8, height = 5)
# unlink("plot.png")
```

(Optional) Import a figure

``` r
knitr::include_graphics(here("plot.png"))
```

![](/Users/suesong/R/lrm/slide/plot.png)<!-- -->

#### table

Create a table using `knitr::kable` or `stargazer::stargazer`

``` r
mtcars %>%
  summarise(n = n(),
            disp_mean = mean(disp, na.rm = T),
            disp_sd = sd(disp, na.rm = T)) %>%
  as.tibble() %>%
  knitr::kable(caption="Summary Table", digits = 2)
```

|  n | disp\_mean | disp\_sd |
| -: | ---------: | -------: |
| 32 |     230.72 |   123.94 |

Summary Table

``` r
  # stargazer::stargazer(type="html", title = "Summary Table")
```

Tables for test statistics

``` r
knitr::kable(coef(summary(lm(disp ~ wt*as.factor(gear),
                             data = mtcars))),
             format = "markdown", digits = 2)
```

|                     | Estimate | Std. Error | t value | Pr(\>|t|) |
| :------------------ | -------: | ---------: | ------: | --------: |
| (Intercept)         |  \-50.16 |      56.99 |  \-0.88 |      0.39 |
| wt                  |    96.71 |      14.34 |    6.75 |      0.00 |
| as.factor(gear)4    |    26.55 |      80.74 |    0.33 |      0.74 |
| as.factor(gear)5    |  \-66.28 |      93.83 |  \-0.71 |      0.49 |
| wt:as.factor(gear)4 |  \-40.68 |      25.67 |  \-1.58 |      0.13 |
| wt:as.factor(gear)5 |    24.43 |      30.82 |    0.79 |      0.44 |

#### sourcing an external .R script

``` r
knitr::read_chunk(here::here("data_analysis", "data_cleaning.R"))
```

## 3\. Text paragraphs

### inline formatting

[Basic
formatting](https://rmarkdown.rstudio.com/authoring_basics.html)  
[Cheetsheat](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf)

#### extracting test statistics

|                 | r code                           |
| --------------- | -------------------------------- |
| coefficients    | `summary(fit)$coefficients[ ,1]` |
| Standard errors | `summary(fit)$coefficients[ ,2]` |
| test statistics | `summary(fit)$coefficients[ ,3]` |
| p-values        | `summary(fit)$coefficients[ ,4]` |
| R squared       | `summary(fit)$r.squared`         |

#### Example

\(y_{ij}\) = \(\beta_0 + \beta_1 MPG + \beta_2WT + \beta_3MPG*WT + e\)

Step 1. Run and save your analysis

``` r
knitr::kable(broom::tidy(summary(lm.fit <- lm(disp ~ mpg*wt,
                     data = mtcars))), 
             format = "markdown", digits = 3)
```

| term        | estimate | std.error | statistic | p.value |
| :---------- | -------: | --------: | --------: | ------: |
| (Intercept) |   48.552 |   130.463 |     0.372 |   0.713 |
| mpg         |  \-1.106 |     4.609 |   \-0.240 |   0.812 |
| wt          |  114.085 |    29.827 |     3.825 |   0.001 |
| mpg:wt      |  \-2.726 |     1.685 |   \-1.617 |   0.117 |

Step 2. Use `summary(fit)$coefficients` to extract information -
coefficients & p-values …a negative slope of MPG, \(\beta\) = -1.11,
\(p\) = 0.81.

  - r-squared:  
    \(R^2\) = 0.8285675.

For more LaTex [math
symbols](http://web.ift.uib.no/Teori/KURS/WRK/TeX/symALL.html)

#### block quote

> …As this pseudo-workshop dragged on, the scholars have struggled to
> sit through the talk. People wondered, when is this misery going to
> end?
> 
> — scholars

#### footnote

A footnote \[^1\]  
\[^1\]: This is where a foot notes.

### Citing references

#### Useful tools

1.  citr add-in

<!-- end list -->

``` r
# install.packages("citr")
options(citr.use_betterbiblatex = T)
```

2.  papja  
    Step 1. export a bib file from your reference manager (e.g.,
    Mendeley, Zotero)

Step 2. `papaja::r_refs` to create a bib file  
\+ .bib file will include citations for R and R packages used in the
session.

``` r
papaja::r_refs(file = "zotero_ref.bib", append = T)
```

Step 3. `papja::cite_r` to translate them into human-readable citations

``` r
citations <- papaja::cite_r(file=here("workflow", "zotero_ref.bib")
                    #, pkgs = c("papaja", "here")
                    #, withhold = F
                    #, footnote = T
                    )
```

I used R \[Version 3.5.1; @\] and the R-packages *}base* \[@}R-base\],
*bindrcpp* (Version 0.2.2; Müller 2018), *broom* (Version 0.5.0;
<span class="citeproc-not-found" data-reference-id="R-broom">**???**</span>),
*corrplot2017*
(<span class="citeproc-not-found" data-reference-id="R-corrplot2017">**???**</span>),
*dplyr* (Version 0.7.7; Wickham et al. 2018), *forcats* (Version 0.3.0;
Wickham 2018a), *ggplot2* (Version 3.1.0; Wickham 2016), *here* (Version
0.1; Müller 2017), *knitr* (Version 1.20; Xie 2015), *papaja* (Version
0.1.0.9842;
<span class="citeproc-not-found" data-reference-id="R-papaja">**???**</span>),
*purrr* (Version 0.2.5; Henry and Wickham 2018), *readr* (Version 1.1.1;
Wickham, Hester, and Francois 2017), *shiny* (Version 1.2.0;
<span class="citeproc-not-found" data-reference-id="R-shiny">**???**</span>),
*stringr* (Version 1.3.1; Wickham 2018b), *tibble* (Version 1.4.2;
Müller and Wickham 2018), *tidyr* (Version 0.8.2; Wickham and Henry
2018), and *tidyverse* (Version 1.2.1.9000; Wickham, n.d.) for the data
analysis.

#### Step-by-step

1.  Add the .bib file in the same folder as the .Rmd file

2.  Add the following lines in the YAML header:

<!-- end list -->

``` r
---
`bibliography: reference.bib`  
`csl: apa.csl`
---
```

3.  cite away using **citation keys** (optional: with citr addin)  

<!-- end list -->

  - in-line citation … Joel, MacDonald, and Page-Gould (2017, 33)

  - multiple citations separated by a `;`  
    …(see Baldwin 1992; also Joel, MacDonald, and Page-Gould 2017)

  - removing author names by putting a minus sign, `-`  
    …joel (2017)

### Reproducibility

``` r
print(sessionInfo(), locale = FALSE)
```

    ## R version 3.5.1 (2018-07-02)
    ## Platform: x86_64-apple-darwin15.6.0 (64-bit)
    ## Running under: macOS  10.14.1
    ## 
    ## Matrix products: default
    ## BLAS: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] bindrcpp_0.2.2       knitr_1.20           here_0.1            
    ##  [4] forcats_0.3.0        stringr_1.3.1        dplyr_0.7.7         
    ##  [7] purrr_0.2.5          readr_1.1.1          tidyr_0.8.2         
    ## [10] tibble_1.4.2         ggplot2_3.1.0        tidyverse_1.2.1.9000
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] Rcpp_1.0.0        highr_0.7         cellranger_1.1.0 
    ##  [4] plyr_1.8.4        pillar_1.3.0      compiler_3.5.1   
    ##  [7] bindr_0.1.1       tools_3.5.1       digest_0.6.18    
    ## [10] lubridate_1.7.4   jsonlite_1.5      evaluate_0.12    
    ## [13] nlme_3.1-137      gtable_0.2.0      lattice_0.20-35  
    ## [16] pkgconfig_2.0.2   rlang_0.3.0.1     cli_1.0.1        
    ## [19] rstudioapi_0.8    yaml_2.2.0        haven_1.1.2      
    ## [22] withr_2.1.2       xml2_1.2.0        httr_1.3.1       
    ## [25] hms_0.4.2         rprojroot_1.3-2   grid_3.5.1       
    ## [28] tidyselect_0.2.5  glue_1.3.0        R6_2.3.0         
    ## [31] readxl_1.1.0      rmarkdown_1.10    papaja_0.1.0.9842
    ## [34] modelr_0.1.2      magrittr_1.5      codetools_0.2-15 
    ## [37] backports_1.1.2   scales_1.0.0      htmltools_0.3.6  
    ## [40] rvest_0.3.2       assertthat_0.2.0  colorspace_1.3-2 
    ## [43] stringi_1.2.4     lazyeval_0.2.1    munsell_0.5.0    
    ## [46] broom_0.5.0       crayon_1.3.4

# References

<div id="refs" class="references">

<div id="ref-baldwin_relational_1992">

Baldwin, Mark W. 1992. “Relational Schemas and the Processing of Social
Information.” *Psychological Bulletin* 112 (3): 461–84.

</div>

<div id="ref-R-purrr">

Henry, Lionel, and Hadley Wickham. 2018. *Purrr: Functional Programming
Tools*. <https://CRAN.R-project.org/package=purrr>.

</div>

<div id="ref-joel_wanting_2017">

Joel, Samantha, Geoff MacDonald, and Elizabeth Page-Gould. 2017.
“Wanting to Stay and Wanting to Go: Unpacking the Content and
Structure of Relationship Stay/Leave Decision Processes.” *Social
Psychological and Personality Science*.
<https://doi.org/10.1177/1948550617722834>.

</div>

<div id="ref-R-here">

Müller, Kirill. 2017. *Here: A Simpler Way to Find Your Files*.
<https://CRAN.R-project.org/package=here>.

</div>

<div id="ref-R-bindrcpp">

———. 2018. *Bindrcpp: An ’Rcpp’ Interface to Active Bindings*.
<https://CRAN.R-project.org/package=bindrcpp>.

</div>

<div id="ref-R-tibble">

Müller, Kirill, and Hadley Wickham. 2018. *Tibble: Simple Data Frames*.
<https://CRAN.R-project.org/package=tibble>.

</div>

<div id="ref-R-ggplot2">

Wickham, Hadley. 2016. *Ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York. <http://ggplot2.org>.

</div>

<div id="ref-R-forcats">

———. 2018a. *Forcats: Tools for Working with Categorical Variables
(Factors)*. <https://CRAN.R-project.org/package=forcats>.

</div>

<div id="ref-R-stringr">

———. 2018b. *Stringr: Simple, Consistent Wrappers for Common String
Operations*. <https://CRAN.R-project.org/package=stringr>.

</div>

<div id="ref-R-tidyverse">

———. n.d. *Tidyverse: Easily Install and Load the ’Tidyverse’*.

</div>

<div id="ref-R-dplyr">

Wickham, Hadley, Romain François, Lionel Henry, and Kirill Müller. 2018.
*Dplyr: A Grammar of Data Manipulation*.
<https://CRAN.R-project.org/package=dplyr>.

</div>

<div id="ref-R-tidyr">

Wickham, Hadley, and Lionel Henry. 2018. *Tidyr: Easily Tidy Data with
’Spread()’ and ’Gather()’ Functions*.
<https://CRAN.R-project.org/package=tidyr>.

</div>

<div id="ref-R-readr">

Wickham, Hadley, Jim Hester, and Romain Francois. 2017. *Readr: Read
Rectangular Text Data*. <https://CRAN.R-project.org/package=readr>.

</div>

<div id="ref-R-knitr">

Xie, Yihui. 2015. *Dynamic Documents with R and Knitr*. 2nd ed. Boca
Raton, Florida: Chapman; Hall/CRC. <https://yihui.name/knitr/>.

</div>

</div>
