library(shiny)
library(maps)
library(mapproj)
library(quantmod)
source("helpers.R")
counties <- readRDS("data/counties.rds")

shinyUI(fluidPage(
  titlePanel("Simple Visual Sysytem - Designed by Joe"),
  
  fluidRow(
      column(12,
             img(src="banner.png")
      )
  ),
  fluidRow(
      column(6,
             h3("Intro of Stock Part"),
             hr(),
             p("The default Stock Plot is according to the BABA's data from Spe 19th, 2014. ALIBABA GROUP WAS FOUNDED IN 1999 BY 18 PEOPLE LED BY JACK MA, a former English teacher from Hangzhou, China. You can access the data from Yahoo Finance WebPage as well as we do. The default plot-color is darkgreen.")
      ),
      column(6,
             h3("Intro of Census Part"),
             hr(),
             p("This is a sophisticated app that visualizes US Census data. You can have quite different choices to get for the display of the map. I plot it in skyblue, inorder to distinguish the form stock plot, you can replot it in any color if you like in parameter percent_map.")
      )
  ),
  
  sidebarLayout(
    sidebarPanel(
      h4("Stock Part"),
      helpText("Please select a stock as the Plot Data Source. 
        Information from: yahoo finance"),
    
      textInput("symb", "Symbol", "BABA"),
    
      
      helpText("Choose a propriate date range for your stock, the system will modify the range if your inputdate is out of the stock history automatically."),
      
      dateRangeInput("dates", 
        "Date range",
        start = "2014-09-19", 
        end = as.character(Sys.Date())),
   
      actionButton("get", "Get the Stock Data"),
      
      br(),
      br(),
      
      checkboxInput("log", "Plot y axis on log scale", 
        value = FALSE),
      
      checkboxInput("adjust", 
        "Adjust prices for inflation", value = FALSE),
      
      hr(),
      
      h4("Census Part"),
      helpText("Create demographic maps with 
        information from the 2010 US Census."),
      
      selectInput("var", 
                  label = "Choose a variable to display",
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"),
      
      br(),
      
      sliderInput("range", 
                  label = "Range of interest:",
                  min = 0, max = 100, value = c(5, 90)),
      
      hr(),
      
      helpText("* In order to make you feel the parameter you've chosed visuable on the page, I make some print info at the bottom of mainPanel."),
      helpText("* You can scroll your mouse down to there and have a look, enjoy yourself."),
      helpText("* Contact me if you have any problem. My Github Account: hijiangtao, my Weibo Account: hijiangtao.")
    ),
    
    mainPanel(
        plotOutput("plot"),
        plotOutput("map"),
        tableOutput("values")
    )
  )
))