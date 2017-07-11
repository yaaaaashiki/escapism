import MeCab
import numpy as np
import os
import pandas as pd
import pickle
import re
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfTransformer
from sklearn.grid_search import GridSearchCV
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import Pipeline

def preprocesor(text):
  return re.sub('[\W]+', ' ', text)

def tokenizer(text):
  return text.split()

def read_thesis_data(path):
  thesis_data = pd.read_csv(path)
  return thesis_data.dropna()

thesis_data = read_thesis_data('./thesis_data.csv')

class_mapping = {label:idx for idx, label in enumerate(np.unique(thesis_data['labName']))}
inv_class_mapping = {v: k for k, v in class_mapping.items()}
thesis_data['labName'] = thesis_data['labName'].map(class_mapping)

tagger = MeCab.Tagger("-Owakati")
for i in range(len(thesis_data['text'])):
  thesis_data['text'].values[i] = tagger.parse(thesis_data['text'].values[i])

thesis_data['text'] = thesis_data['text'].apply(preprocesor)

# サンプル数196 train:test= 7:3 -> 138, 8:2 -> 164
thesis_data = thesis_data.reindex(np.random.permutation(thesis_data.index))
X_train = thesis_data.loc[:, 'text'].values
Y_train = thesis_data.loc[:, 'labName'].values
X_test = thesis_data.loc[:, 'text'].values
Y_test = thesis_data.loc[:, 'labName'].values

text_clf = Pipeline([('vect', CountVectorizer(ngram_range=(1, 2))),
                     ('tfidf', TfidfTransformer()),
                     ('clf', MultinomialNB()),
])

parameters = {'clf__alpha': (1e-1, 1e-2, 1e-3),}

gs_clf = GridSearchCV(text_clf, parameters, n_jobs=-1)

print('creating classifire ...')
gs_clf = gs_clf.fit(X_train, Y_train)

clf = gs_clf.best_estimator_
print('CV Accuracy: %.3f' % gs_clf.best_score_)
print('Test Accuracy: %.3f' % clf.score(X_test, Y_test))

for param_name in sorted(parameters.keys()):
    print("%s: %r" % (param_name, gs_clf.best_params_[param_name]))

dest = os.path.join('lab_classifier', 'pkl_objects')
if not os.path.exists(dest):
    os.makedirs(dest)

pickle.dump(clf,
            open(os.path.join(dest, 'classifier.pkl'), 'wb'),
            protocol=4)
pickle.dump(inv_class_mapping,
            open(os.path.join(dest, 'inv_class_mapping.pkl'), 'wb'),
            protocol=4)

print('created!!')
