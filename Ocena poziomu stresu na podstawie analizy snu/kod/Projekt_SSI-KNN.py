#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import pandas as pd
import random as rd
import math
import seaborn as sns
from matplotlib import pyplot
from heapq import heappush, heappop


# In[2]:


pillow = pd.read_csv("SaYoPillow.csv")
pillow.head()


# In[3]:


sns.pairplot(pillow, hue='stress', markers='+')


# In[4]:


pillow.describe()


# In[5]:


class DataProcessing:
    @staticmethod 
    def shuffle(x): # metoda tasujaca zbior
        x=x.copy()
        for i in range(len(x)-1):
            j=rd.randint(0,i)
            x.iloc[i], x.iloc[j]=x.iloc[j], x.iloc[i]
        return x
    
    @staticmethod 
    def splitSet(x): # metoda dzielaca zbior
        x=x.copy()
        n=int(len(x)*0.7)
        xTrain=x[:n]
        xVal=x[n:]
        return xTrain, xVal

    @staticmethod 
    def normalize(x): # metoda normalizujaca dane
        x=x.copy()
        values=x.select_dtypes(exclude="object")
        columnNames=values.columns.tolist()
        columnNames.remove("stress")
        
        # znalezienie wartosci skrajnych w kolumnie
        for column in columnNames:
            data=x.loc[:,column]
            max1=max(data)
            min1=min(data)
            
            # normalizacja wartosci w kolumnie
            for row in range(len(x)):
                newValue=((x.at[row,column]-min1)/(max1-min1))
                x.at[row, column]=newValue
        return x


# In[6]:


pillow.head()


# In[7]:


# pillow = DataProcessing.shuffle(pillow) # tasowanie niewymagane - zbior jest juz wymieszany


# In[8]:


pillow.head()


# In[9]:


pillowNorm=DataProcessing.normalize(pillow)


# In[10]:


pillowNorm.head()


# In[11]:


pillowTrain, pillowTest = DataProcessing.splitSet(pillow)


# In[12]:


pillowNormTrain, pillowNormTest = DataProcessing.splitSet(pillowNorm)


# In[13]:


pillowTrain.head(),pillowTrain.head()


# In[14]:


pillowNorm.describe()


# In[15]:


class KNN:
    @staticmethod
    def metric(v1, v2, m): # metoda obliczajaca odleglosc
        tmp = 0
        for i in range(len(v1)-1):
            tmp += abs(v1[i] - v2[i])**m
        return tmp**(1/m)
    
    @staticmethod
    def classify(sample, X, C, k, m):
        # utworzenie slownika na podstawie nazw klas
        classes = {}
        for cls in C:
            classes[cls] = 0
        
        # obliczenie odleglosci probki od kazdego rekordu w zbiorze
        distances = []
        for i in range(len(X)):
            distances.append(KNN.metric(sample, X.iloc[i], m))
        
        # sortowanie (stogowe) zbioru wzgledem odleglosci
        heap = []
        for i in range(len(X)):
            heappush(heap, (distances[i], X.iloc[i].stress))
        
        # glosowanie
        for i in range(0, k):
            classes[heappop(heap)[1]] += 1
        
        return max(classes, key = classes.get)


# In[16]:


NEIGHBORS_NUMBER = 5
DISTANCE_PARAMETER = 2


# In[17]:


actual = pillowTest["stress"].copy()
predicted = [] # wyniki klasyfikacji nieznormalizowanego zbioru testowego
for i in range(len(pillowTest)):
    predicted.append(KNN.classify(pillowTest.iloc[i], pillowTrain, pillowTrain["stress"], NEIGHBORS_NUMBER, DISTANCE_PARAMETER))


# In[18]:


data = {'y_Actual':    actual,
        'y_Predicted': predicted
        }

df = pd.DataFrame(data, columns=['y_Actual','y_Predicted'])
confusion_matrix = pd.crosstab(df['y_Actual'], df['y_Predicted'], rownames=['Actual'], colnames=['Predicted'])
print (confusion_matrix)
plot = sns.heatmap(confusion_matrix, annot=True)
fig = plot.get_figure()
fig.savefig('KNNplot.png', dpi=300)

from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
accuracy = accuracy_score(actual, predicted)
precision = precision_score(actual, predicted, average="weighted")
recall = recall_score(actual, predicted, average="weighted")
f1 = f1_score(actual, predicted, average="weighted")

print(" Accuracy: %.3f" %accuracy)
print("Precision: %.3f" %precision)
print("   Recall: %.3f" %recall)
print("       F1: %.3f" %f1)


# In[19]:


