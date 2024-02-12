#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns
import math


# In[47]:


dataset = pd.read_csv('SaYoPillow.csv')
dataset


# In[50]:


sns.pairplot(dataset, hue='stress', markers='+')


# In[3]:


dataset.describe()


# In[4]:


#$$ Gauss $$#


# In[5]:




#### ZNORMALIZOWANE ####


# In[6]:


class DataProcessing:
    @staticmethod 
    def normalize(x):
        x=x.copy()
        values=x.select_dtypes(exclude="object")
        columnNames=values.columns.tolist()
        columnNames.remove("stress")
        for column in columnNames:
            data=x.loc[:,column]
            max1=max(data)
            min1=min(data)
            for row in range(len(x)):
                newValue=((x.at[row,column]-min1)/(max1-min1))
                x.at[row, column]=newValue
        return x
    
    @staticmethod
    def SplitData(X,x):
        #y to x'
        if x >= 10 or x < 0:
            raise ValueError('Złe x (musi < 1)')
        return X[:math.ceil(len(X)*x)],X[math.ceil(len(X)*(1-x)):]


# In[7]:


pillowNorm=DataProcessing.normalize(dataset)


# In[8]:


X = pillowNorm.iloc[:,:8].values
y = pillowNorm['stress'].values
pillowNorm.head()


# In[9]:


pillowNorm.describe()


# In[10]:


from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.7)


# In[11]:


from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)


# In[12]:


from sklearn.naive_bayes import GaussianNB
classifier = GaussianNB()
classifier.fit(X_train, y_train)


# In[13]:


y_pred = classifier.predict(X_test)


# In[14]:


from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score 
cm = confusion_matrix(y_test, y_pred)
accuracy1=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy1, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[15]:


from sklearn.metrics import make_scorer,precision_score,recall_score,f1_score
accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='macro')
recall =  recall_score(y_test, y_pred,average='macro')
f1 = f1_score(y_test,y_pred,average='macro')
print('accuracy_Naive Bayes: %.3f' %accuracy)
print('precision_Naive Bayes: %.3f' %precision)
print('recall_Naive Bayes: %.3f' %recall)
print('f1-score_Naive Bayes : %.3f' %f1)


# In[16]:




#### NIEZNORMALIZOWANE ####


# In[17]:


X1 = dataset.iloc[:,:8].values
y1 = dataset['stress'].values
dataset.head()


# In[18]:


X_train, X_test, y_train, y_test = train_test_split(X1, y1, test_size = 0.7)
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)


# In[19]:


cm = confusion_matrix(y_test, y_pred)
accuracy2=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy2, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[20]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='micro')
recall =  recall_score(y_test, y_pred,average='micro')
f1 = f1_score(y_test,y_pred,average='micro')
print('accuracy_Naive Bayes: %.3f' %accuracy)
print('precision_Naive Bayes: %.3f' %precision)
print('recall_Naive Bayes: %.3f' %recall)
print('f1-score_Naive Bayes : %.3f' %f1)


# In[21]:


#$$$$ Bernoulli $$$$#


# In[22]:




#### ZNORMALIZOWANE ####


# In[23]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.7)
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)
from sklearn.naive_bayes import BernoulliNB
classifier = BernoulliNB()
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)


# In[24]:


cm = confusion_matrix(y_test, y_pred)
accuracy3=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy3, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[45]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='weighted')
recall =  recall_score(y_test, y_pred,average='weighted')
f1 = f1_score(y_test,y_pred,average='weighted')
print('accuracy_Naive Bayes: %.3f' %accuracy)
print('precision_Naive Bayes: %.3f' %precision)
print('recall_Naive Bayes: %.3f' %recall)
print('f1-score_Naive Bayes : %.3f' %f1)


# In[26]:




#### NIEZNORMALIZOWANE ####


# In[27]:


X_train, X_test, y_train, y_test = train_test_split(X1, y1, test_size = 0.7)
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)


# In[28]:


cm = confusion_matrix(y_test, y_pred)
accuracy4=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy4, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[46]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='weighted')
recall =  recall_score(y_test, y_pred,average='weighted')
f1 = f1_score(y_test,y_pred,average='weighted')
print('accuracy_Naive Bayes: %.3f' %accuracy)
print('precision_Naive Bayes: %.3f' %precision)
print('recall_Naive Bayes: %.3f' %recall)
print('f1-score_Naive Bayes : %.3f' %f1)


# In[30]:


#### Bayes z kolowkium - nienazwany


# In[31]:




#### NIEZNORMALIZOWANE ####


# In[32]:


class NaiveBayes:
    #srednia
    @staticmethod
    def mean(attr):
        try:
            return sum(attr)/len(attr)
        except TypeError:
            print(attr)
            return sum(attr)/len(attr)
        
    #odch stand
    def std(attr):
        mean = NaiveBayes.mean(attr)
        sumelem = 0
        for i in attr:
            sumelem += (i-mean)**2
        return math.sqrt(sumelem/len(attr))
    
    #funkcja
    @staticmethod
    def fun(x, mean, std):
        if mean-math.sqrt(6)*std<=x and x<=std:
            a = x-mean/6*std**2 + 1/math.sqrt(6)*std
        elif mean<x and x<=mean+math.sqrt(6)*std:
            a = -(x-mean/6*std**2) + 1/math.sqrt(6)*std
        else:
            a=0
        return a
    
    #klasyfikacja
    def classify(train,sample):
        #separacja klas z bazy X
        names = train.stress.unique()
        classes = []
        for name in names:
            classes += [train[train['stress'] == name]]
            del classes[-1]['stress']
        #obl sred i odch dla kazdego atrybutu i klasy
        #obl skladowych prawdopodobienstw
        classes_fun = []
        for classy in classes:
            attrs_mean = []
            attrs_std = []
            attrs_fun = []
            for (name, data) in classy.iteritems():
                attrs_mean += [NaiveBayes.mean(data.values)]
                attrs_std += [NaiveBayes.std(data.values)]
                attrs_fun += [NaiveBayes.fun(sample[name],attrs_mean[-1],attrs_std[-1])]
            classes_fun += [np.prod(attrs_fun)]
        return names[classes_fun.index(max(classes_fun))]


