#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(sp)
library(ggplot2)

shinyUI(pageWithSidebar(
  headerPanel("Meuse River- Chemical Composition"),
  sidebarPanel(
    selectInput("variable", "metal:",
                list("cadmium" = "cadmium", 
                     "copper" = "copper", 
                     "lead" = "lead",
                     "zinc" = "zinc")),
  ),
  
  mainPanel(
    h3(textOutput("caption")),
    
    plotOutput("HmPlot")
  )
))