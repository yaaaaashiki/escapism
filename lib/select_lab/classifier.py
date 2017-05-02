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
  tagger = MeCab.Tagger("-Owakati")
  for i in range(len(texts.values)):
    texts.values[i] = tagger.parse(texts.values[i])
  
  return texts.apply(preprocesor)
  
def predict(text):
  clf = pickle.load(open(os.path.join('lab_classifier', 'pkl_objects', 'classifier.pkl'), 'rb'))
  inv_class_mapping = pickle.load(open(os.path.join('lab_classifier', 'pkl_objects', 'inv_class_mapping.pkl'), 'rb'))
  
  x = pd.DataFrame([text], columns=['text'])
  x = vectorize(x['text'])
  ans = clf.predict(x)
  ansdf = pd.DataFrame(ans, columns=['label'])
  return ansdf['label'].map(inv_class_mapping)

args = sys.argv
print(predict(args[1]))

# 以下簡単な確認に使用(削除してもOK)
# print('適当')
# x = pd.DataFrame(['機械学習',
# 'ロボット',
# '鬼ごっこ',
# 'ruby',
# 'oculus',
# 'java',
# '人工知能',
# 'ジェスチャ',
# '設計',
# '仮想現実'], columns=['text'])
# print(predict(x))

# print('マーティン')
# x = pd.DataFrame(['Martin'
# 'ウェブ',
# 'インターネット',
# 'プログラミング'], columns=['text'])
# print(predict(x))

# print('小宮山')
# x = pd.DataFrame(['Komiyama',
# 'ヒューマンインターフェース',
# 'ヒューマンコンピュータインタラクション',
# 'バーチャルリアリティ',
# '認知心理学',
# '音響信号処理',
# '福祉工学'], columns=['text'])
# print(predict(x))

# print('鷲見')
# x = pd.DataFrame(['Sumi',
# '画像情報科学',
# 'セキュリティ',
# 'リモートセンシング',
# 'ヒューマンセンシング'], columns=['text'])
# print(predict(x))

# print('原田')
# x = pd.DataFrame(['Harada',
# '自然言語処理',
# '質問応答',
# 'テキストマイニング',
# 'プログラム自動生成',
# '機械学習'], columns=['text'])
# print(predict(x))

# print('Lopez')
# x = pd.DataFrame(['Lopez',
# 'ウェアラブルコンピューティング',
# 'マルチメディアデバイス',
# '人間情報工学',
# '環境情報工学'], columns=['text'])
# print(predict(x))

# print('豊田')
# x = pd.DataFrame(['Toyota',
# 'webデータマイニング',
# '教育・学習支援システム開発'], columns=['text'])
# print(predict(x))

# print('松原')
# x = pd.DataFrame(['Matubara',
# '形式言語',
# '計算可能性',
# '計算複雑性'], columns=['text'])
# print(predict(x))

# print('米沢')
# x = pd.DataFrame(['Yonezawa',
# '移動ロボット',
# '非ホロノミックシステム',
# '協調搬送',
# '自律分散システム'], columns=['text'])
# print(predict(x))

# print('大原')
# x = pd.DataFrame(['Ohara',
# 'データマイニング',
# '推薦システム',
# '統計モデルの推定'], columns=['text'])
# print(predict(x))

# print('佐久田')
# x = pd.DataFrame(['Sakuta',
# '設計情報工学',
# '数値解析システム',
# '成形プラスチック歯車',
# '図形科学教育システム',
# 'e-learning'], columns=['text'])
# print(predict(x))

# print('戸部')
# x = pd.DataFrame(['Tobe',
# '情報ネットワーク',
# 'センシングネットワーク',
# '実世界コンピューティング',
# '人間情報インターフェース'], columns=['text'])
# print(predict(x))

# print('山口')
# x = pd.DataFrame(['Yamaguci',
# 'ロボット工学',
# '制御工学',
# '非線形制御理論',
# 'ロボットモーションプランニング',
# '波動歩行機械',
# '多重連結車両',
# '微分器科学的アプローチ'], columns=['text'])
# print(predict(x))

# print('高橋')
# x = pd.DataFrame(['Takahasi',
# 'ヒューマンマシンインタラクション'], columns=['text'])
# print(predict(x))

# print('長谷川')
# x = pd.DataFrame(['Hasegawa',
# 'ヒューマンエージェントインタラクション'], columns=['text'])
# print(predict(x))

# print('盛川')
# x = pd.DataFrame(['Morikawa',
# '人間工学',
# 'ヒューマンインターフェース',
# 'バーチャルリアリティ'], columns=['text'])
# print(predict(x))