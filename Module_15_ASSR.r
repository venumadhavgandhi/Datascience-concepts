#Groceries dataset 
#Try different values of support and confidence. 
#Observe the change in number of rules for different support,confidence value
#2) Change the minimum length in apriori algorithm
#3) Visulize the obtained rules using different plots 
library(shiny)
#
library("arules") # Used for building association rules i.e. apriori algorithm
Groceries <- read.csv(file.choose())
#
class(Groceries) # Groceries is in transactions format
#
library("arulesViz") # for visualizing rules
###
# Define UI for application that draws a histogram
ui <- fluidPage(
  #
  titlePanel("Association Rules of Groceries"),
  # 
  sidebarLayout(
    sidebarPanel(
      sliderInput("supt",
                  "Choose the Support",
                  min   = 0.001,
                  max   = 0.005,
                  value = 0.002),
      sliderInput("cnfc",
                  "Choose the Confidence",
                  min = 0.1,
                  max = 0.9,
                  value = 0.6),
      sliderInput("mnln",
                  "Choose the Minimum Length",
                  min = 1,
                  max = 5,
                  value = 2)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("arulesno"),
    )
  )
)

# Define server logic required to draw 
server <- function(input, output) {
#
  output$arulesno <- renderText(
    {
      arules <-apriori(Groceries, parameter = list(support=input$supt,confidence=input$cnfc,minlen=input$mnln))
     }
    )

}
# Run the application 
shinyApp(ui = ui, server = server)
