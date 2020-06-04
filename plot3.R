library(dplyr)
library(lubridate)
# reads dataset
data <- read.table("household_power_consumption.txt", header = T, sep = ";")
# converts Date column do type Date and filters the required dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")
# Joins Date and Time column into the latter and deleting the former, 
# then converts the result into a Datetime class column
data$Time <- paste(data$Date, data$Time)
data <- data[,-1]
data$Time <- as_datetime(data$Time, format = "%Y-%m-%d %H:%M:%S")
# Converts all three submetering columns from factor to numeric
data$Sub_metering_1 <- as.numeric(levels(data$Sub_metering_1)[data$Sub_metering_1])
data$Sub_metering_2 <- as.numeric(levels(data$Sub_metering_2)[data$Sub_metering_2])
data$Sub_metering_3 <- as.numeric(levels(data$Sub_metering_3)[data$Sub_metering_3])
# Constructs the plot and exports it as required png
png("plot3.png", height=480, width=480)
plot(data$Sub_metering_1 ~ data$Time, type="l")
lines(data$Sub_metering_2 ~ data$Time, col="red")
lines(data$Sub_metering_3 ~ data$Time, col="blue")
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1)
dev.off()