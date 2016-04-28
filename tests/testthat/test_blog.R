context("Blog")


test_that("build", {
  if (Sys.info()["nodename"] == "timc-bcm-15.imag.fr") {
    message("~~timc imag pc detected~~")
    Mokusu.jekyll.dir <- "~/PatatorHomeDir/Projects/PersonalWebSite/"
    Mokusu.labnotebook.dir <- "/home/cayek/PatatorHomeDir/Notebook/Labnotebook/"
    BuildPostForJekyll("~/PatatorHomeDir/Notebook/Labnotebook/2016-03-14-test.Rmd", jekyll.dir = Mokusu.jekyll.dir)
    res <- NewLabnotebook("3556453435dqfdd", jekyll.dir = Mokusu.jekyll.dir, labnotebook.dir = Mokusu.labnotebook.dir)
    system(paste0("rm -f ",res))
  }
  
})