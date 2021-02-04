
import os
from sklearn.metrics import classification_report
  

import nlu

os.system("wget http://ckl-it.de/wp-content/uploads/2021/01/tripadvisor_hotel_reviews.csv")

import pandas as pd
test_path = 'tripadvisor_hotel_reviews.csv'
train_df = pd.read_csv(test_path,sep=",")
cols = ["y","text"]
train_df = train_df[cols]
train_df


from sklearn.metrics import classification_report
from sklearn.metrics import f1_score

trainable_pipe = nlu.load('en.embed_sentence.small_bert_L12_128 train.classifier')
fitted_pipe = trainable_pipe.fit(train_df.iloc[:50])
preds = fitted_pipe.predict(train_df.iloc[:50],output_level='document')
score_= f1_score(preds['y'], preds['category'],average ="weighted")
preds.dropna(inplace=True)


print(score_)

