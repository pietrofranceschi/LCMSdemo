#' ExWarp
#'
#' Demo showing how parametric time warping (ptw) can be used to perform a simple form of
#' retention time alignment
#'
#' @return an interactive demo on runnin gon the console. A web based shiny version of the demo is also available
#' @export
#'
#' @examples
#'
ExWarp <- function(){
  graphics.off()
  cat("\n This demo shows warping based alignment")
  cat("\n for some Total Ion Current LC-MS  traces.")
  cat("\n Here we see the results of the alignment")
  cat("\n for linear warping (degree of the polynomial = 1)")
  #load("/home/franceschp/Dropbox/PietroRon/Hinxton/Metabodemo/data/tics.RData")
  data(tics)
  warped <- ptw(ref = tics_nobl[1,], samp = tics_nobl[2:52,],
                warp.type = "individual", optim.crit = "RMS", init.coef = c(0,1))


  dev.new(width = 11, height = 5)
  par(mfrow = c(2,1), mar=c(1, 4, 2, 1))
  plot(warped$reference[1,], type = "n", xlab = "Time", ylab = "Intensity", main = "Polynomial: degree 1")
  for (i in 1:nrow(warped$sample)){
    lines(warped$sample[i,], col = alpha("orange", 0.3))
  }
  for (i in 1:nrow(warped$warped.sample)){
    lines(warped$warped.sample[i,], col = alpha("blue", 0.3))
  }
  lines(warped$reference[1,], col = alpha("red", 0.8), lwd = 2)
  legend("topright", legend = c("Reference", "Original", "Warped"), lty = 1, col = c("red","orange","blue"))
  plot(warped, what = "function", type = "simultaneous")


  cat("\n Some Questions to orient the discussion :")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  cat("\n 1) What are the two plots displaying ? ")
  cat("\n 2) Is linear alignment satisfactory ? ")
  cat("\n 3) Should we look for something more flexible? ")
  cat("\n 4) How is possible to find the 'optimum'? ")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  cat("\n Now fill in a new degree for the polynomial function,")
  cat("\n and look if you get a better alignment")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  deg <- 1
  while (!is.na(deg)) {
    options(warn = -1)
    deg <- readline("\n Enter a new degree for the polynomial \n (simply hitting return stops): ")
    deg <- trunc(as.numeric(deg))
    if (is.na(deg)) return(invisible())
    if (deg == 0) {
      deg <- 1
    }
    else {
      coeffs <- rep(0, times = deg + 1)
      coeffs[2] <- 1
      warped <- ptw(ref = tics_nobl[1,], samp = tics_nobl[2:52,], warp.type = "individual",
                    optim.crit = "RMS", init.coef = coeffs)
      dev.new(width = 11, height = 5)
      par(mfrow = c(2,1), mar=c(1, 4, 2, 1))
      plot(warped$reference[1,], type = "n", xlab = "Time", ylab = "Intensity",
           main = paste0("Polynomial: degree ",deg))
      for (i in 1:nrow(warped$sample)){
        lines(warped$sample[i,], col = alpha("orange", 0.3))
      }
      for (i in 1:nrow(warped$warped.sample)){
        lines(warped$warped.sample[i,], col = alpha("blue", 0.3))
      }
      lines(warped$reference[1,], col = alpha("red", 0.8), lwd = 2)
      legend("topright", legend = c("Reference", "Original", "Warped"), lty = 1, col = c("red","orange","blue"))
      plot(warped, what = "function", type = "simultaneous")
    }
  }
}

