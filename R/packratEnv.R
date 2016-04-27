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
#' @param env.name 
#'
#' @return
#' @export
#'
#' @examples
RenvOn <- function(env.name) {
  Renv.dir <- paste0(Sys.getenv("HOME"),"/.Renv/",env.name)
  if (!dir.exists(Renv.dir)) {
    stop("Renv does not exist.")
  }
  if (!dir.exists(paste0(Renv.dir,"/packrat"))) {
    stop("Error in Renv dir :",Renv.dir,".Please, remote it.")
  }
  packrat::on(Renv.dir)
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
