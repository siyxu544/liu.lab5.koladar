#' Get Data Points from Kolada
#' @description
#' Fetches specific data points from the Kolada API based on a combination of
#' query conditions. The function is flexible and can handle
#' single values or vectors for each parameter.
#'
#' @param kpi_id A character vector of one or more KPI IDs (e.g., "N01951").
#' @param municipality_id A character vector of one or more municipality IDs
#'   (e.g., "0580").
#' @param year A character or numeric vector of one or more years
#'   (e.g., 2022 or "2022").
#' @return A tibble with the requested data.
#' @export
#' @examples
#' \dontrun{
#' # Get total population for Linköping (0580) for the year 2022
#' population_data <- get_data(kpi_id = "N01951", municipality_id = "0580", year = "2022")
#'
#' # Get data for multiple KPIs and multiple years for multiple municipalities
#' multi_data <- get_data(kpi_id = c("N01951", "N01953"),
#'                        municipality_id = c("0580", "0001"),
#'                        year = c("2020", "2021", "2022"))
#' }
get_data <- function (kpi_id = NULL,
                      municipality_id = NULL,
                      year = NULL) {
  params <- list()

  # The API expects comma-separated strings for multiple values.
  # We convert R vectors into this format.
  if (!is.null(kpi_id)) {
    params$kpi_id <- kpi_id
  }
  if (!is.null(municipality_id)) {
    params$municipality_id <- municipality_id
  }
  if (!is.null(year)) {
    params$year <- year
  }

  # Check if at least one parameter is provided
  if (length(params) < 2) {
    stop("At least two of 'kpi_id', 'municipality_id', or 'year' must be provided.")
  }

  # Call the kolada_api_get() to get the data from kolada API
  response.list <- kolada_api_get(path = "v3/data", params = params)

  # The response structure is nested.
  # First, bind the top-level rows. This creates a "list-column" named 'values'.
  initial_tibble <- dplyr::bind_rows(response.list$values)

  # If the result is empty, return the empty tibble
  if (nrow(initial_tibble) == 0) {
    return (initial_tibble)
  }

  # Use tidyr::unnest() to expand the nested 'values' list-column into
  # proper rows and columns.
  # tidy_data <- tidyr::unnest(initial_tibble, cols = c("values"))
  tidy_data <- initial_tibble %>%
    dplyr::mutate(values = purrr::map(.data$values, ~ tibble::as_tibble(.x))) %>%
    tidyr::unnest("values")

  return(tidy_data)
}
