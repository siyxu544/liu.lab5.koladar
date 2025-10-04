
# liu.lab5.koladar

<!-- badges: start -->
[![R-CMD-check](https://github.com/siyxu544/liu.lab5.koladar/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/siyxu544/liu.lab5.koladar/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of liu.lab5.koladar is to provides an R interface to the Swedish 'Kolada' database API (<https://www.kolada.se/om-oss/api/>). The Kolada database is a comprehensive collection of key indicators and statistics regarding Swedish municipalities. This package serves as a high-level wrapper, abstracting away the complexities of the underlying web API. It offers functions to discover available metadata, such as key performance indicators (KPIs) and municipalities, and to fetch specific data points, returning them in tidy data frames suitable for analysis in R. This package was created for Lab 5 in the course 732A94 Advanced R Programming at Linköping University.


## Installation

You can install the development version of liu.lab5.koladar from [GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("siyxu544/liu.lab5.koladar")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(liu.lab5.koladar)
## basic example code
```

