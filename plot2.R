# plot2.R code to produce plot2.png

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

png(filename = "plot2.png", width = 480, height = 480)

# Plot 2
with(powerdates, plot(as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"), 
                      Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)"))

#dev.copy(png, file = "plot2.png")
dev.off()

