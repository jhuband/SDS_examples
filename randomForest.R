#--------------------------------
#   Random Forest Example with R
#--------------------------------

#  Load the packages
library(randomForest)

#  Read in the Data
data_url = "https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv"
wine <- read.csv(data_url, sep=';', stringsAsFactors = FALSE)
print(head(wine))

#  Divide the Data
N <- nrow(wine)
sample_size <- round((0.70 * N))

set.seed(191506)
ndx <- sort(sample(1:N, sample_size))

train_data <- wine[ndx, ]
test_data <- wine[-ndx, ]

#  Fit the model
forest_results <- randomForest(quality ~ ., data=train_data)

#  Apply the model to the test data
prediction <- predict(forest_results, test_data, type="response")

#  Display the feature importance
featureImportance <- importance(forest_results)

decr_table <- featureImportance[  
  order(featureImportance[,1], decreasing=TRUE), ]
Node_Purity <- as.data.frame(decr_table)
print(Node_Purity)
