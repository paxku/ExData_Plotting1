if (!file.exists('source_data')) {
  dir.create('source_data')
}
# check for clean data
if (!file.exists('source_data/power_consumption_clean.txt')) {
  # unzip data
  unzip('source_data/exdata_data_household_power_consumption.zip',exdir='source_data',overwrite=TRUE)
  # load data
  variable.class<-c(rep('character',2),rep('numeric',7))
  power.consumption<-read.table('source_data/household_power_consumption.txt',header=TRUE,
                                sep=';',na.strings='?',colClasses=variable.class)
  power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]
  # clean data
  cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity',
          'SubMetering1','SubMetering2','SubMetering3')
  colnames(power.consumption)<-cols
  power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
  power.consumption<-power.consumption[,c(10,3:9)]
  # write clean data
  write.table(power.consumption,file='source_data/power_consumption_clean.txt',sep='|',row.names=FALSE)
} else {
  power.consumption<-read.table('source_data/power_consumption_clean.txt',header=TRUE,sep='|')
  power.consumption$DateTime<-as.POSIXlt(power.consumption$DateTime)
}
# remove old big and dirty data
if (file.exists('source_data/household_power_consumption.txt')) {
  file.remove('source_data/household_power_consumption.txt')
}