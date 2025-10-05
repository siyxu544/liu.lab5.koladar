
# liu.lab5.koladar

<!-- badges: start -->
[![R-CMD-check](https://github.com/siyxu544/liu.lab5.koladar/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/siyxu544/liu.lab5.koladar/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of liu.lab5.koladar is to provides an R interface to the Swedish 'Kolada' database API (<https://www.kolada.se/om-oss/api/>). The Kolada database is a comprehensive collection of key indicators and statistics regarding Swedish municipalities. This package serves as a high-level wrapper, abstracting away the complexities of the underlying web API. It offers functions to discover available metadata, such as key performance indicators (KPIs) and municipalities, and to fetch specific data points, returning them in tidy data frames suitable for analysis in R. This package was created for Lab 5 in the course 732A94 Advanced R Programming at Linköping University.


## Installation

You can install the development version of liu.lab4.algorithms from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("siyxu544/liu.lab5.koladar")
```

## Example

``` r
library(liu.lab5.koladar)
# Search for municipalities with "Linköping" in the title
linkoping <- get_municipalities(title = "Linköping")
print(linkoping)
#   A tibble: 1 × 3
#   id    title     type 
#   <chr> <chr>     <chr>
# 1 0580  Linköping K  

# Search for KPIs with "Invånare totalt, antal" (Total inhabitants, number) in the title
population_kpis <- get_kpis(title = "Invånare totalt, antal")
print(population_kpis)
#   A tibble: 5 × 11
#   id     title      description is_divided_by_gender municipality_type auspice
#   <chr>  <chr>      <chr>       <lgl>                <chr>             <chr>  
# 1 N01951 Invånare … Antal invå… TRUE                 A                 X      
# 2 N80713 Patienter… Totalt ant… FALSE                L                 T      
# 3 N80716 Patienter… Totalt ant… FALSE                L                 T      
# 4 N80719 Patienter… Totalt ant… FALSE                L                 T      
# 5 N80722 Besök i t… Totalt ant… FALSE                L                 T      
#   ℹ 5 more variables: operating_area <chr>, perspective <chr>,
#     publication_date <chr>, publ_period <chr>, has_ou_data <lgl>

# Get total population for Linköping (0580) for the year 2022
population_data <- get_data(kpi_id = "N01951", municipality_id = "0580", year = "2022")
print(population_data)
#   A tibble: 3 × 8
#   gender count status  value isdeleted kpi    period municipality
#   <chr>  <int> <chr>   <dbl> <lgl>     <chr>   <int> <chr>       
# 1 K          1 ""      81679 FALSE     N01951   2022 0580        
# 2 M          1 ""      84994 FALSE     N01951   2022 0580        
# 3 T          1 ""     166673 FALSE     N01951   2022 0580  

# Get data for multiple KPIs and multiple years for multiple municipalities
multi_data <- get_data(kpi_id = c("N01951", "N01953"), municipality_id = c("0580", "0001"), year = c("2020", "2021", "2022"))
print(multi_data)
#    A tibble: 36 × 8
#    gender count status   value isdeleted kpi    period municipality
#    <chr>  <int> <chr>    <dbl> <lgl>     <chr>   <int> <chr>       
#  1 K          1 ""     1194315 FALSE     N01951   2020 0001        
#  2 M          1 ""     1197675 FALSE     N01951   2020 0001        
#  3 T          1 ""     2391990 FALSE     N01951   2020 0001        
#  4 K          1 ""       80561 FALSE     N01951   2020 0580        
#  5 M          1 ""       84055 FALSE     N01951   2020 0580        
#  6 T          1 ""      164616 FALSE     N01951   2020 0580        
#  7 K          1 ""     1205210 FALSE     N01951   2021 0001        
#  8 M          1 ""     1209929 FALSE     N01951   2021 0001        
#  9 T          1 ""     2415139 FALSE     N01951   2021 0001        
# 10 K          1 ""       81028 FALSE     N01951   2021 0580        
#   ℹ 26 more rows
#   ℹ Use `print(n = ...)` to see more rows
```

## Tests

The package uses **testthat** and **httptest2** to test API calls with recorded fixtures:

```r
testthat::test_local()
```
