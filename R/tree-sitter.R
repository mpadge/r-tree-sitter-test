QUERY_FUNCTIONS <- r"(
  (binary_operator
      lhs: (identifier) @name
      operator: "<-"
      rhs: (function_definition) @fn
  )
)"
QUERY_FUNCTIONS <- treesitter::query (treesitter.r::language (), QUERY_FUNCTIONS)

#' Get treesitter captures
#'
#' @export
get_captures <- function (path) {
    path_r <- fs::path (path, "R")
    paths <- fs::dir_ls (path_r, regexp = "\\.(r|R)$")
    paths <- as.character (paths)

    parser <- treesitter::parser (treesitter.r::language ())

    lapply (paths, function (path) {
        text <- brio::read_file (path)

        tree <- treesitter::parser_parse (parser, text)
        node <- treesitter::tree_root_node (tree)

        treesitter::query_captures (QUERY_FUNCTIONS, node)
    })
}

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
