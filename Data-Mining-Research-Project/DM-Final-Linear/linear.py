import pandas as pd
from numpy import *
from sklearn import linear_model
from sklearn import metrics


trainData = pd.read_csv('train dataset.csv')
trainArray = trainData.values

for i in range(len(trainArray)):
    if trainArray[i][0] == "Male":
        trainArray[i][0] = 1
    else:
        trainArray[i][0] = 0

trainDF = pd.DataFrame(trainArray)

trainMainDF = trainDF[[0, 1, 2, 3, 4, 5, 6]]
trainMainArray = trainMainDF.values
# print (trainMainArray)


trainTemp = trainDF[7]
train_y = trainTemp.values
# print(train_y)
# print(trainMainArray)
train_y = trainTemp.values

for i in range(len(train_y)):
    train_y[i] = str(train_y[i])

mul_lr = linear_model.LogisticRegression(multi_class='multinomial', solver='newton-cg', max_iter=1000)
mul_lr.fit(trainMainArray, train_y)

testdata = pd.read_csv('test dataset.csv')
test = testdata.values

for i in range(len(test)):
    if test[i][0] == "Male":
        test[i][0] = 1
    else:
        test[i][0] = 0

df1 = pd.DataFrame(test)

testdf = df1[[0, 1, 2, 3, 4, 5, 6]]
maintestarray = testdf.values
# print(maintestarray)

y_test = df1[7]

y_pred = mul_lr.predict(maintestarray)
for i in range(len(y_pred)):
    y_pred[i] = str((y_pred[i]))

DF = pd.DataFrame(y_pred, columns=['Predicted Personality'])
DF.index = DF.index + 1
DF.index.names = ['Person No']
DF.to_csv("output_Linear.csv")

print("Accuracy:", metrics.accuracy_score(y_test, y_pred))

