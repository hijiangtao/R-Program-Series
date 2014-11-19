complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  wdpath = getwd()
  
  ## the list to save result
  count <- 1
  
  for (i in id) {
    ## read the file
    filepath = paste(wdpath, directory, sep="/")
    list = dir(path = filepath)
    mydata <- read.csv(paste(filepath, list[[i]], sep = "/"))
    mydata = na.omit(mydata)
    
    ## write the data
    if(count == 1){
      count <- 2
      result_id <- i
      result_nobs <- as.numeric(nrow(mydata))
      ##names(result) <- c("id","nobs")
    }
    else {
      result_id <- append(result_id, i)
      result_nobs <- append(result_nobs, nrow(mydata))
    }
  }
  
  x <- data.frame(id=result_id, nobs=result_nobs)
  return(x)
}