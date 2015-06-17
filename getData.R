library(data.table)
library(chron)

if (!file.exists("data")) {
    print("Creating data directory.")
    dir.create("data")
}

# Data from the UC Irvine Machine Learning Repository. In particular, the
# “Individual household electric power consumption Data Set” [20MB]
dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipRL <- "./data/hhpc.zip"
fileRL <- "./data/household_power_consumption.txt"
# Only download the data if we don't already have it.
if (!file.exists(zipRL) & !file.exists(fileRL)) {
    download.file(dataURL, destfile=zipRL, method="curl")
} else {
    print("Data already exists. Skipping fetch from internet.")
}

# Unzip the data if we haven't already.
if (!file.exists(fileRL)) {
    unzip(zipRL, exdir="./data/.")
} else {
    print("Data already unzipped.")
}

# Read the data into a data table assuming it doesn't already exists.
#fileRL <- "./data/test.txt"
if (!exists("data_table")){
    data_table <- fread(fileRL, na.strings=c("?"), sep=";", colClasses="character")

    # I tried specifying the column classes up front, but couldn't get it to be happy.
    data_table <- within(data_table, Date <- as.Date(Date, format="%d/%m/%Y"))
    data_table <- within(data_table, Time <- chron(times=Time))
    data_table <- within(data_table, Global_active_power <- as.numeric(Global_active_power))
    data_table <- within(data_table, Global_reactive_power <- as.numeric(Global_reactive_power))
    data_table <- within(data_table, Voltage <- as.numeric(Voltage))
    data_table <- within(data_table, Global_intensity <- as.numeric(Global_intensity))
    data_table <- within(data_table, Sub_metering_1 <- as.numeric(Sub_metering_1))
    data_table <- within(data_table, Sub_metering_2 <- as.numeric(Sub_metering_2))
    data_table <- within(data_table, Sub_metering_3 <- as.numeric(Sub_metering_3))

    # We're only interested in the data over these two days so subset it.
    selection <- which(data_table$Date == '2007-02-01' |
                       data_table$Date == '2007-02-02')
    data_table <- data_table[selection, ]

    # Useful new column combining Date and Time.
    data_table[, c("DateTime") := as.POSIXct(paste(Date, Time))]
} else {
    print("Data table in variable 'data_table' appears to already exists. Skipping read.")
}
