library(stats)
library(readr)
###install.packages("dplyr", dependencies=TRUE)
###install.packages("sqldf", dependencies=TRUE)
library(dplyr)
library(RSQLite)
library(sqldf)

setwd("/Users/mariaantoniallabresespina/Documents/Tipologia y ciclo de vida de los datos/Practica 2")
touristData <- read.csv("touristData.csv")

View(touristData)

### Queremos poner 0 en todos los campos Count que contienen NA

touristData$Count[ is.na(touristData$Count)] <- 0

### Escogemos solo las columnas Month, Count sumadas por cada mes

touristSuma <- sqldf("select Month, sum(Count) from touristData group by Month")

View (touristSuma)

touristSuma$Month[touristSuma$Month == "janeiro"] <- 1
touristSuma$Month[touristSuma$Month == "fevereiro"] <- 2
touristSuma$Month[touristSuma$Month == "abril"] <- 4
touristSuma$Month[touristSuma$Month == "maio"] <- 5
touristSuma$Month[touristSuma$Month == "junho"] <- 6
touristSuma$Month[touristSuma$Month == "julho"] <- 7
touristSuma$Month[touristSuma$Month == "agosto"] <- 8
touristSuma$Month[touristSuma$Month == "setembro"] <- 9
touristSuma$Month[touristSuma$Month == "outubro"] <- 10
touristSuma$Month[touristSuma$Month == "novembro"] <- 11
touristSuma$Month[touristSuma$Month == "dezembro"] <- 12
touristSuma$Month[touristSuma$Month >= "mar"] <- 3

plot(touristSuma[,1],touristSuma[,2],col="blue", lwd=3, xlab="MESES",ylab="Número Visitas")
