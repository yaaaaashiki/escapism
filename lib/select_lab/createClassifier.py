import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
# from sklearn.feature_extraction.text import CountVectorizer
from sklearn.grid_search import GridSearchCV
from sklearn.pipeline import Pipeline
from sklearn.linear_model import LogisticRegression
from sklearn.feature_extraction.text import TfidfVectorizer
import MeCab
import re
from nltk.corpus import stopwords
from nltk.stem.porter import PorterStemmer
import pickle
import os

def preprocesor(text):
  return re.sub('[\W]+', ' ', text)

def tokenizer(text):
  return text.split()

porter = PorterStemmer()
def tokenizer_porter(text):
  return [porter.stem(word) for word in text.split()]


df = pd.read_csv('./thesis_data.csv')
df = df.dropna()

class_mapping = {label:idx for idx, label in enumerate(np.unique(df['labName']))}
df['labName'] = df['labName'].map(class_mapping)
inv_class_mapping = {v: k for k, v in class_mapping.items()}

text = df['text']
tagger = MeCab.Tagger("-Owakati")
for i in range(len(text.values)):
  text.values[i] = tagger.parse(text.values[i])

# count = CountVectorizer()
# bag = count.fit_transform(text)

# print(count.vocabulary_)
# print(bag.toarray())

df['text'] = df['text'].apply(preprocesor)

stop = stopwords.words('english')

tfidf = TfidfVectorizer(strip_accents=None,
                        preprocessor=None)
param_grid = [{'vect__ngram_range': [(1, 1)],
               'vect__stop_words': [stop, None],
               'vect__tokenizer': [tokenizer, tokenizer_porter],
               'clf__penalty': ['l1', 'l2'],
               'clf__C': [1.0, 10.0, 100.0]},
              {'vect__ngram_range': [(1, 1)],
               'vect__stop_words': [stop, None],
               'vect__tokenizer': [tokenizer, tokenizer_porter],
               'vect__use_idf':[False],
               'vect__norm':[None],
               'clf__penalty': ['l1', 'l2'],
               'clf__C': [1.0, 10.0, 100.0]},
              ]

lr_tfidf = Pipeline([('vect', tfidf),
                     ('clf', LogisticRegression(random_state=0))])

gs_lr_tfidf = GridSearchCV(lr_tfidf, param_grid,
                           scoring='accuracy',
                           cv=5,
                           verbose=1,
                           n_jobs=-1)

# 192個の論文データ
df = df.reindex(np.random.permutation(df.index))
X_train = df.loc[:, 'text'].values
Y_train = df.loc[:, 'labName'].values
X_test = df.loc[:, 'text'].values
Y_test = df.loc[:, 'labName'].values
gs_lr_tfidf.fit(X_train, Y_train)

print('Best parameter set: %s ' % gs_lr_tfidf.best_params_)
print('CV Accuracy: %.3f' % gs_lr_tfidf.best_score_)
clf = gs_lr_tfidf.best_estimator_
print('test Accuracy: %.3f' % clf.score(X_test, Y_test))

dest = os.path.join('lab_classifier', 'pkl_objects')
if not os.path.exists(dest):
    os.makedirs(dest)

pickle.dump(stop,
            open(os.path.join(dest, 'stopwords.pkl'), 'wb'),
            protocol=4)
pickle.dump(clf,
            open(os.path.join(dest, 'classifier.pkl'), 'wb'),
            protocol=4)
pickle.dump(inv_class_mapping,
            open(os.path.join(dest, 'inv_class_mapping.pkl'), 'wb'),
            protocol=4)
print('saved!!')