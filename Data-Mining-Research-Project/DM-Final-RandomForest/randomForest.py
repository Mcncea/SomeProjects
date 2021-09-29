import pandas as pd
from numpy import *
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics


trainData = pd.read_csv('train dataset.csv')

trainArray = trainData.values

for i in range(len(trainArray)):
    if trainArray[i][0] == "Male":
        trainArray[i][0] = 1
    else:
        trainArray[i][0] = 0

data = pd.DataFrame({
    'Gender': trainArray[:, 0],
    'Age': trainArray[:, 1],
    'openness': trainArray[:, 2],
    'neuroticism': trainArray[:, 3],
    'conscientiousness': trainArray[:, 4],
    'agreeableness': trainArray[:, 5],
    'extraversion': trainArray[:, 6],
    'Personality (class label)': trainArray[:, 7],
})
data.head()


X=data[['Gender', 'Age', 'openness', 'neuroticism', 'conscientiousness', 'agreeableness',  'extraversion']]  # Features
y=data['Personality (class label)']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3)

clf=RandomForestClassifier()
clf.fit(X_train,y_train)
y_pred=clf.predict(X_test)

DF = pd.DataFrame(y_pred, columns=['Predicted Personality'])
DF.index = DF.index + 1
DF.index.names = ['Person No']
DF.to_csv("output_RandomForest.csv")
print("Accuracy:",metrics.accuracy_score(y_test, y_pred))

