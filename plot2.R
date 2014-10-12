######################### READ IN DATA
PowerData <- read.table("household_power_consumption.txt",
                        sep=";",
                        header=T,
                        na = "?")

## Formatting the date and subseting the data only on 2007-02-01 and 2007-02-02
PowerData$Date = as.Date(PowerData$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
PowerData = PowerData[PowerData$Date >= startDate & PowerData$Date <= endDate, ]

##Combine Date and Time columns in new column, then convert to DateTime format
x <- paste(PowerData$Date, PowerData$Time)
PowerData$DateTime <- as.POSIXct(x)

########################## PLOT DATA

plot(PowerData$DateTime,
     PowerData$Global_active_power,
     ##col=c("red"), 
     ##main="Global Active Power",
     ylab="Global Active Power (kilowatts)" ,
     xlab="",
     type="n"
)

lines(  PowerData$DateTime,
        PowerData$Global_active_power,
    
     ##col=c("red"), 
     ##main="Global Active Power",
     ylab="Global Active Power (kilowatts)" ,
     xlab="",
)


## Create image file 
dev.copy(png,file="plot2.png")  
dev.off()
