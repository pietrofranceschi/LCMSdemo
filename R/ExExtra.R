ExExtra <- function() {
  #suppressMessages(require(xcms))
  graphics.off()

  cat("\n By now you know the drill: this exercise assesses the effect")
  cat("\n of changing the 'extra' argument in the XCMS alignment function")
  cat("\n The default value is 'extra = 1', leading to the following result")
  cat("\n (here we are using the default value of 'missing = 1').")
  cat("\n ------------------------------------------------------------- ")
  cat("\n")
  cat("\n")
  # load("/home/franceschp/Dropbox/PietroRon/Hinxton/Metabodemo/data/ApplePos.RData")
  data(ApplePos)
  capture.output(xs <- group(xs), file = NULL)

  extra <- 1

  dev.new(width = 15)
  xs2 <- retcor(xs, family = "gaussian",
                extra = extra, plottype = "deviation")

  cat("\n Again we are aligning 10 apple samples at the same time.")
  cat("\n Any apples that behave particularly badly?")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  readline(" Hit return to continue...")

  cat("\n 1) what do you expect when 'extra' is set to another value?")
  cat("\n 2) do you expect more or fewer rt correction groups?")
  cat("\n Try, and see if you were right...")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  readline(" When ready, hit return.")
  while (!is.na(extra)) {
    options(warn = -1)
    extra <- readline("\n Enter a new value for 'extra' (simply hitting return stops): ")
    cat("\n")
    extra <- round(as.numeric(extra))
    if (is.na(extra)) break

    if (extra > 8 | extra < 0) {
      cat("\n Very funny... (but well tried!). Have another go!")
    } else {
      xs2 <- retcor(xs, family = "gaussian",
                    extra = extra, plottype = "deviation")
      cat("\n Showing results for 'extra = ", extra, "'\n")
    }
  }



  ## Following plot shows the number of well-behaved peak groups for
  ## all combinations of extra and missing
  ## Stole some code from the retcor.peakgroups function in xcms
  ngrps <- function(missing, extra) {
    object <- xs
    peakmat <- peaks(object)
    groupmat <- object@groups
    samples <- sampnames(object)
    n <- length(samples)
    classlabel <- as.vector(unclass(sampclass(object)))
    nsamp <- rowSums(groupmat[,match("npeaks",
                                     colnames(groupmat))+unique(classlabel),
                              drop=FALSE])

    idx <- which(nsamp >= n-missing & groupmat[,"npeaks"] <= nsamp + extra)
    if (length(idx) == 0)
      stop("No peak groups found for retention time correction")
    idx <- idx[order(groupmat[idx,"rtmed"])]

    rt <- groupval(object, "maxint", "rt")[idx,, drop=FALSE]
    nrow(rt)
  }

  cat("\n Similar considerations apply for parameters 'missing' and 'extra'.")
  cat("\n If you need to crank up 'extra' quite a bit, maybe you should")
  cat("\n re-check your grouping...")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  readline("\n Hit return to continue...")

  cat("\n In case you are wondering whether the two parameters 'missing'")
  cat("\n and 'extra' can also be changed together: well, they can.")
  cat("\n The following plot shows you the number of groups for each (relevant)")
  cat("\n combination of the two.")

  grps.count <- matrix(0, 9, 9)
  for (missing in 0:8)
    for (extra in 0:8)
      grps.count[missing+1, extra+1] <- ngrps(missing, extra)

  readline("\n Hit return to continue...")
  graphics.off()
  par(pty = "s")
  image(0:8, 0:8, grps.count, xlab = "missing", ylab = "extra",
        main = "Number of retention-time correction groups")
  text(rep(0:8, 9), rep(0:8, each = 9), c(grps.count))

  cat("\n So for this case the biggest differences are obtained by")
  cat("\n increasing 'missing' from 1 to, say, 4. Your mileage may")
  cat("\n and will vary!\n")
}
