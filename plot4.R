# plot4.R
# Purpose: Create a 2x2 panel plot for Feb 1-2, 2007
# Output: plot4.png (480x480)

# 1) Read data (treat "?" as NA)
d <- read.table(
  "data/household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# 2) Subset to Feb 1-2, 2007 (Date is dd/mm/yyyy in file)
d <- d[d$Date %in% c("1/2/2007", "2/2/2007"), ]

# 3) Build datetime
d$datetime <- as.POSIXct(strptime(
  paste(d$Date, d$Time),
  format = "%d/%m/%Y %H:%M:%S"
))

# 4) Convert needed columns to numeric
d$Global_active_power    <- as.numeric(d$Global_active_power)
d$Global_reactive_power  <- as.numeric(d$Global_reactive_power)
d$Voltage                <- as.numeric(d$Voltage)
d$Sub_metering_1         <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2         <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3         <- as.numeric(d$Sub_metering_3)

# Precompute axis tick positions and labels (Thu/Fri/Sat)
at_days <- as.POSIXct(c("2007-02-01", "2007-02-02", "2007-02-03"))
day_labs <- c("Thu", "Fri", "Sat")

# 5) Create PNG and set 2x2 layout
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# ---- Panel 1: Global Active Power ----
plot(d$datetime, d$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power",
     xaxt = "n")           # suppress default x-axis
axis(1, at = at_days, labels = day_labs)

# ---- Panel 2: Voltage ----
plot(d$datetime, d$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage",
     xaxt = "n")
axis(1, at = at_days, labels = day_labs)

# ---- Panel 3: Energy sub metering (3 lines + legend) ----
plot(d$datetime, d$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     xaxt = "n")
lines(d$datetime, d$Sub_metering_2, col = "red")
lines(d$datetime, d$Sub_metering_3, col = "blue")

legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       bty = "n",
       cex = 0.8)

axis(1, at = at_days, labels = day_labs)

# ---- Panel 4: Global Reactive Power ----
plot(d$datetime, d$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power",
     xaxt = "n")
axis(1, at = at_days, labels = day_labs)

dev.off()
