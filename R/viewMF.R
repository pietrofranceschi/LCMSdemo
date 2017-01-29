#' viewMF
#'
#' This demo shows the distribution of the peaks in the rt/mz plane, when the paek picking is performed
#' with Matched Filter. This is the terminal version of the shiny app with the same name.
#'
#' @param step the step used to generate the profile matrix
#' @param snthresh snthresh the signal to noise threshold used to confirm that something is a peak
#'
#' @return a plot showing the ditribution of the peaks in the mz/rt plane
#' @export
#'
#' @examples
#'
viewMF <- function(step = 0.5, snthresh = 10) {
  cat("\n This demo shows the position of the peaks on the profile matrix")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n MF peakpiking: step = ", step, " snthresh = ", snthresh)
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n Some Questions to orient the discussion : ")
  cat("\n")
  cat("\n 1) Are the red dots were you would expect them? ")
  cat("\n 2) Do you see obvious errors? ")
  cat("\n 3) What do you expect if one tweaks step and snthresh ? ")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n viewMF(step = ...., snthresh = ....) ")
  cat("\n")
  cat("\n -------------------------------------------------------------")
  cat("\n")
  cat("\n Were you right ? ")
  cat("\n")
  applepath <- paste(system.file("data", package = "Metabodemo"),
                     .Platform$file.sep,
                     "apple_control_neg_005.CDF",
                     sep = "")

  capture.output(xs <- xcmsSet(applepath, step = step, snthresh = snthresh), file = NULL)
  raw <- xcmsRaw(applepath, profstep = 2)

  im <- log(raw@env$profile+1)
  mI <- max(im, na.rm=TRUE)
  rM <- im
  rM[is.na(rM)] <- 0
  colRamp <- colorRamp(c("white", "blue"))
  col <- rgb(colRamp(rM/mI), maxColorValue=255)
  p <- matrix(NA, nrow=nrow(im), ncol=ncol(im), byrow=TRUE)
  p[,] <- col
  dev.new(width = 11, height = 5)
  plot(NA, type="n", xlim=c(1, 900), ylim=c(1, 3000),
       main = paste0("step = ",step, " snthresh = ", snthresh),xlab = "rt", ylab = "mz")
  rasterImage(as.raster(p), xleft=1, xright=ncol(p)*(900/1606), ybottom=3000, ytop=50)
  points(xs@peaks[,"rt"],xs@peaks[,"mz"], col = alpha("red",0.3), pch = 19, cex = 0.5)

}
