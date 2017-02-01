## View the position of the peaks ...

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


applepath <- paste(system.file("data", package = "LCMSdemo"),
                   .Platform$file.sep,
                   "apple_control_neg_005.CDF",
                   sep = "")



server <- function(input, output,session) {

  ## Reactive "heavy" calculations
  datcw <- reactive({xcmsSet(applepath,
                           method = "centWave",
                           prefilter=c(2,20),
                           snthresh = input$cwsnt,
                           ppm = input$ppm,
                           peakwidth=c(6,40))})

  datmf <- reactive({xcmsSet(applepath,
                             method = "matchedFilter",
                             snthresh = input$mfsnt,
                             step = input$step,
                             fwhm = 6
                             )})

  ## render objects updated only is submit button is pressed
  output$plotpm <- renderPlot({
    layout(matrix(1:2, ncol = 1), widths = 1, heights = c(1,2), respect = FALSE)
    ## top plot
    par(mar = c(0, 4.1, 4.1, 2.1))
    plot(myraw@scantime, sqrt(apply(myraw@env$profile,2,max)),
         type = "l", xaxt="n",
         xlim = input$rtrange_pm, ylab = "BPI")
    ## bottom plot
    par(mar = c(4.1, 4.1, 0, 2.1))
    plot(NA, type="n",
         xlim=input$rtrange_pm,
         ylim=input$mzrange_pm,
         xlab = "rt", ylab = "mz")
    rasterImage(as.raster(p), xleft=1, xright=ncol(p)*(900/1606), ybottom=50, ytop=3000)
  })

  output$plotcw <- renderPlot({
    layout(matrix(1:2, ncol = 1), widths = 1, heights = c(1,2), respect = FALSE)
    ## top plot
    par(mar = c(0, 4.1, 4.1, 2.1))
    plot(myraw@scantime, sqrt(apply(myraw@env$profile,2,max)),
         type = "l", xaxt="n",
         xlim = input$rtrange_cw, ylab = "BPI")
    ## bottom plot
    par(mar = c(4.1, 4.1, 0, 2.1))
    plot(NA, type="n",
         xlim=input$rtrange_cw,
         ylim=input$mzrange_cw,
         xlab = "rt", ylab = "mz")
    rasterImage(as.raster(p), xleft=1, xright=ncol(p)*(900/1606), ybottom=3000, ytop=50)
    points(datcw()@peaks[,"rt"], datcw()@peaks[,"mz"], col = alpha("red",0.3), pch = 19, cex = 0.5)
  })

  output$plotmf <- renderPlot({
    layout(matrix(1:2, ncol = 1), widths = 1, heights = c(1,2), respect = FALSE)
    ## top plot
    par(mar = c(0, 4.1, 4.1, 2.1))
    plot(myraw@scantime, sqrt(apply(myraw@env$profile,2,max)),
         type = "l", xaxt="n",
         xlim = input$rtrange_mf, ylab = "BPI")
    ## bottom plot
    par(mar = c(4.1, 4.1, 0, 2.1))
    plot(NA, type="n",
         xlim=input$rtrange_mf,
         ylim=input$mzrange_mf,
         xlab = "rt", ylab = "mz")
    rasterImage(as.raster(p), xleft=1, xright=ncol(p)*(900/1606), ybottom=3000, ytop=50)
    points(datmf()@peaks[,"rt"], datmf()@peaks[,"mz"], col = alpha("red",0.3), pch = 19, cex = 0.5)
  })

}


ui <- navbarPage("View Peaks",
                 tabPanel("Profile Matrix",
                          sidebarLayout(
                            sidebarPanel(
                              width = 3,
                              sliderInput("rtrange_pm", "rt range",
                                          min = 1, max = 900, value = c(1,900), step = 10),
                              sliderInput("mzrange_pm", "mz range",
                                          min = 50, max = 3000, value = c(50,3000), step = 10),
                              submitButton("Update View")
                            ),
                            mainPanel(
                              plotOutput("plotpm")
                            )
                          )
                 ),
                 tabPanel("Cent Wave",
                          sidebarLayout(
                            sidebarPanel(
                              width = 3,
                              sliderInput("rtrange_cw", "rt range",
                                          min = 1, max = 900, value = c(1,900), step = 10),
                              sliderInput("mzrange_cw", "mz range",
                                          min = 50, max = 3000, value = c(50,3000), step = 10),
                              hr(),
                              sliderInput("ppm", label = "ppm", value = 30, min = 5, max = 300, step = 5),
                              sliderInput("cwsnt", label = "s/n threshold", value = 10, min = 1, max = 20, step = 1),
                              hr(),
                              submitButton("Update View")
                            ),
                            mainPanel(
                              plotOutput("plotcw"),
                              includeMarkdown("peaks.md")
                            )
                          )
                 ),
                 tabPanel("Matched Filter",
                          sidebarLayout(
                            sidebarPanel(
                              width = 3,
                              sliderInput("rtrange_mf", "rt range",
                                          min = 1, max = 900, value = c(1,900), step = 10),
                              sliderInput("mzrange_mf", "mz range",
                                          min = 50, max = 3000, value = c(50,3000), step = 10),
                              hr(),
                              sliderInput("step", label = "step", value = 1, min = 0.5, max = 5, step = 0.5),
                              sliderInput("mfsnt", label = "s/n threshold", value = 10, min = 1, max = 20, step = 1),
                              hr(),
                              submitButton("Update View")
                            ),
                            mainPanel(
                              plotOutput("plotmf"),
                              includeMarkdown("peaks.md")
                            )
                          )
                 )
)


shinyApp(ui = ui, server = server)

