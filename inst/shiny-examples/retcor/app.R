## Retention time correction

## load the xcmsraw
data(ApplePos)
# xs <- split(xs, rep(1:2, c(3, 7)))[[1]]
xs <- group(xs)


server <- function(input, output) {
  rtcorr <- reactive({
    retcor(xs, family = "gaussian",
           span = input$span,
           smooth = input$smooth,
           missing = input$missing,
           extra = input$extra)
  })
  output$plot1 <- renderPlot({
    rtdevs <- vector("list", 10)
    for (i in 1:10)
      rtdevs[[i]] <- rtcorr()@rt$corrected[[i]] - rtcorr()@rt$raw[[i]]
    devrange <- range(do.call(c, rtdevs))
    rtrange <- range(do.call(c, rtcorr()@rt$raw))

    ## get the well behaved peaks
    groupmat <- xs@groups
    idx <- which(groupmat[,"control"] >= 10-input$missing & groupmat[,"npeaks"] <= 10 + input$extra)
    ## Make the plot
    mytitle <- paste0("Rt Deviation vs. Rt - ",length(idx), " well behaved groups" )

    plot(0, 0, type="n", xlim = rtrange, ylim = devrange,
         main = mytitle , xlab = "Retention Time (s)", ylab = "Retention Time Deviation (s)")
    abline(v=groupmat[idx,"rtmed"], col = alpha("blue",0.3), lty =3)
    for (i in 1:10)
      points(rtcorr()@rt$raw[[i]], rtdevs[[i]], type="l")
  })
}


ui <- fluidPage(
  titlePanel("Retention Time Correction"),

  sidebarLayout(
    sidebarPanel(
      width = 4,
      ## the type of smoothing
      selectInput("smooth", label = h3("Smoohing type"),
                  choices = list("loess" = "loess", "liear" = "linear"),
                  selected = 1),
      ## the degree of smooting
      sliderInput("span", label = h3("Span"), min = 0.01,
                  max = 2, value = 0.2),

      ## missing
      sliderInput("missing", label = h3("Missing"), min = 1,
                  max = 10, value = 1, step = 1),
      ## extra
      sliderInput("extra", label = h3("Extra"), min = 1,
                  max = 10, value = 1, step = 1),
      submitButton("Update View")
    ),

    mainPanel(
      plotOutput("plot1", width = "90%", height = "500px"),
      br(),
      includeMarkdown("retcor.md")
      )
    )
  )

shinyApp(ui = ui, server = server)

