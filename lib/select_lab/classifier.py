import pandas as pd
import numpy as np
import MeCab
import re
import pickle
import os
import sys

def tokenizer(text):
  return text.split()

def preprocesor(text):
  return re.sub('[\W]+', ' ', text)

def vectorize(texts):
  tagger = MeCab.Tagger("-d /usr/local/lib/mecab/dic/mecab-ipadic-neologd -Owakati")
  for i in range(len(texts.values)):
    texts.values[i] = tagger.parse(texts.values[i])
  
  return texts.apply(preprocesor)
  
def predict(text):
  curDir = os.path.abspath(os.path.dirname(__file__))
  clf = pickle.load(open(os.path.join(curDir, 'lab_classifier', 'pkl_objects', 'classifier.pkl'), 'rb'))
  inv_class_mapping = pickle.load(open(os.path.join(curDir, 'lab_classifier', 'pkl_objects', 'inv_class_mapping.pkl'), 'rb'))
  
  x = pd.DataFrame([text], columns=['text'])
  x = vectorize(x['text'])
  ans = clf.predict(x)
  ansdf = pd.DataFrame(ans, columns=['label'])
  return ansdf['label'].map(inv_class_mapping)

args = sys.argv
ans = predict(args[1])
print(ans[0])