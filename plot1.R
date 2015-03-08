
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

powerDf$Time <- strptime(powerDf$Time, format = "%H:%M:%S")

png("plot1.png", width = 480, height = 480, units = "px", bg = "lightgrey")
par(mar= c(4, 4, 2, 1))
hist(powerDf$Global_active_power, 
    main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)", 
    ylab = "Frequency", 
    col = "red")
dev.off()