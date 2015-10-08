#This assumes you have the file household_power_consumption.txt in your local directory

library(data.table)

#clean environment
rm(list=ls())

#read csv file into data table
envdata<-fread("household_power_consumption.txt", na.strings="?", showProgress = FALSE)
envdata<-filter(envdata, as.Date(envdata$Date, "%d/%m/%Y") == '2007-02-01' 
                | as.Date(envdata$Date, "%d/%m/%Y") == '2007-02-02')

envdata$datetime = paste(envdata$Date, envdata$Time, sep=" ")

png(file="plot4.png",width=480,height=480)
par(mfrow = c(2, 2))

with(envdata, {
  plot(strptime(envdata$datetime, "%d/%m/%Y %H:%M:%S"), envdata$Global_active_power,
       type="l", xlab="", ylab="Global active power")
  
  plot(strptime(envdata$datetime, "%d/%m/%Y %H:%M:%S"), envdata$Voltage,
       type="l", xlab="datetime", ylab="Voltage")
  
  plot(strptime(envdata$datetime, "%d/%m/%Y %H:%M:%S"),as.numeric(envdata$Sub_metering_1), type="l", xlab="", ylab="Energy Sub Metering")
  with(envdata, points(strptime(envdata$datetime, "%d/%m/%Y %H:%M:%S"),as.numeric(envdata$Sub_metering_2), col="red", type="l"))
  with(envdata, points(strptime(envdata$datetime, "%d/%m/%Y %H:%M:%S"),as.numeric(envdata$Sub_metering_3), col="blue", type="l"))
  legend("topright", pch = NA, lwd=1, bty="n", cex=0.75, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  plot(strptime(envdata$datetime, "%d/%m/%Y %H:%M:%S"), envdata$Global_reactive_power,
       type="l", xlab="datetime", ylab="Global_reactive_power")
})

dev.off()