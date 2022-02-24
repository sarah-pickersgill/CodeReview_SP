#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#Global Environment
library(shiny)
library(ggplot2)
#load data you have here read.csv() or load()

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("boxes",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            radioButtons("times", 
                         "Multiply the y-axis:", 
                         c(1,2,3,4))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot"),br(),
           plotOutput("scatter"),
           textOutput("text")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$boxes + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
    
    output$scatter<-renderPlot({
        
        df<-data.frame(dx = c(1,3,4,5,6,67),
                       dy=c(1,2,3,4,5,6))
        
        df$dy<-df$dy*as.numeric(input$times)
        
        ggplot(data=df, aes(x=dx,y=dy))+
            geom_point()+
            ggtitle("Random scatter")
        
    })
    
    output$text<-renderText({
        
        paste0("We've multiplied our y axis by ", input$times)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
