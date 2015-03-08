if (!file.exists('plots')) {
  dir.create('plots')
}

# load clean data
source('scripts/read_data.R')
# open device
png(filename='plots/plot2.png',width=480,height=480,units='px')
# plot data
plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')
# Turn off device
x<-dev.off()