## Extracted ion traces

## load the xcmsraw
data(xrawDemo)

server <- function(input, output) {
  output$plot1 <- renderPlotly({
    mz <- as.numeric(input$mz)
    delta <- as.numeric(input$delta)
    myEIC  <- getEIC(myraw, mzrange = matrix(c(mzmin = mz-delta,
                                               mzmax = mz+delta),
                                             ncol = 2))
    myEIC1 <- as.data.frame(myEIC@eic[[1]][[1]])
    p <- ggplot(myEIC1, aes(x = rt, y = intensity)) + geom_line() +
      ggtitle(paste0("EIC of ","mz ", input$mz))
    ggplotly(p)
    p
  })
}


ui <- fluidPage(
  titlePanel("Extracting ion traces"),

  sidebarLayout(
    sidebarPanel(
      width = 4,
      ## the mass for the EIC
      textInput("mz",
                   label = h4("m/z"),
                   value = "463", width = "50%"
                   ),
      ## the tolerance
      textInput("delta",
                   label = h4("Tolerance"),
                   value = "0.5", width = "50%"
      ),
      submitButton("Update View"),
      br()
    ),

    mainPanel(
      plotlyOutput("plot1", width = "90%", height = "500px"),
      br(),
      includeMarkdown("eics.md")
      )
    )
  )




shinyApp(ui = ui, server = server)

