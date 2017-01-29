ExGroup <- function(bw = 6, mzwd = 0.5 ){
  #suppressMessages(require(xcms))
  graphics.off()
  cat("\n This demo shows how the grouping across samples")
  cat("\n is performed.")
  cat("\n Here we see the progress of features grouping")
  cat("\n in a dataset of three samples")
  cat("\n Hit CTRL+C in Linux or browse the menu (Windows Mac)")
  cat("\n to stop the process")
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





ExMissing <- function() {
  #suppressMessages(require(xcms))
  graphics.off()

  cat("\n Here we assess the effect of changing another one of the parameters")
  cat("\n of the XCMS alignment function, 'missing'. The default value is")
  cat("\n 'missing = 1', the value used in producing the following")
  cat("\n familiar-looking figure.")
  cat("\n ------------------------------------------------------------- ")
  cat("\n")

  # load("/home/franceschp/Dropbox/PietroRon/Hinxton/Metabodemo/data/ApplePos.RData")
  data(ApplePos)
  capture.output(xs <- group(xs), file = NULL)

  readline("\n When ready, hit return...")
  cat("\n")
  missing <- 1

  dev.new(width = 15)
  xs2 <- retcor(xs, family = "gaussian",
                missing = missing, plottype = "deviation")

  cat("\n New: we are aligning 10 apple samples at the same time.")
  cat("\n")
  cat("\n 1) Any apples that behave particularly badly?")
  cat("\n 2) Any areas that look suspicious?")
  cat("\n 3) What does the number of RT-Corr-Grp. means?")
  cat("\n ------------------------------------------------------------- ")
  cat("\n")

  readline("\n Hit return to continue...")
  cat("\n")
  cat("\n Again, what do you expect when 'missing' is set to another value?")
  cat("\n In particular, do you expect more or fewer rt correction groups?")
  cat("\n Try, and see if you were right...")
  cat("\n ------------------------------------------------------------- ")
  cat("\n")
  readline(" When ready, hit return.")
  cat("\n")
  while (!is.na(missing)) {
    options(warn = -1)
    missing <-
      readline("\n Enter a new value for 'missing' (simply hitting return stops): ")
    cat("\n")
    missing <- round(as.numeric(missing))
    if (is.na(missing)) break

    if (missing > 8 | missing < 0) {
      cat("\n Very funny... (but well tried!). What are reasonable values?")
      cat("\n")
    } else {
      xs2 <- retcor(xs, family = "gaussian",
                    missing = missing, plottype = "deviation")
      cat("\n Showing results for 'missing = ", missing, "'\n")
    }
  }

  cat("\n So here the conclusion is this:")
  cat("\n But hey, what would YOU say the conclusion is?")
  readline("\n Hit return when you are ready...")
  cat("\n  ------------------------------------------------------------- ")
  cat("\n")
  cat("\n Increasing 'missing' leads to more features, which in general")
  cat("\n is a good thing, especially in areas with few peaks. However,")
  cat("\n you do not really want your alignment to depend on a minority")
  cat("\n of the samples, do you?\n")
}

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
