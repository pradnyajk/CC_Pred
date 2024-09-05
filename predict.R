# loading libraries
library(caret)
library(randomForest)
library(class)
library(xgboost)
# loading the enviromnet
load("data/cc_ml_models.RData")

cat("","###########################",
    "#                         #",
    "# -Select a .csv file-    #",
    "#                         #",
    "###########################", 
    sep = "\n")


infile <- file.choose()
testing_data <- read.csv(infile)

# predict_tessting_data
# SVM
predict_test_svm <- predict(svm_radial, newdata = testing_data[,1:independent_variable_nos])
# knn model
predict_test_knn <- knn(train = TrainData[,1:independent_variable_nos],test = testing_data[,1:independent_variable_nos],
                        cl = TrainData$Type, k = optimum_k_value)
# RF model
predict_test_rf <- predict(xg_tune, testing_data[,1:independent_variable_nos])

# Xgboost
# convert the testing data into xgboost matrix type
xgboost_testing <- xgb.DMatrix(data = as.matrix(testing_data[,1:independent_variable_nos]))
pred_test_xg_boost <- predict(xg_boost_model, xgboost_testing)
# convert prediction to factor type

pred_test_xg_boost [(pred_test_xg_boost >3)] <- 3


# NB
pred_test_nb <- predict(nb_model, testing_data)

# predict_test_svm
# predict_test_knn
# predict_test_rf

predict_test_svm <- as.character(predict_test_svm)
predict_test_knn <- as.character(predict_test_knn)
predict_test_rf <- as.character(predict_test_rf)
pred_test_xg_boost <- as.character(pred_test_xg_boost)
pred_test_nb <- as.character(pred_test_nb)


probs <- cbind.data.frame(predict_test_svm, predict_test_knn,predict_test_rf, pred_test_xg_boost, pred_test_nb)


# Function to get the majority vote
get_majority_vote <- function(row) {
  counts <- table(row)
  majority_label <- names(counts)[which.max(counts)]
  return(majority_label)
}

# Apply the majority vote function row-wise to get the final prediction
probs$majority_vote <- apply(probs, 1, get_majority_vote)

# Display the final predictions
final_prediction <- probs$majority_vote
cat("-----------------------------------------------------------------------------------------------------", sep = '\n')

cat("Given sample: ", final_prediction, "\n")
cat("Please see the file cervical_cancer_prediction.csv generated in working directory", sep = '\n')
cat("-----------------------------------------------------------------------------------------------------")
result <- cbind.data.frame(Sample = rownames(testing_data), 
                           SVM = predict_test_svm,
                           kNN = predict_test_knn,
                           RF = predict_test_rf,
                           pred_test_xg_boost,
                           pred_test_nb,
                           Majority_Vote_from_5_models = final_prediction)
write.csv(result, file = 'cervical_cancer_prediction.csv', row.names = F)















