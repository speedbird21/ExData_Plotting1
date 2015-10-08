#This assumes you have the file household_power_consumption.txt in your local directory

library(data.table)

#clean environment
rm(list=ls())

#read csv file into data table
envdata<-fread("household_power_consumption.txt", na.strings="?", showProgress = FALSE)
envdata<-filter(envdata, as.Date(envdata$Date, "%d/%m/%Y") == '2007-02-01' 
         | as.Date(envdata$Date, "%d/%m/%Y") == '2007-02-02')

envdata$datetime = paste(envdata$Date, envdata$Time, sep=" ")

hist(as.numeric(envdata$Global_active_power), 
     col="red", main="Global active power", xlab="Global active power (Killowatts)")

dev.copy(png, filename = 'plot1.png', width = 480, height = 480)
dev.off()