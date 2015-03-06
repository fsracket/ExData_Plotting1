# temp <- tempfile()
# download.file("https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption,temp, mode="wb")
# unzip(temp, "power-consumption")
# dd <- read.table("gbr_Country_en_csv_v2.csv", sep=",",skip=2, header=T)

powerDf <- read.csv("household_power_consumption.txt", na.strings = "?",
                    sep = ";", stringsAsFactors = FALSE)
powerDf[,1] <- as.Date(powerDf[,1], "%d/%m/%Y")

powerDf <- powerDf[ powerDf[,1] == as.Date('2007-02-01') | 
                    powerDf[,1] == as.Date('2007-02-02'), ]

powerDf$Time <- strptime(powerDf$Time, format = "%H:%M:%S")

png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
par(mar= c(4, 4, 2, 1))
hist(powerDf$Global_active_power, 
    main = "Global Active Power", 
    xlab = "Global Active Power (kilowatts)", 
    ylab = "Frequency", 
    col = "red")
dev.off()