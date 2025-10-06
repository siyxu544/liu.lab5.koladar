# This test block does NOT need the mock API, as it checks for errors before any call is made.
test_that("get_data() throws an error for invalid input (fewer than two arguments)", {
  expect_error(get_data(kpi_id = "N01951"), "At least two of 'kpi_id', 'municipality_id', or 'year' must be provided.")
  expect_error(get_data(municipality_id = "0580"), "At least two of 'kpi_id', 'municipality_id', or 'year' must be provided.")
  expect_error(get_data(year = 2024), "At least two of 'kpi_id', 'municipality_id', or 'year' must be provided.")
})

httptest2::with_mock_api({
  test_that("get_data() can fetch and parse data from the API", {
    pop_data <- get_data(kpi_id = "N01951", municipality_id = "0580", year = 2024)
    expect_s3_class(pop_data, "tbl_df")
    expect_equal(nrow(pop_data), 3)
  })

  test_that("get_data() handles multi-value requests", {
    multi_data <- get_data(
      kpi_id = c("N01951", "N00003"),
      municipality_id = "0580",
      year = c(2023, 2024)
    )
    expect_s3_class(multi_data, "tbl_df")
    expect_equal(sort(unique(multi_data$kpi)), sort(c("N01951", "N00003")))
    expect_equal(sort(unique(multi_data$period)), sort(c(2023, 2024)))
  })

  test_that("get_data() handles queries with no results gracefully", {
    no_data <- get_data(kpi_id = "nonexistent-kpi", municipality_id = "0580", year = 2024)
    expect_s3_class(no_data, "tbl_df")
    expect_equal(nrow(no_data), 0)
  })

  test_that("get_data() handles incorrectly typed (but coercible) input gracefully", {
    # The function should convert the numeric kpi_id to character and the API will return 0 results
    bad_input_data <- get_data(kpi_id = 12345, year = 2024)
    expect_s3_class(bad_input_data, "tbl_df")
    expect_equal(nrow(bad_input_data), 0)
  })
})
