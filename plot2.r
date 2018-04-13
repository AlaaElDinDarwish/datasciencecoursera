Data<-read.table("household_power_consumption.txt",sep=";",skip=1,na.strings="?")
colnames(Data)<-c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
NeededData<-subset(Data,Data$Date=="1/2/2007" | Data$Date =="2/2/2007")
NeededData$Date<-as.Date(NeededData$Date,format = "%d/%m/%Y")
NeededData$datetime <- strptime(paste(NeededData$Date, NeededData$Time), "%Y-%m-%d %H:%M:%S")
plot(NeededData$datetime,NeededData$Global_active_power, type = "l",ylab = "Global Active Power (kilowatts)", xlab = "")

dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()