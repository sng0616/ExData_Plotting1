library(graphics)

#Define headers
header <- read.table("household_power_consumption.txt", nrows = 1, sep = ";")
#Read table with all column values read as characters
HHPwConsump <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", skip = 1, colClasses = rep("character", 9))
#Set headers as column names
colnames(HHPwConsump) <- unlist(header)
#Find and subset relevant data
HHPwConsump_sub <- HHPwConsump[which(HHPwConsump$Date == "1/2/2007" | HHPwConsump$Date == "2/2/2007"), ]
#For columns that should be numeric, replace "?" (for missing data) with NA
HHPwConsump_sub[, 3:9][HHPwConsump_sub[, 3:9] == "?"] <- NA
#For columns that should be numeric, set their value type to numeric
HHPwConsump_sub[, 3:9] <- as.numeric(unlist(HHPwConsump_sub[, 3:9]))

#Concatenate Date and Time columns for simplicity
DateTime <- paste(HHPwConsump_sub$Date, HHPwConsump_sub$Time, sep = " ")
#Change Date/Time data from character representation to a POSIXlt object
DataTimes <- strptime(DateTime, "%d/%m/%Y %H:%M:%S")

#Create png file of the plot
png(filename = "plot4.png", width = 480, height = 480, units = "px")
#Set graphical parameters such that more than one graph can appear in a plot
par(mfcol = c(2, 2))
#Plot 2
plot(DataTimes, HHPwConsump_sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
#Plot 3
plot(DataTimes, HHPwConsump_sub$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "", col = "black")
lines(DataTimes, HHPwConsump_sub$Sub_metering_2, col = "red")
lines(DataTimes, HHPwConsump_sub$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"), bty = "n")
#A new plot 
plot(DataTimes, HHPwConsump_sub$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#A second new plot
plot(DataTimes, HHPwConsump_sub$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()