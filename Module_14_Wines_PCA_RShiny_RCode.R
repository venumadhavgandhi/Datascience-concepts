#Wines dataset 
library(shiny)
##
input1 <- read.csv(file.choose())
data <- input1[,-1]
pcaObj<-princomp(data, cor = TRUE, scores = TRUE, covmat = NULL)
###
# Define UI for application that draws a histogram
ui <- fluidPage(
#
    titlePanel("PCA Analysis for Wines Dataset"),
    # Sidebar with a slider input for number of pca 
    sidebarLayout(
        sidebarPanel(
            selectInput("Plotype","Please Select the Plot Type",
                        choices=c("Plot","BiPlot","PerceragePlot")),
            sliderInput("clust",
                        "Number of PCA's",
                        min = 1,
                        max = 13,
                        value = 3),
            selectInput("Viw","To View the PCA data",
                        choices=c("No","Yes"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           conditionalPanel(condition = "input.Plotype == 'Plot'",plotOutput("distPlot1")),
           conditionalPanel(condition = "input.Plotype == 'BiPlot'",plotOutput("distPlot2")),           
           conditionalPanel(condition = "input.Plotype == 'PerceragePlot'",plotOutput("distPlot3")),
           tableOutput("sumtable"),
           conditionalPanel(condition = "input.Viw == 'Yes'",tableOutput("sumtable1"))
        )
    )
)

# Define server logic required to draw 
server <- function(input, output) {
    output$distPlot1 <- renderPlot({
        biplot(pcaObj)
    })
    output$distPlot2 <- renderPlot({
        plot(pcaObj)
    })
    output$distPlot3 <- renderPlot({
        plot(cumsum(pcaObj$sdev*pcaObj$sdev)*100/(sum(pcaObj$sdev*pcaObj$sdev)),type="b")
    })
    output$sumtable <- renderTable({
        k= cumsum(pcaObj$sdev*pcaObj$sdev)*100/(sum(pcaObj$sdev*pcaObj$sdev))
        k[1:input$clust]
    })
    output$sumtable1 <- renderTable({
          final1 <- cbind(input1[,1],pcaObj$scores[,1:7])
    })
}
# Run the application 
shinyApp(ui = ui, server = server)
