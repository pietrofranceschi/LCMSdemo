## Matched Filter #################
## snthresh = 4
## step = 0.05

#' Matched Filter peak picking demo
#'
#' Show how xcms performs peak picking by using the matched filter algorithm.
#' Some inline text is presented in the terminal to orient the discussion
#'
#' @param step the step used to slice the m/z range
#' @param snthresh the signal to noise threshold used to confirm that something is a peak
#'
#' @return A plot moitorig the process
#' @export
#'
#' @examples
#'
#'
ExMF <- function(step = 0.5, snthresh = 10) {
  #suppressMessages(require(xcms))
  #graphics.off()
  cat("\n This demo shows how peak picking is performed by Matched Filter.")
  cat("\n Here we see the progress of peak picking")
  cat("\n across the different extracted ion traces.")
  cat("\n Hit CTRL+C in Linux or browse the menu (Windows - Mac - RStudio)")
  cat("\n to stop the process \n")
  cat("\n Showing results for step = ", step)
  cat("\n Showing results for snthresh = ", snthresh, "\n")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n Some Questions to orient the discussion : ")
  cat("\n")
  cat("\n 1) What does the number in the plot title represent? ")
  cat("\n 2) What are the red, black and blue lines? ")
  cat("\n 3) Why the black line is reaching negative values? ")
  cat("\n 4) Why do we sometimes have multiple peaks? ")
  cat("\n 5) What do you expect if one tweaks step and snthresh? ")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n ... stop the peakpiking and set new values by typing ")
  cat("\n")
  cat("\n ExMF(step = ...., snthresh = ....) ")
  cat("\n")
  cat("\n Were you right? ")
  cat("\n")
  #applepath <- "/home/franceschp/Dropbox/PietroRon/Hinxton/Metabodemo/inst/data/apple_control_neg_005.CDF"
  applepath <- paste(system.file("data", package = "LCMSdemo"),
                     .Platform$file.sep,
                     "apple_control_neg_005.CDF",
                     sep = "")

  xcmsSet(applepath, sleep = 1.5,
          step = step, snthresh = snthresh)
}


