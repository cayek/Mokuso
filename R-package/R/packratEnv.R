#' Update packrate env
#'
#'
#' @export
UpdateGithubPkg <- function(pkgs = c("Mokusu", "associationr", "BioCompToolsR", "tess3r", "tess3rOld"), checkonly = TRUE) {
  
  for (p in pkgs) {
    desc <- utils::packageDescription(p)
    if (!is.na(desc)[1]) {
      if (is.null(desc$GithubSHA1)) {
        base::message(p," is not a GitHub R package.")
      } else {
        # check if git repo change
        sha1 <- base::system(paste0("git ls-remote git://github.com/",
                                    desc$GithubUsername,"/",desc$GithubRepo,
                                    ".git ", desc$GithubRef), intern = TRUE)
        sha1 <- base::sub("\t.*$","",sha1)
        if (sha1 != desc$GithubSHA1) {
          if (!checkonly) {
            base::message("Update : ", p)
            # install new version
            devtools::install_github( repo = paste0(desc$GithubUsername,"/",desc$GithubRepo), 
                                      subdir = desc$GithubSubdir, 
                                      ref = desc$GithubRef)
          } else {
            message(p,": NOT LAST GITHUB VERSION")
          }
        } else {
          base::message(p, ": last github version")
        }
      }
    }
  }
}


#' Update packrate env
#'
#'
#' @export
SavePackratEnv <- function() {
  if (file.exists("packrat/init.R")) {
    # packrate snapshot
    packrat::snapshot()
    # push env 
    if (dir.exists(".git/")) {
      base::system("git add packrat/packrat.lock .Rprofile; git commit -m \"Save packrat env\"; git push")
    }
  }
}


#' Title
#'
#' @param env.name 
#'
#' @return
#' @export
#'
#' @examples
BeginRenv <- function(env.name) {
  Renv.dir <- paste0(Sys.getenv("HOME"),"/.Renv/")
  
  if (!dir.exists(Renv.dir)) {
    dir.create(Renv.dir)
  }
  
  Renv.dir <- paste0(Renv.dir,env.name)
  if (dir.exists(Renv.dir)) {
    stop("This env.name already exists. Please remove ", Renv.dir," before.")
  }
  dir.create(Renv.dir)
  
  packrat::init(project = Renv.dir, enter = FALSE)
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
RenvInstallMostImportantPackage <- function() {
  message("# packrat status: ")
  packrat::status()
  packrat::set_opts(external.packages = "devtools")
  
  # my package
  pkgs <- c("cayek/mokusu", 
          "cayek/TESS3_encho_sen",
          "cayek/TESS3/tess3r@develop", 
          "cayek/associationr", 
          "cayek/BenchmarkingR",
          "cayek/BioCompToolsR")
  message("# github packages")
  for (p in pkgs) {
    message("## installing: ", p)
    devtools::install_github(p, quiet = TRUE)
  }
  
  # cran
  pkgs <- c("foreach", 
            "doParallel",
            "ggplot2",
            "raster", 
            "maps", 
            "data.table", 
            "dplyr", 
            "plyr", 
            "Rcpp", 
            "RcppEigen", 
            "RcppArmadillo", 
            "knitr",
            "png",
            "tikzDevice",
            "RgoogleMaps",
            "ggmap")
  
  message("# CRAN packages")
  pkgs <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]
  for (p in pkgs) {
    message("## installing: ", p)
    install.packages(p, quiet = TRUE)
  }
  
  # bioconductor
  source("http://bioconductor.org/biocLite.R")
  pkgs <- c("LEA")
  
  message("# Bioconductor packages")
  pkgs <- pkgs[!(pkgs %in% installed.packages()[,"Package"])]
  for (p in pkgs) {
    message("## installing: ", p)
    biocLite(p, quiet = TRUE)
  }
  
}


#' Title
#'
#' @param env.name 
#'
#' @return
#' @export
#'
#' @examples
RenvOn <- function(env.name) {
  Renv.dir <- paste0(Sys.getenv("HOME"),"/.Renv/",env.name)
  curdir <- getwd()
  if (!dir.exists(Renv.dir)) {
    stop("Renv does not exist.")
  }
  if (!dir.exists(paste0(Renv.dir,"/packrat"))) {
    stop("Error in Renv dir :",Renv.dir,".Please, remote it.")
  }
  setwd(Renv.dir)
  packrat::on(Renv.dir)
  setwd(curdir)
}

#' Title
#'
#' @param env.name 
#'
#' @return
#' @export
#'
#' @examples
RenvOff <- function(env.name) {
  packrat::off()
}
