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
png(file="plot2.png",width=480,height=480)
rm(data)
datetimes <- paste(data_part$Date, data_part$Time)
datetimes <- strptime(datetimes, "%d/%m/%Y %H:%M:%S")
data_part<-cbind(datetimes,data_part)
png(file="plot3.png",width=480,height=480)
plot(data_part$Sub_metering_1~data_part$datetimes, xlab="",type="l",ylab="Energy sub metering")
lines(data_part$Sub_metering_2~data_part$datetimes, type="l", col="red")
lines(data_part$Sub_metering_3~data_part$datetimes, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col=c("black","red","blue"))
dev.off()