# plot1.R - Histogram of Global Active Power

# Read raw data
d <- read.table(
  "data/household_power_consumption.txt",
  header=TRUE,
  sep=";",
  na.strings="?",
  stringsAsFactors=FALSE
)

# Subset data for dates 2007-02-01 and 2007-02-02 (Data is dd/mm/yyyy in file)
d <- d[d$Date %in% c("1/2/2007", "2/2/2007"), ]

#convert needed column to numeric
d$Global_active_power <- as.numeric(d$Global_active_power)

# create PNG
png("plot1.png", width=480, height=480)

# create histogram with parameters as data, color and labels
hist(d$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.off()