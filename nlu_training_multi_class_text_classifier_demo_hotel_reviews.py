import pickle 	
import os.path
from os import path
import pandas as pd
import nlu

import argparse 
# getting arguments 
parser = argparse.ArgumentParser(description = "Finds best embeddings for a given dataset .")
parser.add_argument("-f","--file",help = "the file contiang the data to train the model on.")
parser.add_argument("-txt","--text",help = " the name of the column containing text in the dataset.")
parser.add_argument("-y","--y_col",help = "the name of the column containg the value we want to predict.")
parser.add_argument("-i","--iloc",help = "how much iloc to use while trainin the model .")
parser.add_argument("-d","--datatype",help = "what kind of data we want to work with ; sentiment or classifer")
parser.add_argument("-e","--embed",help = "list of embeddings to test model on")
args=parser.parse_args()

def find_best_model(file,text,y,iloc,datatype,embed):

	"""Finds best embeddings for a given dataset .
	dataset -- the dataset to train the model on.
	text -- the name of the column containing text in the dataset.
	y -- the name of the column containg the value we want to predict.
	iloc -- how much iloc to use while trainin the model .
	ram -- whether to use heavy or lightweight embeddings .
	datatype -- what kind of data we want to work with ; sentiment or classifer
	embed -- embedding to test on 

	

	"""

	cols =[text,y]
	dataset=pd.read_csv(file)
	dataset= dataset[cols].iloc[:iloc]
	dataset.columns =["text","y"]
	  
	trainable_pipe = nlu.load(f'{embed} train.{datatype}')
	fitted_pipe = trainable_pipe.fit(dataset)
	preds = fitted_pipe.predict(dataset,output_level='document')	
	from sklearn.metrics import f1_score
	score =f1_score(preds['y'], preds['category'],average ="weighted")
	score_model=(embed,score)
	return score_model
def write_to_file(path_of_file,data):
	if path.exists(path_of_file) and os.path.getsize(path_of_file)!= 0:
		with open(path_of_file ,'rb+') as file: 
			results_list = pickle.load(file)
		with open (path_of_file,"wb+") as file :
			results_list.append(data)
			pickle.dump(results_list, file)
	else:
		with open (path_of_file,"wb+") as file :
			pickle.dump([data], file)

score_embed = find_best_model(args.file,args.text,args.y_col,int(args.iloc),args.datatype,args.embed)	
print(score_embed)
write_to_file("results.txt",score_embed)    
