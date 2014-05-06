# Exploratory Data Analysis
# Course Project 1
# plot4.R

# load data from file
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep=";", na.strings="?", 
                   colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# create single DateTime variable from Date and Time source variables
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S", tz = "UTC")

# convert source character Date variable to real Date type
data$Date = as.Date(data$Date, "%d/%m/%Y")

# filter out data which is only needed
startDate <- as.Date("2007-02-01", "%Y-%m-%d")
endDate <- as.Date("2007-02-02", "%Y-%m-%d")
data = data[data$Date >= startDate & data$Date <= endDate,
            c("DateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
              "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

# draw plot 4
# create grid for plots 2x2
par(mfrow = c(2, 2))

# draw subplot 1
plot(data$DateTime, data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power")

# draw subplot 2
plot(data$DateTime, data$Voltage, type="l", xlab = "datetime", ylab = "Voltage")

# draw subplot 3
plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# draw subplot 2
plot(data$DateTime, data$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power")

# save plot to "plot4.png"
dev.copy(png, file = "plot4.png", height = 800, width = 1000)
dev.off()