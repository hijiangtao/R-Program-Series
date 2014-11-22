library(maps)
library(mapproj)
library(quantmod)
source("helpers.R")
counties <- readRDS("data/counties.rds")

shinyServer(function(input, output) {
    dataInput <- reactive({  
        getSymbols(input$symb, src = "yahoo", 
                   from = input$dates[1],
                   to = input$dates[2],
                   auto.assign = FALSE)
    })
    
    finalInput <- reactive({
        if (!input$adjust) return(dataInput())
        adjust(dataInput())
    })
    
    output$plot <- renderPlot({
        data <- finalInput()
        chartSeries(data, theme = chartTheme("white"), 
                    type = "line", log.scale = input$log, TA = NULL)
    })
    
    output$map <- renderPlot({
        data<-switch(input$var,
                     "Percent White"=counties$white,
                     "Percent Black"=counties$black,
                     "Percent Hispanic"=counties$hispanic,
                     "Percent Asian"=counties$asian)
        
        percent_map(var = data, color = "skyblue", legend.title = paste("% ", input$var), max = input$range[2], min = input$range[1])
    })
    
    sliderValues <- reactive({
        data.frame(
            Name = c("The Stock Code you choose", 
                     "The Date range of your stock",
                     "Your displayed variable",
                     "Range of its interests"),
            Value = as.character(c(input$symb, 
                                   paste(input$dates, collapse=' to '),
                                   input$var,
                                   paste(input$range, collapse=' to '))), 
            stringsAsFactors=FALSE)
    }) 
    
    # Show the values using an HTML table
    output$values <- renderTable({
        sliderValues()
    })
})