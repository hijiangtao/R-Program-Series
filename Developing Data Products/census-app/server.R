source("helpers.R")
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)

shinyServer(
    function(input,output) {
        output$map <- renderPlot({
            data<-switch(input$var,
                "Percent White"=counties$white,
                "Percent Black"=counties$black,
                "Percent Hispanic"=counties$hispanic,
                "Percent Asian"=counties$asian)
            
            percent_map(var = data, color = "darkgreen", legend.title = paste("% ", input$var), max = input$range[2], min = input$range[1])
        })
    }
) 