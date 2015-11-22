R package for creating code differences in JavaScript based on:

https://github.com/danvk/codediff.js

``` r
library(diffr)
file1 = tempfile()
writeLines("hello, world!\n", con = file1)
file2 = tempfile()
writeLines(paste0(
"hello world?\nI don't get it\n",
paste0(sample(letters, 65, replace = TRUE), collapse = "")), con = file2)
diffr(file1, file2, before = "f1", after = "f2")
```

![](img/diffr-example.png)
