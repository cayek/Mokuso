#' Create a file in labnotebook.dir then open it and build it with knitr and jekyll.
#' 
#' @export
NewLabnotebook <- function(title, labnotebook.dir = "/home/cayek/PatatorHomeDir/Notebook/Labnotebook/",
                     jekyll.dir = "~/PatatorHomeDir/Projects/PersonalWebSite/",
                     skeleton.file = ".skeleton_post"){
 
  
  # create filename
  file.name = paste0(labnotebook.dir,"/",NormalizeName(title),".Rmd")
  
  # create Rmkdown with blog template if do not exist
  if(file.exists(file.name)) {
    stop("This file exists. Remove it before.")
  }
  
  if(!file.exists(skeleton.file)){
    message("File .skeleton_post does not exist. Using package default")
    skeleton.file <- system.file("labnotebook_template.Rmd", package = "Mokusu")
  }
  file.copy(skeleton.file,file.name)
  
  # set tittle
  post <- readLines(file.name)
  post[grepl("title: ", post)] <- paste0("title:  ", title)
  writeLines(post, file.name)
  
  # open it in R studio
  rstudioapi::navigateToFile(file.name)
  
  # compile with jekkyl and display in viewer
  BuildPostForJekyll(file.name, jekyll.dir = jekyll.dir)
  
}

NormalizeName <- function(title){
  # name with date
  return(paste0(format(Sys.time(), "%Y-%m-%d"),"-",gsub("[ _./]","-",title)))
}


#' TODO
#' 
#' @export
SetKnitrOption <- function(input, jekyll.dir) {
  
  d = gsub('^_|[.][a-zA-Z]+$', '',  basename(input))
  knitr::opts_chunk$set(
    fig.path   = sprintf('figs/%s/', d),
    cache.path = sprintf('%s/knitrCache/%s/',jekyll.dir, d)
  )
  
  # an absolute directory under which the plots are generated
  knitr::opts_knit$set(
    base.dir = jekyll.dir
  )

  # template variable
  knitr::opts_knit$set(
    base.url = "{{ site.url | append: site.baseurl }}"
  )
  
  knitr::render_jekyll(highlight = "pygments")
}

#' TODO
#' 
#' @export
BuildPostForJekyll <- function(file.name, jekyll.dir = "~/PatatorHomeDir/Projects/PersonalWebSite/", draft = TRUE){

  message(paste0("Build for jekyll: ",file.name))
  
  
  # generate outpuname
  # if filename is not well formated, generate a well formated md.
  output = paste0(jekyll.dir, ifelse(draft,"_drafts/","_posts/"),
                  gsub('.Rmd', '.md',basename(file.name)) )
  
  # remove in post or draft
  file.remove(paste0(jekyll.dir, ifelse(!draft,"_drafts/","_posts/"),
                     gsub('.Rmd', '.md',basename(file.name)) ), showWarnings = FALSE)
  
  # build md witj jekyll and knitr
  SetKnitrOption(input = file.name, jekyll.dir = jekyll.dir)
  
  # build markdown with knit
  knitr::knit(input = file.name, output = output)
  
  message("You can know run : ",paste("jekyll build --source", jekyll.dir, 
                                   "-d", paste0(jekyll.dir,"_site/"), 
                                   ifelse(draft,"--drafts","")))
  
}

#' Build the current file as draft
#' 
#' @export
BindBuildCurrentPostForJekyllAsDraft <- function() {
  current.file <- rstudioapi::getActiveDocumentContext()
  if (grepl('^.*.Rmd', current.file$path)) {
    BuildPostForJekyll(file.name = current.file$path, draft = TRUE) 
  } else {
    message("The file must a .Rmd")
  }
}

#' Build the current file
#' 
#' @export
BindBuildCurrentPostForJekyll <- function() {
  current.file <- rstudioapi::getActiveDocumentContext()
  if (grepl('^.*.Rmd', current.file$path)) {
    BuildPostForJekyll(file.name = current.file$path, draft = FALSE) 
  } else {
    message("The file must a .Rmd")
  }
}

#' TODO
#' 
#' @export
BindDeployTIMCIMAGJekyllIntern <- function() {
  DeployTIMCIMAGJekyll(intern = TRUE)
}

#' TODO
#' 
#' @export
BindDeployTIMCIMAGJekyll <- function() {
  DeployTIMCIMAGJekyll(intern = FALSE)
}


#' TODO
#' 
#' @export
DeployTIMCIMAGJekyll <- function(jekyll.dir = "~/PatatorHomeDir/Projects/PersonalWebSite/", intern = TRUE) {
  
  url.site = paste0("http://membres-timc",ifelse(intern,"-interne",""),".imag.fr")
  
  # toggle url
  config.filename <- paste0(jekyll.dir,"/_config.yml")
  config.file <- readLines(config.filename)
  config.file <- gsub('"/blog/"','"/Kevin.Caye/"', config.file)
  config.file <- gsub("http://localhost:4000", url.site, config.file)
  writeLines(config.file, config.filename)
  
  tryCatch({
    cmd <- paste("jekyll build --source", jekyll.dir, 
          "-d", paste0(jekyll.dir,"_site/"))
    system(cmd)
    system(paste('rsync -e ssh -avz --delete-after', 
                  paste0(jekyll.dir,"_site/") ,
                  'cayek@lacan.imag.fr:~/Kevin.Caye/'))
  },finally = {
    # toggle url
    config.filename <- paste0(jekyll.dir,"/_config.yml")
    config.file <- readLines(config.filename)
    config.file <- gsub('"/Kevin.Caye/"','"/blog/"', config.file)
    config.file <- gsub(url.site, "http://localhost:4000",  config.file)
    writeLines(config.file, config.filename)
  })
  
  # open in wiewer
  browseURL(paste0(url.site,"/Kevin.Caye"))
}

