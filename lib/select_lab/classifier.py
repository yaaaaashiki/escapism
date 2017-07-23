import pandas as pd
import numpy as np
import MeCab
import re
import pickle
import os
import sys
from subprocess import Popen, PIPE

MeCab_DIR = '''echo `mecab-config --dicdir`"/mecab-ipadic-neologd"'''

def tokenizer(text):
  return text.split()

def preprocesor(text):
  return re.sub('[\W]+', ' ', text)

def vectorize(texts):
  terminal = Popen(MeCab_DIR, stdout=PIPE, stdin=PIPE, shell=True)
  neologd_dir, dummy = terminal.communicate()
  neologd_dir = neologd_dir.decode('utf-8')
  neologd_dir = re.sub('\n','',neologd_dir)
  tagger = MeCab.Tagger("-d " + neologd_dir + " -Owakati")
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