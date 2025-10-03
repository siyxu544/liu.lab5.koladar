#' Get Key Performance Indicators (KPIs)
#' @description
#' Fetches a list of Key Performance Indicators (KPIs) from the Kolada API.
#' You can retrieve all KPIs or filter them by providing a search string for
#' the title.
#' @param title A character string used to search for KPIs by title.
#'   The search uses a space-separated list of filter arguments. Can be NULL.#'
#' @return A tibble with columns `id`, `title`, and `description`.
#' @export
#' @examples
#' \dontrun{
#' # Get all KPIs
#' all_kpis <- get_kpis()
#' # Search for KPIs with "Invånare totalt, antal" (Total inhabitants, number) in the title
#' population_kpis <- get_kpis(title = "Invånare totalt, antal")
#' }
get_kpis <- function (title = NULL) {
  params <- list()
  if (!is.null(title)) {
    params$title <- title
  }
  # Call the kolada_api_get() to get the data from kolada API
  response_list <- kolada_api_get(path = "v3/kpi", params = params)

  # The actual data is inside the "values" element of the response.
  # use dplyr::bind_rows to convert the list of lists into a tibble
  kpi_data <- dplyr::bind_rows(response_list$values)

  # Ensure the output is a tibble for consistency
  kpi_tibble <- tibble::as_tibble(kpi_data)

  return(kpi_tibble)
}
