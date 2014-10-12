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


###################PLOT DATA


par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(PowerData, {
       
        
        plot(PowerData$DateTime,
             PowerData$Global_active_power,
             ylab="Global Active Power" ,
             xlab="",
             type="n"
        )
        
        lines(  PowerData$DateTime,
                PowerData$Global_active_power,
                
        )
        
    ###################################  
        
        plot(PowerData$DateTime,
             PowerData$Voltage,
             ylab="Voltage" ,
             xlab="datetime",
             type="n"
        )
        
        lines(  PowerData$DateTime,
                PowerData$Voltage,
             
        )
        
      ################################# 
        
       
        plot(PowerData$DateTime,
             PowerData$Sub_metering_1,
             ##col=c("red"), 
             ##main="Global Active Power",
             ylab="Energy sub metering" ,
             xlab="",
             type="n"
        )
        
        lines(PowerData$DateTime,PowerData$Sub_metering_1)
        lines(PowerData$DateTime,PowerData$Sub_metering_2, col="red")
        lines(PowerData$DateTime,PowerData$Sub_metering_3, col="blue")
        
        
        ### Add Legend
        
        legend('topright', inset= c(.02,0), names(PowerData[c(7,8,9)]) , 
               lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.7)
        
        
      ####################################
        
        
        plot(PowerData$DateTime,
             PowerData$Global_reactive_power,
             ylab="Global_reactive_power" ,
             xlab="datetime",
             type="n"
        )
        
        lines(  PowerData$DateTime,
                PowerData$Global_reactive_power,
               
        )
        
})


## Create image file 
dev.copy(png,file="plot4.png")  
dev.off()


