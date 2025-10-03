#' Perform a GET request to the Kolada API
#' @description
#' This is an internal function to construct and perform GET requests
#' to the Kolada API. It handles URL construction, error checking, and JSON
#' parsing. It is not exported to the user.
#' @param path A character string specifying the API endpoint path
#'   (e.g., "v2/kpi").
#' @param params A named list of query parameters to be appended to the URL.
#' @return A list parsed from the JSON response body.
#' @noRd
kolada_api_get <- function (path, params = list()) {
  base_url <- "https://api.kolada.se/"
  # initial request object
  req <- httr2::request(base_url)
  # add the API path to URL
  req <- httr2::req_url_path_append(req, path)
  # add query parameters if provided
  req <- httr2::req_url_query(req, !!!params, .multi = "explode")
  # print(req) # for debugging purpose
  # perform the request and store the response
  resp <- httr2::req_perform(req)
  # This resp_check_status() automatically throw a detailed error if the request
  # was not successful (e.g., status 404 or 500). If successful, it does
  # nothing and the code continues.
  httr2::resp_check_status(resp)
  # parse the JSON response body into an R list
  resp_body <- httr2::resp_body_json(resp)

  return(resp_body)
}
