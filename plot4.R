# temp <- tempfile()
# download.file("https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption,temp, mode="wb")
# unzip(temp, "power-consumption")
# dd <- read.table("gbr_Country_en_csv_v2.csv", sep=",",skip=2, header=T)

powerDf <- read.csv("household_power_consumption.txt", na.strings = "?",
                    sep = ";", stringsAsFactors = FALSE)
powerDf[,1] <- as.Date(powerDf[,1], "%d/%m/%Y")

powerDf <- powerDf[ powerDf[,1] == as.Date('2007-02-01') | 
                      powerDf[,1] == as.Date('2007-02-02'), ]

powerDf$HourTime <- strptime(paste(format(powerDf$Date, "%Y-%m-%d"), powerDf$Time),
                         format = "%Y-%m-%d %H:%M:%S")


png("plot4.png", width = 480, height = 480, units = "px", bg = "lightgrey")
par(mfrow = c(2,2))
par(mar= c(6, 6, 2, 1))

#global active power (lines)
plot(powerDf$HourTime, powerDf$Global_active_power, 
     type = "l",
     xlab = "", 
     ylab = "Global Active Power")

#voltage
plot(powerDf$HourTime, powerDf$Voltage, 
     type = "l",
     xlab = "datetime", 
     ylab = "Voltage")


#sub-metering plot
par(mar= c(6, 6, 2, 1))
plot(powerDf$HourTime, powerDf$Sub_metering_1, 
     type = "l",
     xlab = "", 
     ylab = "Energy sub metering")
lines(powerDf$HourTime, powerDf$Sub_metering_2, type="l", col="red")
lines(powerDf$HourTime, powerDf$Sub_metering_3, type="l", col="blue")
legend('topright', legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                col=c("black", "red", "blue"), lty = 1, bty="n")

#global reactive power
plot(powerDf$HourTime, powerDf$Global_reactive_power, 
     type = "l",
     xlab = "datetime", 
     ylab = "Global_reactive_power")

dev.off()