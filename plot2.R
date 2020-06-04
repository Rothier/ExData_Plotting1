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
# Converts Global_active_power column from factor to numeric
data$Global_active_power <- as.numeric(levels(data$Global_active_power)[data$Global_active_power])
# Constructs the plot and exports it as required png
png("plot2.png", height=480, width=480)
plot(data$Global_active_power ~ data$Time, 
     ylab = "Global Active Power (kilowatts)",
     xlab = "",
     type="l")
dev.off()