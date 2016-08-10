context("packageEnv")


test_that("UpdateGithubPkg", {
  skip("useless")
  expect_warning(UpdateGithubPkg(pkgs = "rrr"), "no package 'rrr' was found")
  if (Sys.info()["nodename"] == "timc-bcm-15.imag.fr") {
    message("~~timc imag pc detected~~")
    UpdateGithubPkg(checkonly = TRUE)
  }
})

test_that("Renv", {
  skip("do not work when run by testthat")
  if (Sys.info()["nodename"] == "timc-bcm-15.imag.fr") {
    message("~~timc imag pc detected~~")
    BeginRenv("test_354564dqsdff")
    expect_error(BeginRenv("test_354564dqsdff"),"This env.name already exists. Please remove /home/cayek/.Renv/test_354564dqsdff before.")
    
    expect_error(RenvOn("test_354564d"),"Renv does not exist.")
    system("rm -rf ~/.Renv/test_354564dqsdff/")
  }
})