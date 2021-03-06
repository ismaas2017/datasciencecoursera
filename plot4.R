url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

dest <- "household_power_consumption.zip"

file <- "household_power_consumption.txt"

if (!file.exists(dest)) {

  download.file(url, dest, method="curl")

}

if (!file.exists(file)) {

  unzip(dest)

}


data <- read.csv(file, header = T, sep = ';', na.strings = "?")
data_part <- subset(data, subset = (as.Date(Date, format="%d/%m/%Y") >= "2007-02-01" & as.Date(Date, format="%d/%m/%Y") <= "2007-02-02"))
rm(data)
datetime4 <- paste(data_part$Date, data_part$Time)
datetime4 <- strptime(datetime4, "%d/%m/%Y %H:%M:%S")
data_part<-cbind(datetime4,data_part)
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2))
plot(data_part$Global_active_power~data_part$datetime4, xlab="", type = "l",ylab="Global Active Power")
plot(data_part$Voltage~data_part$datetime4, xlab="datetime", ylab="Voltage", type = "l")
plot(data_part$Sub_metering_1~data_part$datetime4, xlab="",ylab="Energy sub metering",col="black", type = "l")
lines(data_part$Sub_metering_2~data_part$datetime4, col="red")
lines(data_part$Sub_metering_3~data_part$datetime4, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black","red","blue"))
plot(data_part$Global_reactive_power~data_part$datetime4, type = "l",xlab="datetime",ylab="Global_reactive power")
dev.off()