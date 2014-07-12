## Create a histogram plot from the Household Consumption Power Data
## 
## Instructions: 
## Download this file and the following zip file to the same directory
##
## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## 
## Source this program and execution will automatically start 
## 
## The data will be loaded and massaged into proper format for plotting
## 
## A file plot1.png will be created in the current directory
## 
## 

## Function loadata
## Extract the data file file from the downloaded zip file
## Load the data file into a data frame 
## Filter the data to include 2007-02-01 & 2007-02-02
## Concatenate the Date & Time Columns and add a Summable Column for counts
## Return the resulting data frame
## 
loaddata <- function(zipname="exdata_data_household_power_consumption.zip", 
                     filename="household_power_consumption.txt") {
  ##data <- read.csv("data\\household_power_consumption.txt", header=TRUE, sep = ";")
  
  data <- read.table(
    unz(zipname,filename), 
    header=TRUE, sep = ";", comment.char="", 
    colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
    na.strings=c("?"))
  
  
  filterdata <- data[data$Date %in% c("1/2/2007","2/2/2007"), ]
  
  remove(data)
  
  returndata <- data.frame(
    DateTime=strptime(paste(filterdata$Date,filterdata$Time),format="%d/%m/%Y %T"), 
    subset(filterdata, select=Global_active_power:Sub_metering_3),
    Sumcol=1)
  
  remove(filterdata)
  
  returndata
    
}

## Function plotdata
## Create a histogram plot of the data wit the given labels and colors
## 
plotdata <- function(data) {
  hist(data,main="Global Active Power", xlab="Global Active Power (killowatts)", ylab="Frequency", col="Red")
}

## Function savedata
## Open the output file "plot1.png"
## Call the plotdata function
## Close the output file
## 
savedata <- function(data) {
  dev <- png(filename="plot1.png", width=480, height=480 )
  plotdata(data)
  ret <- dev.off()
}


## Main Program
## Load the Data and Save the Plot
## 
print("Loading Household Consumption Data")
data <- loaddata()

print("Saving Plot to plot1.png")
savedata(data$Global_active_power)

print("Done")


