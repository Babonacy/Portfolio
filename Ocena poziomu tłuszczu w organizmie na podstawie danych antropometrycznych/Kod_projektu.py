#!/usr/bin/env python
# coding: utf-8

# In[9]:


import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import math
from collections import Counter
from sklearn.naive_bayes import GaussianNB
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import StandardScaler
from sklearn import model_selection
from sklearn.model_selection import train_test_split
from sklearn.metrics import make_scorer,precision_score,recall_score,f1_score
from sklearn.metrics import classification_report
from sklearn.metrics import confusion_matrix
from sklearn.metrics import accuracy_score


# In[10]:


da=pd.read_csv('dane_antropo_13.csv')
di=pd.read_csv('dane_inbody.csv')


# In[11]:


da


# In[12]:


di


# In[13]:


diid=di.iloc[:,0]
diBFM=di.iloc[:,25]
diBFMlow=di.iloc[:,26]
diBFMup=di.iloc[:,27]
dane=pd.DataFrame({"id":diid,"BFM":diBFM, "BFM_LowLim":diBFMlow, "BFM_UpLim":diBFMup})
dane


# In[14]:


class tworzenie:
    @staticmethod
    def zamiany(x):
        for i in range(len(x)):
            low=x.iloc[i,2]
            up=x.iloc[i,3]
            if low>up:
                x.iloc[i,2]=up
                x.iloc[i,3]=low
        return x
    
    @staticmethod
    def klasa(x):
        for i in range(len(x)):
            low=x.iloc[i,2]
            up=x.iloc[i,3]
            bfm=x.iloc[i,1]
            if bfm<low:
                x.iloc[i,1]=0
            elif bfm>up:
                x.iloc[i,1]=2
            else:
                x.iloc[i,1]=1
        return x


# In[15]:


dane2=tworzenie.zamiany(dane)
dane2


# In[16]:


# czyszczenie rekordów niewłaściwych
beforeCleaningCount = dane2.shape[0]

# usuwanie osób z ilością tłuszczu powyżej 30
dane2 = dane2[dane2.BFM < 30]
# usuwanie osób z ilością tłuszczu poniżej 2
dane2 = dane2[dane2.BFM > 2]

# dane do filtrowania bfm
# https://www.mdpi.com/2227-9067/8/5/366/html
# https://academic.oup.com/advances/article/5/3/320S/4562745?fbclid=IwAR2uOMZ3gcqXruv7ORBiMwDDUu2mSzKWKkSPX5lFdRmupuZpUP2m72H56mI&login=false


# In[17]:


dane3=tworzenie.klasa(dane2)
dane3


# In[18]:


dane3=dane3.drop(['BFM_LowLim', 'BFM_UpLim'], axis=1)
dane3


# In[19]:


wynikowyAntro=pd.merge(da, dane3, how="inner", left_index=True, right_index=True)

wynikowyAntro.head()


# In[20]:


# usuwanie osób z ciśnieniem skurczowym poniżej 60
wynikowyAntro = wynikowyAntro[wynikowyAntro.CisnienieKrwiSkurczowe > 60]
# usuwanie osób z ciśnieniem rozkurczowym poniżej 30
wynikowyAntro = wynikowyAntro[wynikowyAntro.CisnienieKrwiRozkurczowe > 30]
# usuwanie osób z ciśnieniem skurczowym powyżej 181
wynikowyAntro = wynikowyAntro[wynikowyAntro.CisnienieKrwiSkurczowe < 181]
# usuwanie osób z ciśnieniem rozkurczowym powyżej 111
wynikowyAntro = wynikowyAntro[wynikowyAntro.CisnienieKrwiRozkurczowe < 111]
# usuwanie osób z tętnem krwi powyżej 110
wynikowyAntro = wynikowyAntro[wynikowyAntro.TetnoKrwi < 110]
# usuwanie osób z tętnem krwi poniżej 50
wynikowyAntro = wynikowyAntro[wynikowyAntro.TetnoKrwi > 50]
#usuwanie/naprawianie błędnego pomiaru
wynikowyAntro.drop(483, axis=0, inplace=True)
wynikowyAntro.drop(346, axis=0, inplace=True)
wynikowyAntro.drop(162, axis=0, inplace=True)

# dane do filtrowania cisnienia i tetna
# https://www.mayoclinic.org/diseases-conditions/low-blood-pressure/symptoms-causes/syc-20355465
# https://apteline.pl/artykuly/prawidlowy-puls-za-niski-puls-tetno-prawidlowe-tetno-spoczynkowe-za-wysoki-puls


# In[21]:


