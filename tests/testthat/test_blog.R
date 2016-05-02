context("Blog")


test_that("build", {
  if (Sys.info()["nodename"] == "timc-bcm-15.imag.fr") {
    message("~~timc imag pc detected~~")
    options(Mokusu.jekyll.dir = "~/KrakenatorHomeDir/Projects/PersonalWebSite/", Mokusu.labnotebook.dir = "/home/cayek/KrakenatorHomeDir/Notebook/Labnotebook/")
    BuildPostForJekyll("~/KrakenatorHomeDir/Notebook/Labnotebook/2016-03-14-test.Rmd")
    res <- NewLabnotebook("3556453435dqfdd")
    system(paste0("rm -f ",res))
  }
  
})