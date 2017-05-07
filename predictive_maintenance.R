# Check first if the needed packages are install in the current environment
# before using them below. 
packages <- c("ggplot2", "tidyr", "dplyr", "ggvis", "corrplot", "survival")
if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())))  
}

# Libraries to be used
library(ggplot2)
library(tidyr)
library(dplyr)
library(ggvis)
library(corrplot)
library(survival)
library(readr)

# Load IoT Sensor Captured - Equipment Performance Dataset for Statistical Analysis
iotData <- read_csv("equipment_IoT_sensor_data.csv")

# Check if data is in original shape...
if(!hasName(iotData,"mtbf")){
  
  # ... yes, data is in original shape, calculating MTBF / MTTR now...
  # Calculate Mean Time Between Failures (MTBF) = (Total up time) / (number of breakdowns)
  # Calculate Mean Time To Recover (MTTR) = (Total down time) / (number of breakdowns)
  iotData$mtbf <- round(iotData$running_hrs / iotData$total_failure_count,0)
  iotData$mttr <- round(iotData$downtime_min / iotData$total_failure_count,0)
  
  # Optional: If you wish you can persist your changes through following call
  write_csv(iotData, "equipment_IoT_sensor_data.csv")

}

# show statistical summary of data frame
summary(iotData)


