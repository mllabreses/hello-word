install.packages("streamR")
install.packages("RCurl")
install.packages("ROAuth")
install.packages("RJSONIO")
install.packages("stringr")
install.packages("twitterR")

library(RCurl)
library(RJSONIO)
library(stringr)
library("ROAuth", lib.loc="~/Library/R/3.4/library")
library(twitteR)
library(streamR)

# Declare Twitter API Credentials
api_key <- "************************" # From dev.twitter.com
api_secret <- "****************************************" # From dev.twitter.com
token <- "**************************************************" # From dev.twitter.com
token_secret <- "*********************************************" # From dev.twitter.com

# Create Twitter Connection
setup_twitter_oauth(api_key,api_secret,token,token_secret)
# Run Twitter Search. Format is searchTwitter("Search Terms", n=100, lang="en", geocode="lat,lng", also accepts since and until).

tweets <- searchTwitter("#PuraVida", n=100, lang="en", since="2017-10-01")

# Transform tweets list into a data frame
tweets.df <- twListToDF(tweets)
# Necesitamos definir el directorio de trabajo
setwd("~/Documents/Tipologia y ciclo de vida de los datos/Practica 1")
# Write CSV in R
write.table(tweets.df, file = "tweets.csv", na="",col.names=TRUE, sep=",")
# Esta nueva instrucción comentada seria por si no quisieramos disponer de los titulos de las diferentes columnas.
# write.table(tweets.df, file = "tweets.csv", na="",col.names=FALSE, sep=",")

