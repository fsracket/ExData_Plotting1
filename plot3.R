if (!file.exists("household_power_consumption.txt")) {
  #download zip file from coursera (to temp location)
  #unzip and place csv in working dir
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip",
                temp,
                method="curl")
  unzip(temp, files = c("household_power_consumption.txt"), exdir = getwd())
  unlink(temp)
}


powerDf <- read.csv("household_power_consumption.txt", na.strings = "?",
                    sep = ";", stringsAsFactors = FALSE)
powerDf[,1] <- as.Date(powerDf[,1], "%d/%m/%Y")

powerDf <- powerDf[ powerDf[,1] == as.Date('2007-02-01') | 
                      powerDf[,1] == as.Date('2007-02-02'), ]

powerDf$HourTime <- strptime(paste(format(powerDf$Date, "%Y-%m-%d"), powerDf$Time),
                         format = "%Y-%m-%d %H:%M:%S")


png("plot3.png", width = 480, height = 480, units = "px", bg = "lightgrey")
par(mar= c(4, 6, 2, 1))
plot(powerDf$HourTime, powerDf$Sub_metering_1, 
     type = "l",
     xlab = "", 
     ylab = "Energy sub metering")
lines(powerDf$HourTime, powerDf$Sub_metering_2, type="l", col="red")
lines(powerDf$HourTime, powerDf$Sub_metering_3, type="l", col="blue")
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                col=c("black", "red", "blue"), lty = 1)
dev.off()