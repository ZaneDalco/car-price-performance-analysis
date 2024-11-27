#CSIT 275 Final Project

#Author: Zane Dalco
#Project : Car Price and Performance Analysis
# Date : December 2023

# - - - - - - - Importing - - - - - - -

#Importing necessary Packages:
library(ggplot2)
library(dplyr)
library(psych)

# Import the Data set:
cars_data <- read.csv("SpCarPrice.csv")



# - - - - - - - - CLEANING - - - - - - - - -


# Fill missing values with appropriate defaults
cars_data[is.na(cars_data)] <- 0


# Define the character columns to be converted to numeric
char_cols_to_numeric <- c("Price", "ZeroSixty", "Year", "EngineSize", "Horsepower", "Torque")



# Loop through the character columns and apply conversion
for (col in char_cols_to_numeric) {
  # Check if the column exists in the data frame
  if (col %in% names(cars_data)) {
    # Apply condition to handle missing values
    cars_data[[col]][is.na(cars_data[[col]])] <- 0
    
    # Convert the column to numeric
    cars_data[[col]] <- as.numeric(gsub(",", "", as.character(cars_data[[col]])))
  } else {
    warning(paste("Column", col, "not found in the data frame. Skipping conversion."))
  }
}


# Remove exact duplicates
unique_cars_data <- distinct(cars_data)

# Basic exploratory analysis
basic_stats <- describe(unique_cars_data)



# - - - - - - - Functions for All Averages - - - - - - - - - - -


# Function For Finding The Average Horsepower
average_horsepower_function <- function(data) {
  average_horsepower <- data %>%
    #Groups the data by the "Make" column
    group_by(Make) %>%
    # Calculates the mean(average) of the Horsepower column within each group 
    # Also creates "Average_Horsepower" to store these values.
    summarise(Average_Horsepower = mean(Horsepower, na.rm = TRUE))
  return(average_horsepower)
}

# Applying the function to our data set
average_horsepower <- average_horsepower_function(unique_cars_data)




# Function for Finding the Average Torque
average_torque_function <- function(data) {
  average_torque <- data %>%
    group_by(Make) %>%
    summarise(Average_Torque = mean(Torque, na.rm = TRUE))
  return(average_torque)
}

# Applying the function to our data set
average_torque <- average_torque_function(unique_cars_data)




#Function for Finding the Average 0-60 Time
average_0_60_function <- function(data) {
  average_0_60 <- data %>%
    group_by(Make) %>%
    summarise(Average_0_60 = mean(ZeroSixty, na.rm = TRUE))
  return(average_0_60)
}

# Applying the function to our dataset
average_0_60 <- average_0_60_function(unique_cars_data)




#Finding the Average Engine Size
average_engine_size <- unique_cars_data %>%
  group_by(Make) %>%
  summarise(Average_EngineSize = mean(EngineSize, na.rm = TRUE))

# Group by car make and calculate the average price
average_prices <- unique_cars_data %>%
  group_by(Make) %>%
  summarise(Average_Price = mean(Price, na.rm = TRUE))

# Combines the two summary tables (price and engine size) based on the make column
# Each row represents a unique car make and includes both avg price and engine size. 
average_price_engine_size <- inner_join(average_prices, average_engine_size, by = "Make")


# Find the car make with the highest average price
highest_price_make <- average_prices[which.max(average_prices$Average_Price), ]
#Answer: Bugatti

# Find the car make with the lowest average price
lowest_price_make <- average_prices[which.min(average_prices$Average_Price), ]
#Answer: Mazda

# Format Average_Price as currency
average_prices$Average_Price <- as.numeric(gsub("[\\$,]", "", average_prices$Average_Price))
average_prices$Make <- reorder(average_prices$Make, average_prices$Average_Price)


# Print the results
cat("Car Make with Highest Average Price:\n")
print.data.frame(highest_price_make)

cat("\nCar Make with Lowest Average Price:\n")
print.data.frame(lowest_price_make)

cat("\nAverage Prices for Each Car Make:\n")
print.data.frame(average_prices)




# - - - - - - - PLOTTING - - - - - - - - -


#Plotting Car Make and It's average price
ggplot(average_price_engine_size, aes(x=reorder(Make, Average_Price), y=Average_Price)) +
  geom_bar(stat="identity", fill="steelblue", color="black") +
  theme_minimal() +
  labs(x="Car Make", y="Average Price", title="Average Price by Car Make") +
  theme(axis.text.x = element_text(angle=90, hjust=1)) +
  scale_y_continuous(breaks=seq(0, max(average_price_engine_size$Average_Price), by=150000),
                     labels=function(x) format(x, scientific = FALSE))


# Plot Average Engine Size vs. Car Make using a bar chart
ggplot(average_price_engine_size, aes(x=reorder(Make, Average_Price), y=Average_EngineSize)) +
  geom_bar(stat="identity", fill="steelblue", color="black") +
  theme_minimal() +
  labs(x="Car Make", y="Average Engine Size (Liters)", title="Average Engine Size by Car Make") +
  theme(axis.text.x=element_text(angle=90, hjust=1))  

# Plot Average Horsepower vs. Car Make using a bar chart
ggplot(average_horsepower, aes(x = reorder(Make, Average_Horsepower), y = Average_Horsepower)) +
  geom_bar(stat = "identity", fill = "steelblue", color = "black") +
  theme_minimal() +
  labs(x = "Car Make", y = "Average Horsepower", title = "Average Horsepower by Car Make") +
  theme(axis.text.x = element_text(angle=90, hjust=1))

# Plot Average Torque vs Car Make Using a Bar Chart (Not Necessary)
ggplot(average_torque, aes(x = reorder(Make, Average_Torque), y = Average_Torque)) +
  geom_bar(stat = "identity", fill = "steelblue", color = "black") +
  theme_minimal() +
  labs(x = "Car Make", y = "Average Torque", title = "Average Torque by Car Make") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


# Plot Average 0-60 Time by Car Make using a bar chart
ggplot(average_0_60, aes(x = reorder(Make, Average_0_60), y = Average_0_60)) +
  geom_bar(stat = "identity", fill = "steelblue", color = "black") +
  theme_minimal() +
  labs(x = "Car Make", y = "Average 0-60 Time", title = "Average 0-60 Time by Car Make") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))




# - - - - - - - Corelation Plotting - - - - - - -


par(mfrow = c(1, 3))

# Plot 1: Average Price vs. Average Engine Size
plot(average_price_engine_size$Average_EngineSize, average_price_engine_size$Average_Price, 
     xlab = "Average Engine Size", ylab = "Average Price", main = "Average Price vs. Average Engine Size", 
     col = "steelblue", pch = 19)

# Plot 2: Average Price vs. Average Horsepower
plot(average_horsepower$Average_Horsepower, average_price_engine_size$Average_Price, 
     xlab = "Average Horsepower", ylab = "Average Price", main = "Average Price vs. Average Horsepower", 
     col = "steelblue", pch = 19)

# Plot 3: Average Price vs. Average 0-60 time
plot(average_0_60$Average_0_60, average_price_engine_size$Average_Price, 
     xlab = "Average 0-60 Time", ylab = "Average Price", main = "Average Price vs. Average 0-60 Time", 
     col = "steelblue", pch = 19)