# po filtrowaniu z bazy zostaje usunięte:
print(f"Dzięki filtrowaniu usunięto: {beforeCleaningCount - wynikowyAntro.shape[0]} rekordów, z {beforeCleaningCount} pozostało {wynikowyAntro.shape[0]}")


# In[22]:


dane0=wynikowyAntro
# usuwanie zbednych kolumn
dane0=dane0.drop(['id_x', 'data.badania', 'DataBadania', 'id_y'], axis=1)
dane0


# In[23]:


dane0.describe()


# In[24]:


list1 = dane0.iloc[0: ,19]
print("Ilosc klas w aktualnej bazie: ",Counter(list1))


# In[25]:


# Normalizacja


# In[26]:


zapas=dane0[['BFM']]
dane0=dane0.drop(['BFM'], axis=1)


# In[31]:


dane0_n_n = MinMaxScaler().fit_transform(dane0)
dane0_n=pd.DataFrame(data=dane0_n_n, columns=list(dane0.columns.values))
dane0_n.insert(19,'BFM',zapas)
dane0_n


# In[32]:


dane0_n.describe()


# In[33]:


# Klasyfikacja


# In[34]:


X = dane0_n.iloc[:,:19].values
y = dane0_n['BFM'].values


# In[35]:


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.7)


# In[36]:


sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)


# In[37]:


classifier = GaussianNB()
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)
cm = confusion_matrix(y_test, y_pred)
accuracy1=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy1, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[38]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='macro')
recall =  recall_score(y_test, y_pred,average='macro')
f1 = f1_score(y_test,y_pred,average='macro')
print('accuracy: %.3f' %accuracy)
print('precision: %.3f' %precision)
print('recall: %.3f' %recall)
print('f1-score : %.3f' %f1)


# In[39]:


classifier = LogisticRegression()
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)
cm = confusion_matrix(y_test, y_pred)
accuracy2=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy2, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[40]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='macro')
recall =  recall_score(y_test, y_pred,average='macro')
f1 = f1_score(y_test,y_pred,average='macro')
print('accuracy: %.3f' %accuracy)
print('precision: %.3f' %precision)
print('recall: %.3f' %recall)
print('f1-score : %.3f' %f1)


# In[41]:


classifier = KNeighborsClassifier()
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)
cm = confusion_matrix(y_test, y_pred)
accuracy3=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy3, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[42]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='macro')
recall =  recall_score(y_test, y_pred,average='macro')
f1 = f1_score(y_test,y_pred,average='macro')
print('accuracy: %.3f' %accuracy)
print('precision: %.3f' %precision)
print('recall: %.3f' %recall)
print('f1-score : %.3f' %f1)


# In[43]:


classifier = DecisionTreeClassifier()
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)
cm = confusion_matrix(y_test, y_pred)
accuracy4=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy4, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[44]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='macro')
recall =  recall_score(y_test, y_pred,average='macro')
f1 = f1_score(y_test,y_pred,average='macro')
print('accuracy: %.3f' %accuracy)
print('precision: %.3f' %precision)
print('recall: %.3f' %recall)
print('f1-score : %.3f' %f1)


# In[45]:


classifier = RandomForestClassifier()
classifier.fit(X_train, y_train)
y_pred = classifier.predict(X_test)
cm = confusion_matrix(y_test, y_pred)
accuracy5=round(accuracy_score(y_test, y_pred)*100 ,2)
print ("Accuracy : ", accuracy5, "%")
sns.heatmap(cm, annot=True)
plt.show()


# In[46]:


accuracy = accuracy_score(y_test,y_pred)
precision =precision_score(y_test, y_pred,average='macro')
recall =  recall_score(y_test, y_pred,average='macro')
f1 = f1_score(y_test,y_pred,average='macro')
print('accuracy: %.3f' %accuracy)
print('precision: %.3f' %precision)
print('recall: %.3f' %recall)
print('f1-score : %.3f' %f1)


# In[47]:


results = pd.DataFrame({
   'Model': [ 'Bayes', 
              'LogisticRegression',
              'KNeighbors',
              'DecisionTree',
              'RandomForest'],
    "Accuracy_score":[accuracy1,
                      accuracy2,
                      accuracy3,
                      accuracy4,
                      accuracy5
                     ]})


# In[48]:


result_df = results.sort_values(by='Accuracy_score', ascending=False)
result_df = result_df.reset_index(drop=True)
plt.subplots(figsize=(15,9))
ax=sns.barplot(x='Model',y="Accuracy_score",data=result_df)
labels = (result_df["Accuracy_score"])

for i, v in enumerate(labels):
    ax.text(i, v+1, str(v), horizontalalignment = 'center', size = 14, color = 'black')


# In[ ]:




