rm(list = ls())

data_raw <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
data_raw$Date <- as.Date(data_raw$Date, format = "%d/%m/%Y")

data_desired <- subset(data_raw, data_raw$Date == "2007-02-01" | data_raw$Date == "2007-02-02")





par(mfrow=c(2,2))    # set the plotting area into a 1*2 array
par(mar=c(3,5,3,1))


data_desired$weekday <- factor(weekdays(data_desired$Date))
data_desired$Time2 <- as.POSIXct(strptime(paste(data_desired$Date, data_desired$Time, sep = " "),format = "%Y-%m-%d %H:%M:%S"))

plot(data_desired$Time2, data_desired$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

plot(data_desired$Time2, as.numeric(data_desired$Voltage), type = "l", ylab = "Voltage", xlab = "datetime")

plot(data_desired$Time2, as.numeric(data_desired$Sub_metering_1), type = "l", col = "black", xlab = "", ylab = "Energy sub meeting")
lines(data_desired$Time2, as.numeric(data_desired$Sub_metering_2), col = "red")
lines(data_desired$Time2, as.numeric(data_desired$Sub_metering_3), col = "blue")

legend("topright", col=c("black", "red", "blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, y.intersp = 0.1, x.intersp = 1, cex = 0.2)

plot(data_desired$Time2, as.numeric(data_desired$Global_reactive_power), type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.copy(png, file="plot4.png")
dev.off()