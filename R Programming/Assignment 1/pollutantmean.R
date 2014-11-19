pollutantmean <- function(directory, pollutant, id = 1:332) {
  wdpath = getwd()
  sum_row = 0
  mean_of_sum = 0
  for (i in id) {
    filepath = paste(wdpath, directory, sep="/")
    list = dir(path = filepath)
    mydata <- read.csv(paste(filepath, list[[i]], sep = "/"))
    mydata = na.omit(mydata[pollutant])
    
    sum_row = sum_row+nrow(mydata)
    mean_of_sum = mean_of_sum + colSums(mydata[pollutant])
  }
  
  ##if (sum_row == 0 || mean_of_sum == 0) return(as.numeric(0))
  result = as.numeric(mean_of_sum / sum_row)
  return(result)
}