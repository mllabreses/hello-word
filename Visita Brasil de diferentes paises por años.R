library(stats)
library(readr)
###install.packages("dplyr", dependencies=TRUE)
###install.packages("sqldf", dependencies=TRUE)
###install.packages("https://cran.r-project.org/src/contrib/nortest_1.0-4.tar.gz", repos=NULL)
library(proto)
library(dplyr)
library(RSQLite)
library(gsubfn)
library(sqldf)
library(nortest)
library(splines)
library(RcmdrMisc)
library(car)
library(sandwich)
library(effects)
library(carData)

setwd("/Users/mariaantoniallabresespina/Documents/Tipologia y ciclo de vida de los datos/Practica 2")
touristData <- read.csv("touristData.csv")

View(touristData)

### Queremos poner 0 en todos los campos Count que contienen NA

touristData$Count[ is.na(touristData$Count)] <- 0

### Quitamos columna Continent que es la primera

touristData <- touristData[,-1]

View(touristData)

### Escogemos solo las columnas Pais, Año y Count acumulado(numero de turistas que visitan Brasil)
### de cada año agrupando por Pais y Año para ver su evolución. Hacemos una repetitiva para cada año
a<- min(touristData$Year)
b<- max(touristData$Year)
i<-a

for (i in a:b)
{seleccion<-paste ("select Country, Year, sum(Count) from touristData where Year=",i," group by Country, Year")

touristporpaisSumaMes <- sqldf(seleccion)
plot(touristporpaisSumaMes[,1],touristporpaisSumaMes[,3],col="blue", lwd=3, xlab="PAIS",ylab="Contador")
Resultado<- paste("Grafica turistas a Brasil anyo",i)
Resultadopdf<- paste(Resultado,".pdf")
Resultadocsv<- paste(Resultado,".csv")

### Guardamos el resultado de la grafica por cada año y todos los paises en un pdf, es un pdf donde salen todas las cantidades de clientes acumuladas 
### por pais, el nombre del pdf que se guarda tiene incluye el año del resultado.

dev.print(pdf, file=Resultadopdf, width=7, height=7,pointsize=12)

### Guardamos el resultado del fichero csv resultante por cada año y todos los paises en un csv, es un csv donde salen todas las cantidades de clientes acumuladas 
### por pais, el nombre del csv que se guarda tiene incluye el año del resultado.
write.csv(touristporpaisSumaMes,Resultadocsv)


DatosAnyo <- read.table(Resultadocsv,header=TRUE, sep=",", na.strings="NA", strip.white=TRUE)

### Dibujamos la Normal de los datos según el csv resultante
densityPlot( ~ X, data=DatosAnyo, bw="SJ", adjust=1, kernel="gaussian")
### Aplicamos test de Shaoiro para cada csv resultante
normalityTest(~X, test="shapiro.test", data=DatosAnyo)}


