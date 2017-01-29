## develop reactive plot for extracted ion traces and tics

library(xcms)
library(plotly)

data(raw)

mydf <- data.frame(x = myraw@scantime, y = myraw@tic)


p <- ggplot(mydf, aes(x = x, y =y)) + geom_line()


ggplotly(p)
