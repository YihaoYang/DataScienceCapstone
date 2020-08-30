#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage("Next word prediction",
                   tabPanel("App",
                            fluidPage(
                                  
                                  # Application title
                                  titlePanel("Next word prediction"),
                                  
                                  # Sidebar with a slider input for number of bins
                                  sidebarLayout(
                                        sidebarPanel(
                                              textInput("textInput",
                                                        "Please enter something, I will guess what's your next word!",
                                                        value = "")
                                        ),
                                        
                                        # Show a plot of the generated distribution
                                        mainPanel(
                                              h4("My guess is ..."),
                                              verbatimTextOutput("nextword")
                                        )
                                  )
                            )
                   ),
                   tabPanel("About"
                            ))
    
)
