# next word prediction
library(quanteda)
library(stringi)
library(stringr)
library(tm)
library(dplyr)
library(ngram)

# get sampled file and remove the lines which were too short or too long
sample.filename <- 'final/en_US/sample.txt'
sampled <- readLines(sample.filename) 
charcounts <- nchar(sampled)
sampled <- sampled[charcounts>quantile(charcounts,0.1) &
                   charcounts<quantile(charcounts,0.9)]

badwords<-readLines("http://www.cs.cmu.edu/~biglou/resources/bad-words.txt")
sampled <- removeWords(sampled,badwords)
saveRDS(sampled,file="shinyApp/sampled.RData")

sampled <- readRDS("shinyApp/sampled.RData")
corpus <- tokens(sampled, 
                 remove_punct = TRUE, 
                 remove_symbols = TRUE,
                 remove_numbers = TRUE,
                 remove_url = TRUE,
                 remove_separators = TRUE)

ngram <- function(n) {
   df <- tokens_ngrams(corpus, n=n, concatenator = " ") %>%
         dfm() %>%  colSums() 
   df <- data.frame(names(df),
              df,
              row.names = NULL,
              check.rows = FALSE,
              check.names = FALSE,
              stringsAsFactors = FALSE)
   colnames(df) <- c("token", "n")
   df <- arrange(df,desc(n)) %>% filter(n>1)
   return(df)
}

unigram <- ngram(n=1)
saveRDS(unigram,"shinyAPP/unigram.RData")
bigram <- ngram(n=2)
saveRDS(bigram,"shinyAPP/bigram.RData")
trigram <- ngram(n=3) 
saveRDS(trigram,"shinyAPP/trigram.RData")
quadgram <- ngram(n=4) 
saveRDS(quadgram,"shinyAPP/quadgram.RData")
pengram <- ngram(n=5) 
saveRDS(pengram,"shinyAPP/pengram.RData")


