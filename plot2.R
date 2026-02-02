# plot2.R - Global Active Power over time

d <- read.table(
  "data/household_power_consumption.txt",
  header = TRUE,
  sep = ";",
  na.strings = "?",
  stringsAsFactors = FALSE
)

# subset to Feb 1-2, 2007
d <- d[d$Date %in% c("1/2/2007", "2/2/2007"), ]

# create datetime
d$datetime <- as.POSIXct(strptime(
  paste(d$Date, d$Time),
  format = "%d/%m/%Y %H:%M:%S"
))

# Numeric conversion
d$Global_active_power <- as.numeric(d$Global_active_power)

png("plot2.png", width = 480, height = 480)

plot(
  d$datetime,
  d$Global_active_power,
  type = "l",
  xlab = "",
  ylab = "Global Active Power (kilowatts)",
  xaxt = "n"
)
at_days <- as.POSIXct(
  c("2007-02-01", "2007-02-02", "2007-02-03"),
  format = "%Y-%m-%d"
)
axis(1, at = at_days, labels = c("Thu", "Fri", "Sat"))

dev.off()