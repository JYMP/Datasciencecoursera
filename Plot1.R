# Reads in a file and plots data
# Set working directory to that from which data is retrieved from
setwd("C:/My Documents/Training/Coursera/R/Exploratory_Data_Analysis")

# Check if a directory called Course_Project exists.  If not create a directory
if (!file.exists("Course_Project")){
  dir.create("Course_Project")
  
  # Download zipped file from url and unzip it into working directory
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl, destfile = "./Course_Project/electric_power_consumption.zip")
  unzip("./Course_Project/electric_power_consumption.zip", exdir = "./Course_Project")
  }

# Read in file from working directory
# Note that the sqldf package was used and loaded.  
# Then the read.csv.sql function was used to read in the file from the rows for the Dates ranging from 
# 1/2/2007 to 2/2/2007
# Alternatively, using the read.csv function, we need to know from which rows to read the data from
# The data is found between the rows 66637 and 69517
library("sqldf", lib.loc="C:/R/R-3.2.1/library")
dat <- read.csv.sql("./Course_Project/household_power_consumption.txt", sep = ";", sql = 'select * from file where Date = "1/2/2007" OR Date = "2/2/2007"')

#Combine Date and Time columns and over-write into the Date column in dat
dat$Date <- strptime(paste(dat$Date,dat$Time),"%d/%m/%Y %H:%M:%S")

# After data has been retrieved, re-set working directory to that in which the plot will be saved
setwd("C:/My Documents/Training/Coursera/R/Exploratory_Data_Analysis")

# Set mfrow to be 1 row and 1 column
par(mfrow = c(1,1))

# Plot a histogram of Global Active Power and colour it red.  Title is Global Active Power
with(dat, hist(dat$Global_active_power, col = 2, xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))

# Copy plot the plot to a PNG file
dev.copy(png, file = "plot1.png")
dev.off()  # Close the png device