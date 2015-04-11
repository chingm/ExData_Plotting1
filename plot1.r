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

par(mfrow=c(1,1))
png(filename="plot1.png")
hist(data1$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()