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
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(DataTimes, HHPwConsump_sub$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()