actualN = pillowNormTest["stress"].copy()
predictedN = [] # wyniki klasyfikacji znormalizowanego zbioru testowego
for i in range(len(pillowTest)):
    predictedN.append(KNN.classify(pillowNormTest.iloc[i], pillowNormTrain, pillowNormTrain["stress"], NEIGHBORS_NUMBER, DISTANCE_PARAMETER))


# In[20]:


dataN = {'y_Actual':    actualN,
        'y_Predicted': predictedN
        }

dfN = pd.DataFrame(dataN, columns=['y_Actual','y_Predicted'])
confusion_matrixN = pd.crosstab(dfN['y_Actual'], dfN['y_Predicted'], rownames=['Actual'], colnames=['Predicted'])
print (confusion_matrixN)
plotN = sns.heatmap(confusion_matrixN, annot=True)
figN = plotN.get_figure()
figN.savefig('KNNplotNorm.png', dpi=300)

from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
accuracyN = accuracy_score(actualN, predictedN)
precisionN = precision_score(actualN, predictedN, average="weighted")
recallN = recall_score(actualN, predictedN, average="weighted")
f1N = f1_score(actualN, predictedN, average="weighted")

print(" Accuracy: %.3f" %accuracyN)
print("Precision: %.3f" %precisionN)
print("   Recall: %.3f" %recallN)
print("       F1: %.3f" %f1N)


# In[21]:


#
# KNN from sklearn
#


# In[22]:


pillowTrainX = pillowTrain.iloc[:, :-1].values
pillowTrainY = pillowTrain.iloc[:, 8].values

pillowTestX = pillowTest.iloc[:, :-1].values
pillowTestY = pillowTest.iloc[:, 8].values

pillowNormTrainX = pillowNormTrain.iloc[:, :-1].values
pillowNormTrainY = pillowNormTrain.iloc[:, 8].values

pillowNormTestX = pillowNormTest.iloc[:, :-1].values
pillowNormTestY = pillowNormTest.iloc[:, 8].values


# In[23]:


from sklearn.neighbors import KNeighborsClassifier
classifier = KNeighborsClassifier(n_neighbors = NEIGHBORS_NUMBER, p = DISTANCE_PARAMETER)
classifier.fit(pillowTrainX, pillowTrainY)

y_pred = classifier.predict(pillowTestX)


# In[24]:


dataSK = {'y_Actual':  pillowTestY,
        'y_Predicted': y_pred
        }

dfSK = pd.DataFrame(dataSK, columns=['y_Actual','y_Predicted'])
confusion_matrixSK = pd.crosstab(dfSK['y_Actual'], dfSK['y_Predicted'], rownames=['Actual'], colnames=['Predicted'])
print (confusion_matrixSK)
plotSK = sns.heatmap(confusion_matrixSK, annot=True)
figSK = plotSK.get_figure()
figSK.savefig('KNNplot-SKLearn.png', dpi=300)

from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
accuracySK = accuracy_score(pillowTestY, y_pred)
precisionSK = precision_score(pillowTestY, y_pred, average="weighted")
recallSK = recall_score(pillowTestY, y_pred, average="weighted")
f1SK = f1_score(pillowTestY, y_pred, average="weighted")

print(" Accuracy: %.3f" %accuracySK)
print("Precision: %.3f" %precisionSK)
print("   Recall: %.3f" %recallSK)
print("       F1: %.3f" %f1SK)


# In[25]:


from sklearn.neighbors import KNeighborsClassifier
classifier = KNeighborsClassifier(n_neighbors = NEIGHBORS_NUMBER, p = DISTANCE_PARAMETER)
classifier.fit(pillowNormTrainX, pillowNormTrainY)

y_pred_norm = classifier.predict(pillowNormTestX)


# In[26]:


dataSKN = {'y_Actual': pillowNormTestY,
        'y_Predicted': y_pred_norm
        }

dfSKN = pd.DataFrame(dataSKN, columns=['y_Actual','y_Predicted'])
confusion_matrixSKN = pd.crosstab(dfSKN['y_Actual'], dfSKN['y_Predicted'], rownames=['Actual'], colnames=['Predicted'])
print (confusion_matrixSKN)
plotSKN = sns.heatmap(confusion_matrixSKN, annot=True)
figSKN = plotSKN.get_figure()
figSKN.savefig('KNNplotNorm-SKLearn.png', dpi=300)

from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
accuracySKN = accuracy_score(pillowNormTestY, y_pred_norm)
precisionSKN = precision_score(pillowNormTestY, y_pred_norm, average="weighted")
recallSKN = recall_score(pillowNormTestY, y_pred_norm, average="weighted")
f1SKN = f1_score(pillowNormTestY, y_pred_norm, average="weighted")

print(" Accuracy: %.3f" %accuracySKN)
print("Precision: %.3f" %precisionSKN)
print("   Recall: %.3f" %recallSKN)
print("       F1: %.3f" %f1SKN)

