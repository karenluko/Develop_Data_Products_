library(shiny)
library(sp)
library(ggplot2)

data("meuse")
data_Hm <- meuse
data_Hm[-13] <- lapply(data_Hm[-13], function(x) {
  if(!is.numeric(x)) as.numeric(x) else x
})
data_Hm$landuse<-as.character(data_Hm$landuse)
data_Hm$crops <- NA
data_Hm$crops[which(data_Hm$landuse=="Ab")]<- "Sugar beatsm"
data_Hm$crops[which(data_Hm$landuse=="Ag")]<- "Small grains"
data_Hm$crops[which(data_Hm$landuse=="Am")]<- "Maize"
data_Hm$crops[which(data_Hm$landuse=="Fh")]<- "Fruit tree"
data_Hm$crops[which(data_Hm$landuse=="Fw")]<- "Fruit tree"
data_Hm<-data_Hm[which(!is.na(data_Hm$crops)),]

# Define server logic required to plot various variables against lanuse
shinyServer(function(input, output) {
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    paste("Selected metal:",input$variable, sep = " ")
  })
  
  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })
  
  # Generate a plot of the requested variable against landuse 
  output$HmPlot <- renderPlot({
    g<-ggplot(aes(x=data_Hm$om), data=data_Hm)
    g+geom_point(aes_string(y=input$variable))+ #input$variable is a string, so that, it must be passed to aes_string
      geom_abline(lty=3)+  
      facet_grid(.~crops)+
      labs(y="Metal concentration (mg/kg)", x="Organic matter (%)", title = "Heavy metal concentration as function of organic matter in topsoils of the Meuse River Flood plain subject to different crops")+
      theme_bw(base_size = 12)
  })
})