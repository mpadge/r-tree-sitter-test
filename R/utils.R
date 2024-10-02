#' Download a tarball
#'
#' @export
dl_tarball <- function (tarball) {

    u_base <- "https://cran.r-project.org/src/contrib/"
    u <- paste0 (u_base, tarball)
    pkg_name <- gsub ("\\_.*$", "", basename (u))
    f <- fs::path (fs::path_temp (), basename (u))
    if (!file.exists (f)) download.file (u, f, quiet = TRUE)
    utils::untar (f, exdir = fs::path_temp ())
    path <- fs::path (fs::path_temp (), pkg_name)
    stopifnot (fs::dir_exists (path))

    return (path)
}
