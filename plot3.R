

# set working directory to the folder with the 
# household_power_consumption.txt!!

# read in the data, skip lines that we don't need

power <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", skip = 60000, nrows = 10000)


# rename the columns 

header <- read.table(file = "household_power_consumption.txt", sep = ";",  nrows = 1 )
colnames(power) <- unlist(header)

# Convert to real date

power$newDate <- as.Date(power$Date, format = "%d/%m/%Y")

# subset only data for "2007-02-01" or "2007-02-02"

power <- power[format.Date(power$newDate, "%Y-%m-%d") == "2007-02-01" | format.Date(power$newDate, "%Y-%m-%d") == "2007-02-02", ]

# paste date and time

power$newDateTime <- as.character(paste(power$Date, power$Time))
power$newDateTime <- as.POSIXct(power$newDateTime, format = "%d/%m/%Y %H:%M:%S")


# generate plot 3

png(filename="plot3.png",  width = 480, height = 480, units = "px")
x <- power$newDateTime
y1 <- power$Sub_metering_1
y2 <- power$Sub_metering_2
y3 <- power$Sub_metering_3

plot(x, y1, type = "n", ylab = "Energy sub metering", xlab = "")
lines(x, y1, col = "black")
lines(x, y2, col = "red")
lines(x, y3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=c(1,1), cex=0.8)

dev.off()
