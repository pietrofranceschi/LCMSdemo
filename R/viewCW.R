
#' Visualize the peaks - centWave
#'
#' This demo shows the distribution of the peaks in the rt/mz plane, when the paek picking is performed
#' with centWave. This is the terminal version of the shiny app with the same name.
#'
#' @param ppm the ppm tolerance used to identify "interesting" mass traces
#' @param snthresh snthresh the signal to noise threshold used to confirm that something is a peak
#'
#' @return the mapping of the peaks
#' @export
#'
#' @examples
#'
viewCW <- function(ppm = 10, snthresh = 10) {
  #suppressMessages(require(xcms))
  #suppressMessages(require(scales))
  cat("\n This demo shows the position of the peaks on the profile matrix")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n CW peakpiking: ppm = ", ppm, " snthresh = ", snthresh)
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n Some Questions to orient the discussion : ")
  cat("\n")
  cat("\n 1) Are the red dots were you would expect them? ")
  cat("\n 2) Do you see obvious errors? ")
  cat("\n 3) What do you expect if one tweaks ppm and snthresh ? ")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n viewCW(ppm = ...., snthresh = ....) ")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n Were you right ? ")
  cat("\n")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n Now, run viewMF() and viewCW() with similar settings ... ")
  cat("\n")
  cat("\n Can you say something on the differences between CW and MF ? ")
  cat("\n")
  applepath <- paste(system.file("data", package = "LCMSdemo"),
                     .Platform$file.sep,
                     "apple_control_neg_005.CDF",
                     sep = "")

  capture.output(xs <- xcmsSet(applepath,
                               method = "centWave", prefilter=c(2,20),
                               snthresh = snthresh, ppm = ppm, peakwidth=c(6,40)), file = NULL)
  data("xrawDemo")
  profStep(myraw) <- 2

  im <- log(myraw@env$profile+1)
  mI <- max(im, na.rm=TRUE)
  rM <- im
  rM[is.na(rM)] <- 0
  colRamp <- colorRamp(c("white", "blue"))
  col <- rgb(colRamp(rM/mI), maxColorValue=255)
  p <- matrix(NA, nrow=nrow(im), ncol=ncol(im), byrow=TRUE)
  p[,] <- col
  dev.new(width = 11, height = 5)
  plot(NA, type="n", xlim=c(1, 900), ylim=c(1, 3000),
       main = paste0("ppm = ",ppm, " snthresh = ", snthresh), xlab = "rt", ylab = "mz")
  rasterImage(as.raster(p), xleft=1, xright=ncol(p)*(900/1606), ybottom=3000, ytop=50)
  points(xs@peaks[,"rt"],xs@peaks[,"mz"], col = alpha("red",0.3), pch = 19, cex = 0.5)

}