# In[33]:


dataset = pd.read_csv('SaYoPillow.csv')
X_train, X_test = DataProcessing.SplitData(dataset,0.7)
correct = 0
for i in range(0,len(X_test)):
    sample = X_test.iloc[i].drop('stress').to_dict()
    if X_test.iloc[i].stress == NaiveBayes.classify(X_train,sample):
        correct += 1
accuracy = correct/len(X_train.index)*100
accuracy5=round(accuracy,2)
print("Accuracy (regul) -",accuracy5,"%")


# In[34]:




#### ZNORMALIZOWANE ####


# In[35]:


dataset = pd.read_csv('SaYoPillow.csv')
datasetnorm = DataProcessing.normalize(dataset)
X_train, X_test = DataProcessing.SplitData(datasetnorm,0.7)
correct = 0
for i in range(0,len(X_test)):
    sample = X_test.iloc[i].drop('stress').to_dict()
    if X_test.iloc[i].stress == NaiveBayes.classify(X_train,sample):
        correct += 1
accuracy = correct/len(X_train.index)*100
accuracy6=round(accuracy,2)
print("Accuracy (regul) -",accuracy6,"%")


# In[36]:


# Bayes zaimplementowany


# In[37]:




#### NIEZNORMALIZOWANE ####


# In[38]:


class NaiveBayes2:
    @staticmethod
    def mean(attr):
        try:
            return sum(attr)/len(attr)
        except TypeError:
            print(attr)
            return sum(attr)/len(attr)
        
    def std(attr):
        mean = NaiveBayes.mean(attr)
        sumelem = 0
        for i in attr:
            sumelem += (i-mean)**2
        return math.sqrt(sumelem/len(attr))
    
    @staticmethod
    def fun2(x, mean, std):
        exponet = np.exp(-(x - mean) ** 2 / (2 * std ** 2))
        return 1 / np.sqrt(2 * np.pi * std ** 2) * exponet
    
    def classify(train,sample):
        names = train.stress.unique()
        classes = []
        for name in names:
            classes += [train[train['stress'] == name]]
            del classes[-1]['stress']
 
        classes_fun = []
        for classy in classes:
            attrs_mean = []
            attrs_std = []
            attrs_fun = []
            for (name, data) in classy.iteritems():
                attrs_mean += [NaiveBayes2.mean(data.values)]
                attrs_std += [NaiveBayes2.std(data.values)]
                attrs_fun += [NaiveBayes2.fun2(sample[name],attrs_mean[-1],attrs_std[-1])]
            classes_fun += [np.prod(attrs_fun)]
        return names[classes_fun.index(max(classes_fun))]


# In[39]:


dataset = pd.read_csv('SaYoPillow.csv')
X_train, X_test = DataProcessing.SplitData(dataset,0.7)
correct = 0
for i in range(0,len(X_test)):
    sample = X_test.iloc[i].drop('stress').to_dict()
    if X_test.iloc[i].stress == NaiveBayes2.classify(X_train,sample):
        correct += 1
accuracy = correct/len(X_train.index)*100
accuracy7=round(accuracy,2)
print("Accuracy (regul) -",accuracy7,"%")


# In[40]:




#### ZNORMALIZOWANE ####


# In[41]:


dataset = pd.read_csv('SaYoPillow.csv')
datasetnorm = DataProcessing.normalize(dataset)
X_train, X_test = DataProcessing.SplitData(datasetnorm,0.7)
correct = 0
for i in range(0,len(X_test)):
    sample = X_test.iloc[i].drop('stress').to_dict()
    if X_test.iloc[i].stress == NaiveBayes2.classify(X_train,sample):
        correct += 1
accuracy = correct/len(X_train.index)*100
accuracy8=round(accuracy,2)
print("Accuracy (regul) -",accuracy8,"%")


# In[42]:


# Porownywanie modeli


# In[43]:


results = pd.DataFrame({
   'Model': [ 'Gauss_z_bibl_n', 
              'Gauss_z_bibl', 
              'Bernoulli_n',
              'Bernoulli',  
              'Beznazwowy', 
              'Beznazwowy_n', 
              'Gauss_wlasny',
              'Gauss_wlasny_n'],
    "Accuracy_score":[accuracy1,
                      accuracy2,
                      accuracy3,
                      accuracy4,
                      accuracy5,
                      accuracy6,
                      accuracy7,
                      accuracy8
                     ]})
result_df = results.sort_values(by='Accuracy_score', ascending=False)
result_df = result_df.reset_index(drop=True)
result_df.head(9)


# In[44]:


plt.subplots(figsize=(15,9))
ax=sns.barplot(x='Model',y="Accuracy_score",data=result_df)
labels = (result_df["Accuracy_score"])
 #add result numbers on barchart
for i, v in enumerate(labels):
    ax.text(i, v+1, str(v), horizontalalignment = 'center', size = 18, color = 'black')


# In[ ]:




