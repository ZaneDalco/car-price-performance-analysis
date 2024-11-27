
---

# Power & Price: An Analysis of Car Attributes and Market Value

This project analyzes whether attributes such as engine size, horsepower, and 0-60 time correlate with car pricing, using data from the 2021-2022 Sports Car Prices Dataset on Kaggle. Conducted as part of the *CSIT 275: Introduction to R Programming* course, it demonstrates exploratory data analysis, data cleaning, and visualization techniques using R.

## Dataset
- **Source:** [Sports Car Prices Dataset](https://www.kaggle.com/datasets/rkiattisak/sports-car-prices-dataset)
- **Description:** Includes car attributes such as make, model, engine size, horsepower, torque, 0-60 time, and price.

## Project Goals
1. Identify relationships between price and attributes such as:
   - Engine size
   - Horsepower
   - 0-60 time
2. Determine which car make has the highest and lowest average price.
3. Visualize the data to compare attributes across car makes.

## Methodology
### 1. Data Import and Cleaning
- Imported the dataset using R and converted relevant columns to numeric.
- Replaced missing values with zeros and created a cleaned dataset (`unique_cars_data`).

### 2. Exploratory Data Analysis
- Used the **`psych`** package for descriptive statistics, including median, minimum, and maximum values.
- Identified key outliers (e.g., Bugatti as the most expensive and Mazda as the least expensive make).

### 3. Visualizations
- Created bar charts to compare average price, engine size, horsepower, and 0-60 time by car make.
- Plotted relationships between price and attributes side by side for easy comparison.

### 4. Findings
- Found a modest correlation between car prices and attributes like engine size and horsepower.
- Noted significant variations due to outliers, such as electric and high-end sports cars.

## Results
### Highlights
- **Most Expensive Make:** Bugatti
- **Least Expensive Make:** Mazda

### Visualizations
Included in the repository:
1. **Bar Charts**: Average price, horsepower, and engine size per car make.
2. **Scatter Plots**: Attribute vs. price correlations.

## Tools Used
- **Programming Language:** R
- **Libraries:** `dplyr`, `psych`, `ggplot2`

## Conclusion
While there is a modest correlation between car price and attributes like engine size and horsepower, the relationship is not consistently significant due to outliers.

## How to Run
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/price-and-performance-analysis.git
   ```
2. Open the `R` scripts in RStudio or any preferred IDE.
3. Run the analysis by executing the scripts step by step.

## Future Work
- Include additional attributes such as brand reputation and features for more comprehensive analysis.
- Explore machine learning models to predict car prices based on attributes.

---

