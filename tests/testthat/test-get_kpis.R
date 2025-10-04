httptest2::with_mock_api({
  test_that("get_kpis() returns a tibble", {
    all_kpis <- get_kpis()
    expect_s3_class(all_kpis, "tbl_df")
  })

  test_that("get_kpis() the tibble returned contains expected columns", {
    all_kpis <- get_kpis()
    expected_cols <- c("id", "title", "description")
    expect_true(all(expected_cols %in% names(all_kpis)))
  })

  test_that("get_kpis() uses title parameter to filter results", {
    all_kpis <- get_kpis()
    filtered_kpis <- get_kpis(title = "Invånare")
    expect_lt(nrow(filtered_kpis), nrow(all_kpis))
    expect_gt(nrow(filtered_kpis), 0)
  })
})
