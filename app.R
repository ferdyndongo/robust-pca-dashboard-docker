# This is a Shiny web application for Robust Principal Component Analysis. 
# You can run the application by clicking the 'Run App' button above if you are using Rstudio.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
options(shiny.maxRequestSize = 800 * 1024^2)
library(SHINYCARET)
ui <- shinydashboard::dashboardPage(header=shinydashboard::dashboardHeader(title = "ROBUST PCA", disable = FALSE),
                                    sidebar=shinydashboard::dashboardSidebar(SHINYCARET:::fileUi(id = "source")),
                                    body=shinydashboard::dashboardBody(shiny::uiOutput("dataUi"))
                                    )

server <- function(input, output, session){
  
  rawdata <- SHINYCARET:::fileServer(id = "source")
  data <- shiny::reactive({
    if(!is.null(rawdata())){
      if(inherits(rawdata(),"data.frame") && apply(X = rawdata(),MARGIN = 2,function(col){!is.raw(col[[1]])}) %>% all()){
        rawdata()
      }else{
        shiny::showNotification(paste0("ERROR !!! :"," UPLOADED DATA ARE NOT DATASET!!!"),duration = NULL,closeButton = TRUE,type = "error")
        return(NULL)
      }
    }
  })
  
  output$dataUi <- shiny::renderUI({
    shiny::req(data())
    shiny::tagList(
      SHINYCARET:::dataVizUi("source"),
      SHINYCARET:::pcaInputUi(id = "source"),
      SHINYCARET:::RobustPCAUi(id="source")
    )
  })
  SHINYCARET:::dataVizOutput("source",data)
  SHINYCARET:::numVarServer(id = "source", data)
  SHINYCARET:::RobustPCAServer("source",data)
  
}

# Run the application 
shinyApp(ui = ui, server = server)
