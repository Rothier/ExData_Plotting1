library(dplyr)
# reads dataset
data <- read.table("household_power_consumption.txt", header = T, sep = ";")
# converts Date column do type Date and filters the required dates
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data <- filter(data, Date == "2007-02-01" | Date == "2007-02-02")
# Converts Global_active_power column from factor to numeric
data$Global_active_power <- as.numeric(levels(data$Global_active_power)[data$Global_active_power])
# Constructs the plot and exports it as required png
png("plot1.png", height=480, width=480)
hist(data$Global_active_power,
    freq = T,
    xlab = "Global Active Power (kilowatts)", col = "red",
    main = "Global Active Power")
dev.off()