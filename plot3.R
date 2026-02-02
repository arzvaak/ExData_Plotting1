# plot3.R
# Purpose: Plot energy sub metering (1, 2, 3) over time for Feb 1-2, 2007
# Output: plot3.png (480x480)


# 1) Read the raw dataset

d <- read.table(
  "data/household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# 2) Subset to the required dates (Date is dd/mm/yyyy in the file)

d <- d[d$Date %in% c("1/2/2007", "2/2/2007"), ]

# 3) Create a proper datetime column from Date + Time

d$datetime <- as.POSIXct(strptime(
  paste(d$Date, d$Time),
  format = "%d/%m/%Y %H:%M:%S"
))

# 4) Convert the sub metering columns to numeric

d$Sub_metering_1 <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)

# 5) Create the PNG and draw the plot

png("plot3.png", width = 480, height = 480)

# First line plot (black by default)
plot(d$datetime, d$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n")

# Add the other two series as lines on the same plot
lines(d$datetime, d$Sub_metering_2, col = "red")
lines(d$datetime, d$Sub_metering_3, col = "blue")

# Add legend in the top-right corner (no box around it)
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n")

# Draw ONLY the weekday axis
axis(1,
     at = as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03")),
     labels = c("Thu", "Fri", "Sat"))

dev.off()