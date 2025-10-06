httptest2::with_mock_api({
  test_that("get_municipalities() returns all municipalities correctly", {
    all_mun <- get_municipalities()
    expect_s3_class(all_mun, "tbl_df")
    expect_gte(nrow(all_mun), 290) # There are 290 municipalities in Sweden according to wikipedia, so the record No. returned should be equal to or greater than 290
    expect_true(all(c("id", "title") %in% names(all_mun)))
  })
  test_that("get_municipalities() can filter for a specific municipality", {
    linkoping <- get_municipalities(title = "Linköping")
    expect_equal(nrow(linkoping), 1)
    expect_equal(linkoping$id, "0580")
  })
  test_that("get_municipalities() handles non-existent title search gracefully", {
    no_results <- get_municipalities(title = "A Non Existent City 123")
    expect_s3_class(no_results, "tbl_df")
    expect_equal(nrow(no_results), 0)
  })
})
