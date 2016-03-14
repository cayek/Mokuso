#' 
#' @export
NewLabnotebook <- function(title, labnotebook.dir = "~/Project/Notebook/Labnotebook",
                     jekyll.dir = "~/Projects/PersonalWebSite/",
                     skeleton.file = ".skeleton_post"){
 
  
  # create filename
  file.name = paste0(labnotebook.dir,NormalizeName(title),".Rmd")
  
  # create Rmkdown with blog template if do not exist
  if(file.exists(file.name)) {
    stop("This file exists. Remove it before.")
  } else {
    file.copy(skeleton.file,file.name)
  }
  
  # open it in R studio
  rstudioapi::navigateToFile(file.name)
  
  # compile with jekkyl and display in viewer
  BuildPost(file.name)
  
}

NormalizeName <- function(title){
  # name with date
  return(paste0(format(Sys.time(), "%Y-%m-%d"),"-",sub("[ _./]","-",title)))
}


BuildPost <- function(file.name, jekyll.dir = "~/Projects/PersonalWebSite/"){

  # build md in jekkyl _post/buildfromR dir and set image in  with knitr
  # rmk : see render_jekkyl

  # if filename is not well formated, generate a well formated md.
  
  # copy in place
  
  # build with jekyl 
  
  # view in rstudio viewer
  
}


ServeLocalJekyll <- function(jekyll.dir = "~/Projects/PersonalWebSite/") {
  # run jekkyl server
  
  # onpen in viewer
}

DeployTIMCIMAGJekyll <- function(jekyll.dir = "~/Projects/PersonalWebSite/", intern = TRUE) {
  
  # run deploy script
  script.file = paste0(jekyll.dir, "script/deploy.pl")
  system(paste(script.file, ifelse(intern,"--interne")))
}

