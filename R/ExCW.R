
#' Matched Filter peak picking demo
#'
#' Show how xcms performs peak picking by using the CentWave algorithm.
#' Some inline text is presented in the terminal to orient the discussion
#'
#' @param ppm the ppm tolerance used to identify "interesting" mass traces
#' @param snthresh snthresh the signal to noise threshold used to confirm that something is a peak
#'
#' @return A plot moitorig the process
#' @export
#'
#' @examples
#'
ExCW <- function(ppm = 20, snthresh =  10) {
  #suppressMessages(require(xcms))
  graphics.off()
  cat("\n This demo shows how peak picking is performed by CentWave.")
  cat("\n As before, we see the progress of peak picking")
  cat("\n across the different regions of interest")
  cat("\n Hit CTRL+C in Linux or browse the menu (Windows, Mac, RStudio)")
  cat("\n to stop the process. \n")
  cat("\n Showing results for ppm = ", ppm)
  cat("\n Showing results for s/n ratio = ", snthresh, "\n")
  cat("\n -------------------------------------------------------------  ")
  cat("\n")
  cat("\n Some Questions to orient the discussion : ")
  cat("\n")
  cat("\n 1) What do the three plots represent ? ")
  cat("\n 2) What do the elements of each plot represent? ")
  cat("\n 3) What do you expect if one tweaks ppm and snthresh ? ")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n ... stop the peakpiking and set new values by typing ")
  cat("\n")
  cat("\n ExCW(ppm = ...., snthresh = ....) ")
  cat("\n")
  cat("\n Were you right ? ")
  cat("\n")
  applepath <- paste(system.file("data", package = "LCMSdemo"),
                     .Platform$file.sep,
                     "apple_control_neg_005.CDF",
                     sep = "")

  capture.output(xs <- xcmsSet(applepath, sleep = 2,
                               method = "centWave", prefilter=c(2,20),
                               snthresh = snthresh, ppm = ppm, peakwidth=c(6,40)), file = NULL)
}


