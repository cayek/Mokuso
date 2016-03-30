#' Update packrate env
#'
#'
#' @export
UpdateGithubPkgPackrat <- function(pkgs = c("Mokusu", "TESS3enchoSen", "associationr", "BioCompToolsR", "tess3r")) {
  
  changes <- FALSE
  
  for (p in pkgs) {
    desc <- packageDescription(p)
    if (is.null(desc$GithubSHA1)) {
      message(p," is not a github R package.")
    } else {
      # check if git repo change
      sha1 <- system(paste0("git ls-remote git://github.com/",
                            desc$GithubUsername,"/",desc$GithubRepo,
                            ".git ", desc$GithubRef), intern = TRUE)
      sha1 <- sub("\t.*$","",sha1)
      if (sha1 != desc$GithubSHA1) {
        message("Update : ", p)
        # install new version
        devtools::install_github(paste0(desc$GithubUsername,"/",desc$GithubRepo,"/",desc$GithubSubdir))
        changes <- TRUE
      } else {
        message(p, " last github version")
      }
    }
  }
  if(changes) {
    # packrate snapshot
    packrat::snapshot()
    
    # push env 
    system("git add packrat/packrat.lock; git commit -m \"Update packrat env: github package\"; git push")
  }
}