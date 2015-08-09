library(graphics)

#Download file from online source
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "HHPowerConsumption", method = "curl")
#Unzip file
unzip("HHPowerConsumption")

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

#Create png file of plot
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(HHPwConsump_sub$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()