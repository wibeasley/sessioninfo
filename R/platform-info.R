
#' Information about the current platform
#'
#' @return A list with elements:
#'   * `version`: the R version string.
#'   * `os`: the OS name in human readable format, see [osname()].
#'   * `system`: CPU, and machine readable OS name, separated by a comma.
#'   * `ui`: the user interface, e.g. `Rgui`, `RTerm`, etc. see `GUI`
#'     in [base::.Platform].
#'   * `language`: The current language setting. The `LANGUAGE` environment
#'     variable, if set, or `(EN)` if unset.
#'   * `collate`: Collation rule, from the current locale.
#'   * `tz`: The current time zone.
#'   * `date`: The current date.
#'
#' @seealso Similar functions and objects in the base packages:
#'   [base::R.version.string], [utils::sessionInfo()], [base::version],
#'   [base::.Platform], [base::Sys.getlocale()], [base::Sys.timezone()].
#'
#' @export
#' @examples
#' platform_info()

platform_info <- function() {
  structure(list(
    version = R.version.string,
    os = os_name(),
    system = version$system,
    ui = .Platform$GUI,
    language = Sys.getenv("LANGUAGE", "(EN)"),
    collate = Sys.getlocale("LC_COLLATE"),
    tz = Sys.timezone(),
    date = format(Sys.Date())
  ), class = "platform_info")
}

#' @export

print.platform_info <- function(x, ...) {
  df <- data.frame(setting = names(x), value = unlist(x), stringsAsFactors = FALSE)
  print(df, right = FALSE, row.names = FALSE)
}

#' @export
#' @importFrom utils capture.output

as.character.platform_info <- function(x, ...) {
  capture.output(print(x))
}
