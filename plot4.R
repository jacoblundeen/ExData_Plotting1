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
x$dateTime <- as.POSIXct(paste(x$Date, x$Time))

# Open png file
png(filename = "plot4.png", width = 480, height = 480, units = "px")

# Set template for multiple plots
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

# Create plots
with(x,
     {
          plot(Global_active_power~dateTime, type="l", 
               ylab="Global Active Power", xlab="")
          plot(Voltage~dateTime, type="l", 
               ylab="Voltage", xlab="dateTime")
          plot(Sub_metering_1~dateTime, type="l", 
               ylab="Energy Sub Metering", xlab="")
          lines(Sub_metering_2~dateTime,col='Red')
          lines(Sub_metering_3~dateTime,col='Blue')
          legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
                 legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
          plot(Global_reactive_power~dateTime, type="l", 
               ylab="Global Reactive Power",xlab="dateTime")
     })

# Close png file
dev.off()
