setClass("myTime")
setAs("character","myTime", function(from) strptime(from, format="%H:%M:%S") )
setClass("myDate")
setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                   colClasses = c("myDate","myTime", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"), 
                   na.strings=c("?"))
dates <- c("minDate" = as.Date("2007-02-01"), "maxDate" = as.Date("2007-02-02"))
data1 <- data[which(data$Date >= dates["minDate"] & data$Date <= dates["maxDate"]),]
data1$Time <- format(data1$Time, format="%H:%M:%S")
data1$Datetime <- strptime(paste(data1$Date, data1$Time), format="%Y-%m-%d %H:%M:%S")

png(filename="plot4.png")
par(mfrow=c(2,2))

plot(data1$Datetime, data1$Global_active_power, type="l", ylab="Global Active Power", xlab="")

plot(data1$Datetime, data1$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(data1$Datetime, data1$Sub_metering_1, type="l", 
     ylab="Energy sub metering", xlab="", col="black")
lines(data1$Datetime, data1$Sub_metering_2, type="l", col="blue")
lines(data1$Datetime, data1$Sub_metering_3, type="l", col="red")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "blue", "red"), lwd = 1, bty = "n", cex = 0.5, inset=-0.05)

plot(data1$Datetime, data1$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")
dev.off()