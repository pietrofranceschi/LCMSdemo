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

