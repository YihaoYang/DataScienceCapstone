#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(quanteda)
library(stringr)

# for server.ui 
unigram <- readRDS("unigram.RData")
bigram <- readRDS("bigram.RData")
trigram <- readRDS("trigram.RData")
quadgram <- readRDS("quadgram.RData")
pengram <- readRDS("pengram.RData")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    observe({
        textInput <- input$textInput %>% strsplit(split=' ') %>% unlist()
        
        lenInput <- length(textInput)
        
        prednext <- function(n){
            if (n==1) {
                return (sample(unigram$token,size=1,prob = unigram$n))
            }
            regInput <- paste0('^',paste(tail(textInput,n=n),collapse = ' '),' ')
            df <- if (n==1) {bigram
            } else if (n==2) {trigram
            } else if (n==3) {quadgram
            } else {pengram}
            filter(df,str_detect(token,regInput))$token[1] %>% 
                strsplit(split=" ")  %>% unlist() %>% last()
        }
        
        n <- min(lenInput,4)
        word <- NA
        while (n>=0 & is.na(word)) {
            word <- prednext(n = n)
            n <- n-1
        }
        output$nextword <- reactive(word)
    })
})
