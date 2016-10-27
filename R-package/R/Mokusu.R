
.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Attaching pacman")
  require("pacman")
  packageStartupMessage("Attaching tidyverse")
  p_load("tidyverse")
  packageStartupMessage("Attaching purrr")
  p_load("purrr")
  packageStartupMessage("Attaching Matrix")
  p_load("Matrix")
  packageStartupMessage("Attaching cayek/associationr")
  p_load_gh("cayek/associationr")
  
}
