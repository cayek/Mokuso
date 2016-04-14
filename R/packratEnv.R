#' Update packrate env
#'
#'
#' @export
UpdateGithubPkgPackrat <- function(pkgs = c("Mokusu", "TESS3enchoSen", "associationr", "BioCompToolsR", "tess3r")) {
  
  changes <- FALSE
  
  for (p in pkgs) {
    desc <- utils::packageDescription(p)
    if (is.null(desc$GithubSHA1)) {
      base::message(p," is not a github R package.")
    } else {
      # check if git repo change
      sha1 <- base::system(paste0("git ls-remote git://github.com/",
                            desc$GithubUsername,"/",desc$GithubRepo,
                            ".git ", desc$GithubRef), intern = TRUE)
      sha1 <- base::sub("\t.*$","",sha1)
      if (sha1 != desc$GithubSHA1) {
        base::message("Update : ", p)
        # install new version
        devtools::install_github( username = desc$GithubUsername ,
                                  repo = desc$GithubRepo, 
                                  subdir = desc$GithubSubdir, 
                                  ref = desc$GithubRef)
        changes <- TRUE
      } else {
        base::message(p, " last github version")
      }
    }
  }
  if(changes) {
    # packrate snapshot
    packrat::snapshot()
    
    # push env 
    base::system("git add packrat/packrat.lock; git commit -m \"Update packrat env: github package\"; git push")
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