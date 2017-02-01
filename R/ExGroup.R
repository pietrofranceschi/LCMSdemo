#' Density based Grouping demo
#'
#' @param bw bandwidth (standard deviation or half width at half maximum)
#' of gaussian smoothing kernel to apply to the peak density chromatogram
#'
#' @param mzwd width of overlapping m/z slices to use for creating peak density
#' chromatograms and grouping peaks across samples
#'
#' @return a plot showing the progress grouping along the m/z scale
#' @export
#'
#' @examples
#'

ExGroup <- function(bw = 6, mzwd = 0.5 ){
  #suppressMessages(require(xcms))
  graphics.off()
  cat("\n This demo shows how the grouping across samples")
  cat("\n is performed.")
  cat("\n Here we see the progress of features grouping")
  cat("\n in a dataset of three samples")
  cat("\n Hit CTRL+C in Linux or browse the menu (Windows, Mac)")
  cat("\n to stop the process.")
  cat("\n In RStudio you can use the tiny stop icon at the top right of ")
  cat("\n the console window")
  cat("\n")
  cat("\n Showing results for bandwidth (bw) = ", bw)
  cat("\n Showing results for mzwd = ", mzwd)
  cat("\n Some Questions to orient the discussion :")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n 1) What do the elements of the plot represent ? ")
  cat("\n 2) Why, sometimes, the three dots are not aligned? ")
  cat("\n 3) Why, sometimes, we do not see three dots (1,2 or even 4) ? ")
  cat("\n 4) Why, sometimes, we have more than one peak? ")
  cat("\n ------------------------------------------------------------- ")
  cat("\n")
  cat("\n... stop the peakpiking and set new values by typing ")
  cat("\n")
  cat("\n ExGroup(bw = ...., mzwd = ....)")
  cat("\n")
  cat("\n What do you expect? Were you right ?")
  cat("\n What are the advantages/disadvatages of each choice ?")
  cat("\n How can I select the OPTIMAL parameters?")
  cat("\n")
  data(xsetDemo)
  #load("/home/franceschp/Dropbox/PietroRon/Hinxton/Metabodemo/data/xsetDemo.RData")
  capture.output(group(mySet, sleep = 1, bw = bw, mzwid = mzwd), file = NULL)
}
