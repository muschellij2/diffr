#' @title Diff 2 files side by side
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
#' @param before Text to display on file1
#' @param after Text to display on file2
#' @param width passed to \code{\link{createWidget}}
#' @param height passed to \code{\link{createWidget}}
#'
#' @import htmlwidgets
#'
#' @export
#' @examples
#' library(diffr)
#' file1 = tempfile()
#' writeLines("hello, world!\n", con = file1)
#' file2 = tempfile()
#' writeLines(paste0(
#' "hello world?\nI don't get it\n",
#' paste0(sample(letters, 65, replace = TRUE), collapse = "")), con = file2)
#' diffr(file1, file2, before = "f1", after = "f2")
diffr <- function(file1, file2,
                  contextSize = 3,
                  minJumpSize = 10,
                  wordWrap = TRUE,
                  before = file1,
                  after = file2,
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
    file1 = before,
    file2 = after,
    f1 = f1,
    f2 = f2
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'diffr',
    x,
    width = width,
    height = height,
    package = 'diffr'
  )
}

#' Wrapper functions for using diffr in shiny
#'
#' Use \code{diffrOutput} to create a UI element, and \code{renderDiffr}
#' to render the diff.
#'
#' @param outputId Output variable to read from
#' @param width,height The width and height of the diff (see
#'   \code{\link[htmlwidgets]{shinyWidgetOutput}})
#' @param expr An expression that generates a \code{\link{diffr}} object
#' @param env The environment in which to evaluate \code{expr}
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' Widget output function for use in Shiny
#'
#' @export
#' @examples
#' \donttest{
#' library(diffr)
#' library(shiny)
#' file1 = tempfile()
#' writeLines("hello, world!\n", con = file1)
#' file2 = tempfile()
#' writeLines(paste0(
#' "hello world?\nI don't get it\n",
#' paste0(sample(letters, 65, replace = TRUE), collapse = "")), con = file2)
#'
#' ui <- fluidPage(
#'   h1("A diffr demo"),
#'   checkboxInput("wordWrap", "Word Wrap",
#'      value = TRUE),
#'    diffrOutput("exdiff")
#' )
#'
#' server <- function(input, output, session) {
#'   output$exdiff <- renderDiffr({
#'     diffr(file1, file2, wordWrap = input$wordWrap,
#'     before = "f1", after = "f2")
#'   })
#' }
#'
#' shinyApp(ui, server)
#' }
diffrOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'diffr', width, height, package = 'diffr')
}

#' @rdname diffrOutput
#' @export
renderDiffr <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, diffrOutput, env, quoted = TRUE)
}
