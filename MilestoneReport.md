---
title: "Milestone Report for Data Science Capstone"
author: "Yihao Yang"
date: "8/22/2020"
output: 
  html_document: 
    keep_md: yes
---



## Dataset Overview

This section is for summaries of the three files including word counts, line counts and basic data tables.

```r
library(ngram)
filenames <- paste0('final/en_US/en_US.',c('blogs.txt','news.txt','twitter.txt'))
filesizes <- as.numeric(sapply(filenames, file.info)['size',])
textfiles <- sapply(filenames,readLines)
wordcounts <- sapply(textfiles,wordcount)
linecounts <- sapply(textfiles,length)
charcounts <- sapply(sapply(textfiles,nchar), sum)
data.frame(wordcounts,linecounts,charcounts,filesizes)
```

```
##                               wordcounts linecounts charcounts filesizes
## final/en_US/en_US.blogs.txt     37334131     899288  206824505 210160014
## final/en_US/en_US.news.txt      34372530    1010242  203223159 205811889
## final/en_US/en_US.twitter.txt   30373543    2360148  162096031 167105338
```

## Sampling

This section is to create a separate sub-sample dataset by reading in a random subset (1%) of the original data and writing it out to a separate file. 

```r
sample.filename <- 'final/en_US/sample.txt'
if (!file.exists(sample.filename)) {
      set.seed(53)
      sampled <- c()
      for (i in 1:3){
            sampled <- c(sampled,textfiles[[i]][as.logical(rbinom(linecounts[i],1,0.01))])
      }
      writeLines(sampled,sample.filename)
} else {
     sampled <- readLines(sample.filename) 
}
rm(textfiles)
```

## Cleaning data
This section is to clean the sampled data.

```r
library(tm)
library(dplyr)

badwords<-readLines("http://www.cs.cmu.edu/~biglou/resources/bad-words.txt")

corpus <- Corpus(VectorSource(sampled)) %>% 
      tm_map(removeNumbers) %>%
      tm_map(tolower) %>%
      tm_map(removePunctuation) %>%
      tm_map(removeWords,stopwords("en")) %>%
      tm_map(removeWords,badwords) %>%
      tm_map(removeWords,c("\'","\"")) %>%
      tm_map(stripWhitespace) 
```



## Exploratary Data Analysis

This section is to further explore the dataset to illustrate features of the data.

```r
library(ggplot2)
texts <- data.frame(texts = get('content',corpus))$texts

unigrams <- ngram(paste(texts,collapse = ''),n=1)

df <- head(get.phrasetable(unigrams),n=20)
df$ngrams <- factor(df$ngrams, levels = df$ngrams)
ggplot(data = df, aes(ngrams,freq)) + 
  geom_bar(stat = "identity") + 
  theme(text = element_text(size=18)) +
  ggtitle("20 most frequent unigrams") + coord_flip() 

bigrams <- ngram(paste(texts,collapse = ''),n=2)

df <- head(get.phrasetable(bigrams),n=20)
df$ngrams <- factor(df$ngrams, levels = df$ngrams)
ggplot(data = df, aes(ngrams,freq)) + 
  geom_bar(stat = "identity") + 
  theme(text = element_text(size=18)) +
  ggtitle("20 most frequent bigrams") + coord_flip() 

trigrams <- ngram(paste(texts,collapse = ''),n=3)

df <- head(get.phrasetable(trigrams),n=20)
df$ngrams <- factor(df$ngrams, levels = df$ngrams)
ggplot(data = df, aes(ngrams,freq)) + 
  geom_bar(stat = "identity") + 
  theme(text = element_text(size=18)) +
  ggtitle("20 most frequent trigrams") + coord_flip() 
```

<img src="MilestoneReport_files/figure-html/figures-side-1.png" width="33%" /><img src="MilestoneReport_files/figure-html/figures-side-2.png" width="33%" /><img src="MilestoneReport_files/figure-html/figures-side-3.png" width="33%" />


