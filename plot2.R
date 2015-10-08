#This assumes you have the file household_power_consumption.txt in your local directory

library(data.table)

#clean environment
rm(list=ls())

#read csv file into data table
envdata<-fread("household_power_consumption.txt", na.strings="?", showProgress = FALSE)
envdata<-filter(envdata, as.Date(envdata$Date, "%d/%m/%Y") == '2007-02-01' 
                | as.Date(envdata$Date, "%d/%m/%Y") == '2007-02-02')

envdata$datetime = paste(envdata$Date, envdata$Time, sep=" ")

with(envdata, plot(strptime(envdata$datetime, "%d/%m/%Y %H:%M:%S"), envdata$Global_active_power,
                   type="l", xlab="", ylab="Global active power (Killowatts)"))

dev.copy(png, filename = 'plot2.png', width = 480, height = 480)
dev.off()