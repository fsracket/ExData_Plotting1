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


# lines(year,defense,col="red",lwd=2.5) # adds a line for defense expenditures 
# 
# lines(year,health,col="blue",lwd=2.5) # adds a line for health expenditures 
# 
# legend(2000,9.5, # places a legend at the appropriate place c("Health","Defense"), # puts text in the legend 
#        
#        lty=c(1,1), # gives the legend appropriate symbols (lines)
#        
#        lwd=c(2.5,2.5),col=c("blue","red")) # gives the legend lines the correct color and width


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