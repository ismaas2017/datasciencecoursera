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
datetime <- paste(data_part$Date, data_part$Time)
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")
data_part<-cbind(datetime,data_part)
png(file="plot2.png",width=480,height=480)
plot(data_part$Global_active_power~data_part$datetime, xlab="", type = "l",ylab="Global Active Power(kilowatts)")
dev.off()