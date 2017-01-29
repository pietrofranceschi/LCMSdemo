## So here is in short what retcor does:
## it takes the peaks and groups of the xcmsSet object, and makes a
## list of the rt slot xcmsSet object, where the first element is the
## raw retention time (xraw@scantime) and the second one the corrected
## rt, initially the same as the raw time. Then (assuming only one
## class), it is checked how many of the grouped features are present
## in at least n-missing, and how many groups have not more than
## nsamp+extra peaks. These are the ones used for retention time
## correction, where the median is taken as the "right" retention
## time. Then basically the loess function smooths over the retention
## time differences and that is it. So you average over all
## differences found at a particular retention time.

ExRetcor <- function() {
  #suppressMessages(require(xcms))
  graphics.off()
  cat("\n This demo shows you the effect of changing one of the parameters")
  cat("\n of the XCMS alignment function, retcor. The default value is")
  cat("\n span = 0.2, the value used in producing the following figure.")
  cat("\n Note that also for the grouping default settings have been")
  cat("\n used, which are not necessarily optimal for these data... ")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  # load("/home/franceschp/Dropbox/PietroRon/Hinxton/Metabodemo/data/ApplePos.RData")
  data(ApplePos)
  xs <- split(xs, rep(1:2, c(3, 7)))[[1]]

  capture.output(xs <- group(xs), file = NULL)

  readline("\n When ready, hit return...")

  span <- .2

  dev.new(width = 15)
  capture.output(xs2 <- retcor(xs, family = "gaussian", span = span, plottype = "deviation"),
                 file = NULL)

  cat("\n Here we only look at the first three apple samples.")
  cat("\n Interpret the figure, and discuss the meaning of the")
  cat("\n lines and the points you see. ")
  cat("\n 1) What do the elements of the plot represent ? ")
  cat("\n 2) Does it make sense? ")
  cat("\n 3) Is the retention time correction as big as you would expect ?")
  cat("\n 4) Is it as smooth as you would expect? ")
  cat("\n 5) Do you like what happens on the right? ")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  readline("\n Hit return to continue...")

  cat("\n Now, discuss what you expect when span is set to another value.")
  cat("\n Next you can fill in other values for span, and see if")
  cat("\n you were right...")
  readline("\n When ready, hit return...")
  while (!is.na(span)) {
    options(warn = -1)
    span <- readline("\n Enter a new value for span (simply hitting return stops): ")
    span <- as.numeric(span)
    if (is.na(span)) break

    if (span < 1e-5 | span > 10) {
      cat("\n Are you serious? Perhaps try values between 1e-5 and 10...")
    } else {
      capture.output(xs2 <- retcor(xs, family = "gaussian",
                                   span = span, plottype = "deviation"),
                     file = NULL)
      cat("\n Showing results for 'span = ", span, "'\n")
    }
  }

  cat("\n So what is your conclusion? Which value for span will")
  cat("\n lead to the 'best' alignment? What is the 'best' alignment,")
  cat("\n anyway?")
  cat("\n ------------------------------------------------------------- ")
  cat("\n")

  readline("\n Hit return to continue...")

  cat("\n Here is my partial answer (but feel free to disagree):")
  cat("\n Larger values of span allow for less wild rt corrections.")
  cat("\n A very wriggly correction curve (not very likely")
  cat("\n in the context of chromatography) will lead to very small")
  cat("\n differences in retention time - but peaks may be aligned")
  cat("\n incorrectly!")
  cat("\n")
  invisible()
}

