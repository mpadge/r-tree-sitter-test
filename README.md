This package is for testing an issue in [Davis Vaughan’s `r-tree-sitter`
package](https://github.com/DavisVaughan/r-tree-sitter). Run the
following code after installing this package (called “test”):

First, download a random tarball into `tempdir()`:

``` r
path <- test::dl_tarball ("odbc_1.5.0.tar.gz")
```

Then run the following code to demonstrate the problem:

``` r
bodies <- test::get_captures (path)
```

    ## Error: Input must point to a valid tree sitter type.

``` r
library (test)
bodies <- test::get_captures (path)
```

    ## Error: Input must point to a valid tree sitter type.

Those both error, and yet work when the full namespace of this package
is loaded:

``` r
pkg_path <- "/<local>/<path>/<to>/r-tree-sitter-test/"
devtools::load_all (pkg_path)
```

    ## ℹ Loading test

``` r
bodies <- test::get_captures (path)
length (bodies)
```

    ## [1] 36
