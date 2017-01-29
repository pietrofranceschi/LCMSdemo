## Profile Matrix Shiny demo

applepath <- paste(system.file("data", package = "LCMSdemo"),
                   .Platform$file.sep,
                   "apple_control_neg_005.CDF",
                   sep = "")



server <- function(input, output) {

  raw <- reactive({xcmsRaw(applepath, profstep = input$myStep)})

  output$plot1 <- renderPlot({
    im <- log10(raw()@env$profile+1)
    mI <- max(im, na.rm=TRUE)
    rM <- im
    rM[is.na(rM)] <- 0
    colRamp <- colorRamp(c("#00007F", "blue", "#007FFF", "cyan",
                           "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))
    col <- rgb(colRamp(rM/mI), maxColorValue=255)
    p <- matrix(NA, nrow=nrow(im), ncol=ncol(im), byrow=TRUE)
    p[,] <- col

    layout(matrix(1:2, ncol = 1), widths = 1, heights = c(1,2), respect = FALSE)
    ## top plot
    par(mar = c(0, 4.1, 4.1, 2.1))
    plot(raw()@scantime, sqrt(colSums(raw()@env$profile)),
         type = "l", xaxt="n",
         xlim = input$rtrange, ylab = "TIC")
    ## bottom plot
    par(mar = c(4.1, 4.1, 0, 2.1))
    plot(NA, type="n",
         xlim=input$rtrange,
         ylim=input$mzrange,
         xlab = "rt", ylab = "mz")
    rasterImage(as.raster(p), xleft=1, xright=ncol(p)*(900/1606), ybottom=3000, ytop=50)
  })
}


ui <- fluidPage(
  titlePanel("The xcms Profile Matrix"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("myStep", "profStep:", min = 0.5, max = 10, value = 2,
                  step = 0.3),
      sliderInput("rtrange", "rt range",
                  min = 1, max = 900, value = c(1,900), step = 10),
      sliderInput("mzrange", "mz range",
                  min = 50, max = 3000, value = c(50,3000), step = 10),
      submitButton("Update View"),
      br(),
      tags$hr(),
      h3("Questions for discussion"),
      tags$ol(
        tags$li("What is the meaning of the figure?", style = "color:blue"),
        tags$li("What do the spots in the map represent?", style = "color:blue"),
        tags$li("What is the relation between the matrix and the TIC?", style = "color:blue"),
        tags$li("What will happen if you change step size? Why?", style = "color:blue"),
        tags$li("Can you pick a reasonable value for the step? How can you find it?", style = "color:blue")
      )
    ),

    mainPanel(
      plotOutput("plot1"),
      br(),
      includeMarkdown("profmat.md")
      )
    )
  )




shinyApp(ui = ui, server = server)

