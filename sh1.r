library(shiny)

ui <- fluidPage(
     titlePanel("This is Demo"),
     sidebarLayout(
	sidebarPanel(
	  textInput("txtInput", "Input the text dsplay")
         ),
         mainPanel(
	   paste("you are entering"),
	   textOutput("txtOutput")
         )
      )
)
server <- shinyServer(function(input.output){
      output$txtOutput <- renderText( {
	paste(input$txtInput)
	})
})

shinyApp(ui=ui,server=server)
