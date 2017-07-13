########################################################################################################################################
# This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets.
# In particular, we will be using the "Individual household electric power consumption Data Set". This script will read in the necessary
# data, clean it up as needed and then create a plot and output it to a png file.
# By: Jacob M. Lundeen
# Date: 2017 07 13
#######################################################################################################################################

# Hold the file name and open connection to file
filename <- "household_power_consumption.txt"
files <- file(filename)

# Create 'names' variable that contains the variable names
names <- colnames(read.table(filename, header = T, sep = ";", nrows = 0))

# Read in specific subset of data as layed out in the instructions (observations between 1/2/2007 and 2/2/2007)
x <- read.table(text = grep("^[1,2]/2/2007",readLines(files),value=T), header = T, sep = ";", na.strings = "?", col.names = names)

# Coerce 'x$Date' to a date format
x$Date <- as.Date(x$Date, format = "%d/%m/%Y")

# Create a new variable in 'x' that is a POSIXct type
x$dateTime <- strptime(paste(x$Date, x$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# Open png file
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Create plot
hist(x$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close png file
dev.off()
