#' Get Municipalities
#' @description
#' Fetches a list of Swedish municipalities from the Kolada API.
#' You can retrieve all municipalities or filter them by providing a search
#' string for the title.
#' @param title A character string used to search for municipalities by title.
#'   The search uses a space-separated list of filter arguments. Can be NULL.
#' @return A tibble with columns `id` and `title`.
#' @export
#' @examples
#' \dontrun{
#' # Get all municipalities
#' all_municipalities <- get_municipalities()
#'
#' # Search for municipalities with "Linköping" in the title
#' linkoping <- get_municipalities(title = "Linköping")
#' }
get_municipalities <- function(title = NULL) {
  params <- list()
  if (!is.null(title)) {
    params$title <- title
  }

  # Call the kolada_api_get() to get the data from kolada API
  response_list <- kolada_api_get(path = "v3/municipality", params = params)

  # The actual data is inside the "values" element of the response.
  # use dplyr::bind_rows to convert the list of lists into a tibble
  municipality_data <- dplyr::bind_rows(response_list$values)

  # Ensure the output is a tibble for consistency
  municipality_tibble <- tibble::as_tibble(municipality_data)

  return(municipality_tibble)
}
