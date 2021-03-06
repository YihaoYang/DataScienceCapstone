---
title: "Next word prediction"
author: "Yihao Yang"
date: "8/29/2020"
output: 
  ioslides_presentation: 
    keep_md: yes
---



## Reproducible pitch

This presentation is for Data Science Capstone Course Project. We will cover the features of the application, a description of the algorithm and instructions of the user interface.

- Github repo please see: <https://github.com/YihaoYang/DataScienceCapstone>.
- Shiny Application please see: <https://yihaoy.shinyapps.io/next_word_prediction/>.

## Shiny App User Interface
The next word prediction app is located at <https://yihaoy.shinyapps.io/next_word_prediction/>. The webpage consists of two tabs. The main tab is named as *App*, where you can enter some texts and the app will try to predict your next word. The second tab *About* leads to the source code and this presentation.

Please give it a try!

## Algorithm for next word prediction -- N-grams generation
Text data were sampled (10%) from a large corpus of blogs, news and twitter posts provided by Coursera-Swiftkey. After cleaning the sampled data, the N-grams were extracted using the **quanteda** package. Moreover, sorted token-frequency data frames were built and saved for the use in prediciton part.

- Please see `MilestoneReport` in the github repo for details of sampling.
- Please see `predNext.R` in the github repo for details of N-grams generation. Unigram, bigram, trigram, quadgram and pengram were built for the application.

## Algorithm for next word prediction -- Prediction strategy
The server first reads in the N-grams built from `predNext.R`. As text is entered by the user, the app splits the text input into ordered words, feed into the longest n-gram possible to find a match. If a match is not detected, the app switches to a shorter n-gram token-frequency data frame for matching until unigram.

- Please see `server.R` in `shinyApp` folder in the github repo for more details.

Thank you!

