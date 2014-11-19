# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {
    ##reactive can save the results when you first request the function
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
        data <- finalInput(),
        chartSeries(data, theme = chartTheme("white"), 
                    type = "line", log.scale = input$log, TA = NULL)
    })
})