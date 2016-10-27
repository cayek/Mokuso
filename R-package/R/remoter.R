#' Title
#'
#' @param server.name 
#'
#' @return
#' @export
#'
#' @examples
ServeRemoter <- function(server.name = "krakenator.imag.fr") {
  cat(paste0('ssh cayek@', 
             server.name,
             ' -L 55556:localhost:55555 \'R -e "remoter::server(port=55555)"\'\n'))
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
ClientRemoter <- function() {
  cat("Are you sure the server is running ? yes or no\n")
  line <- readline()
  if (line != "yes") {
    cat("Use : \n")
    ServeRemoter()
    return()
  }
  cat("To close connection and server : exit(client.only=FALSE)\n")
  remoter::client("localhost", port=55556)
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
ExitRemoter <- function() {
  cat("To close connection and server: exit(client.only=FALSE)\n")
  cat("To close only connection: exit(client.only=TRUE)\n")
}
