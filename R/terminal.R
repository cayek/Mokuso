
SendToTerminal <- function(terminal.name) {
  selected.code <- rstudioapi::getActiveDocumentContext()$selection[[1]]$text
  # print(selected.code)
  # escape char interpreted by bash
  selected.code <- gsub("\\\\", "\\\\\\\\", selected.code)
  selected.code <- gsub("\"", "\\\\\"", selected.code)
  selected.code <- gsub("`", "\\\\`", selected.code)
  selected.code <- gsub("\\$", "\\\\\\$", selected.code)
  selected.code <- gsub("\\!", "\\\\\\!", selected.code)
  # to escape \n by R
  selected.code <- strsplit(selected.code, "\n")[[1]]
  # print(selected.code)
  for (s in selected.code) {
    script <- paste0('WID=`xdotool search --name "',terminal.name,'" | head -1` ;',
                     #'xdotool windowactivate --sync $WID;',
                     'xdotool type --window $WID  "', s ,'" ;',
                     'xdotool key --window $WID --delay 100 "Return" ;' )
    # cat(script)
    system(script)
  }
}


#' open R on server
#'
#'
#' @export
OpenServer <- function(server.name = "patator") {
  
  workingProject <- paste0("/home/cayek/Renv/", basename(rstudioapi::getActiveProject()))
  
  system(paste0("xfce4-terminal --hold -e \"ssh " ,
               Sys.info()[["user"]],"@",server.name,
               " -t ",
               "\\\"",
               "cd ", workingProject,"; ",
               "git pull", "; ",
               "R",
               "\\\" \"",
               " -T \"",server.name," : ",workingProject,"\""))

}

#' open MRO
#'
#'
#' @export
OpenMRO <- function() {
  
  workingProject <- rstudioapi::getActiveProject()
  
  system(paste("xfce4-terminal --hold -e '" ,
               ' bash -c " cd',workingProject,
               ";",
               '/usr/lib64/MRO-3.2.3/R-3.2.3/lib64/R/bin/R "',
               "'",
               "-T 'MRO : ",workingProject,"'"
  ))
  
}

#' send code to MRO
#'
#'
#' @export
SendToMRO <- function() {
  workingProject <- rstudioapi::getActiveProject()
  terminal.name <- paste("MRO : ", workingProject)
  SendToTerminal(terminal.name)
}

#' send code to patator
#'
#'
#' @export
SendToPatator <- function() {
  workingProject <- paste0("/home/cayek/Renv/", basename(rstudioapi::getActiveProject()))
  terminal.name <- paste0("patator : ", workingProject)
  SendToTerminal(terminal.name)
}
