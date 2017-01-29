## Warping based correction

## load the tics
data(tics)


## define the function thet will be reactive ...

myptw <- function(deg){
  coeffs <- rep(0, times = deg + 1)
  coeffs[2] <- 1
  warped <- ptw(ref = tics_nobl[1,], samp = tics_nobl[2:52,], warp.type = "individual",
                optim.crit = "RMS", init.coef = coeffs)
}


server <- function(input, output) {
  warped <- reactive({
    myptw(input$deg)
  })

  output$plot1 <- renderPlot({
    plot(warped()$reference[1,], type = "n", xlab = "Time", ylab = "Intensity", xlim = input$rtrange,
         main = paste0("Polynomial: degree ",input$deg))
    for (i in 1:nrow(warped()$sample)){
      lines(warped()$sample[i,], col = alpha("orange", 0.3))
    }
    for (i in 1:nrow(warped()$warped.sample)){
      lines(warped()$warped.sample[i,], col = alpha("blue", 0.3))
    }
    lines(warped()$reference[1,], col = alpha("red", 0.8), lwd = 2)
    legend("topright", legend = c("Reference", "Original", "Warped"), lty = 1, col = c("red","orange","blue"))

  })
}


ui <- fluidPage(
  titlePanel("Retention Time Correction"),

  sidebarLayout(
    sidebarPanel(
      width = 4,
      ## the degree of warping
      sliderInput("deg", label = h3("Degree of Polynomial"), min = 1,
                  max = 10, step = 1, value = 1),
      sliderInput("rtrange", label = h3("rt range"),
                  min = 60, max = 1200, value = c(100,900), step = 10),
      submitButton("Update View"),
      br()
    ),

    mainPanel(
      plotOutput("plot1", width = "90%", height = "500px"),
      br(),
      includeMarkdown("warping.md")
      )
    )
  )

shinyApp(ui = ui, server = server)

