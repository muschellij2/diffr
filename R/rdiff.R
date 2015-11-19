#' @title Diff 2 R files side by side
#' @description Takes the diff of 2 files and shows comparisons
#' @param file1 First file to take diff (usually original file)
#' @param file2 First file to take diff (usually updated file)
#' @param contextSize Minimum number of lines of context to
#' show around each diff hunk. (default: 3).
#' @param minJumpSize Minimum number of equal lines to collapse
#' into a ``Show N more lines'' link. (default: 10)
#' @param wordWrap By default, code will go all the way to the
#' right margin of the diff. If there are 60 characters of space,
#' character 61 will wrap to the next line, even mid-word.
#' To wrap at word boundaries instead, set this option.
#' @param width passed to \code{\link{createWidget}}
#' @param height passed to \code{\link{createWidget}}
#'
#' @import htmlwidgets
#'
#' @export
rdiff <- function(file1, file2,
                  contextSize = 3,
                  minJumpSize = 10,
                  wordWrap = TRUE,
                  width = NULL, height = NULL) {

  f1 = readLines(file1)
  f1 = paste(f1, collapse = "\n")
  f2 = readLines(file2)
  f2 = paste(f2, collapse = "\n")
  # forward options using x
  x = list(
    message = message,
    contextSize = contextSize,
    minJumpSize = minJumpSize,
    wordWrap = wordWrap,
    file1 = file1,
    file2 = file2,
    f1 = f1,
    f2 = f2
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'rdiff',
    x,
    width = width,
    height = height,
    package = 'rdiff'
  )
}

#' Widget output function for use in Shiny
#'
#' @export
rdiffOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'rdiff', width, height, package = 'rdiff')
}

#' Widget render function for use in Shiny
#'
#' @export
renderRdiff <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, rdiffOutput, env, quoted = TRUE)
}
