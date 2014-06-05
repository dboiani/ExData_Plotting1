# plot3.R code to produce plot3.png

# get the data
# save the Url
powerdataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# download the zip file
download.file(powerdataUrl, destfile = "exdata-data-household_power_consumption.zip")
# extract the text file from the zip file
unzip("exdata-data-household_power_consumption.zip")

# prepare the data
# read the data - treat observations marked as "?" as NA
powerdata <- read.csv2("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".",
                       na.strings=c("?"))
# clean up the date
powerdata[,1] <- as.Date(powerdata[,1],"%d/%m/%Y")
# subset the data on the target date range
powerdates <- subset(powerdata, Date >= "2007-02-01" & Date <= "2007-02-02")
#powerdates <- powerdata[which(powerdata$Date >= "2007-02-01" & powerdata$Date <= "2007-02-02"),]

# get the range for the x and y axis
xrange <- range(as.POSIXct(paste(powerdates$Date, powerdates$Time), format="%Y-%m-%d %H:%M:%S"))
yrange <- range(powerdates$Sub_metering_1)

png(filename = "plot3.png", width = 480, height = 480)

# Plot 3
with(powerdates, plot(xrange, yrange, type = "n", xlab = "", 
                      ylab = "Energy sub metering"))
with(powerdates, lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), 
                       Sub_metering_1, col = "black"))
with(powerdates, lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), 
                       Sub_metering_2, col = "red"))
with(powerdates, lines(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), 
                       Sub_metering_3, col = "blue"))

legend("topright", pch = "-", col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1))

#dev.copy(png, file = "plot3.png")
dev.off()

