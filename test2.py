import argparse
import os
import nbconvert
from IPython import get_ipython

parser = argparse.ArgumentParser(description = "pass file")
parser.add_argument("-f","--file",type = str,help = "directory")
args=parser.parse_args()
path = args.file

def findOccurrences(s, ch):
    return [i for i, letter in enumerate(s) if letter == ch]

def get_path(directory,extension):
	list_of_path = []
	for root,dirs,files in os.walk(directory):
		for file in files:
			if file.endswith(extension):
				list_of_path.append(os.path.join(root,file))
	return list_of_path

def get_last_path(directory,extension,keyword):
	list_of_path = []
	for root,dirs,files in os.walk(directory):
		for file in files:
			if file.endswith(extension) and keyword in file :
				list_of_path.append(os.path.join(root,file))
	return list_of_path

def make_Files(paths):
	for path in paths :
		os.system(f"jupyter nbconvert '{path}'  --to script")

def edit_files(paths):

	for name in paths:
		if "done" not in name:
			fin = open(name, "r+", encoding = "utf-8")

			fout = open(name.replace("txt","done.txt"), "w+",encoding= "utf-8")
			lines = fin.readlines()
			fout.write("import wget\n")
			fout.write("from IPython import get_ipython\n")
			for line in lines : 
				if ("wget" in line):
					url = line.split(" ")
					for adress in url :
						if "http" in adress :
							url = adress
							break
					fout.write(f"wget.download('{url}')\n")
    				
				elif ("pd.read_csv" in line):
					LIST_ =findOccurrences(url,"/")
					name =url[LIST_[-1]:]
					fout.write(f"df=pd.read_csv('/app/src/new/{name}')\n")
    					
				elif ("nlu.load(" in line  and "verbose" not in line):
					tags = findOccurrences(line,")")
					list__ = list(line)
					list__[tags[0]] =",verbose = True)" 
					fout.write("".join(list__).encode('ascii', 'ignore').decode('ascii'))
					print("".join(list__).encode('ascii', 'ignore').decode('ascii'))
				elif ("!" not in line and "os.environ" not in line and "%" not in line):
					fout.write(line)
		fout.close()
		fin.close()

def run_Files(paths):
	for path in paths[-2:-1]:
		result_name =path.replace(".done.txt","result.txt")
		os.system(f"python3 '{path}' > '{result_name}'")
def check_For_Errors(paths):
	fout = open("erros.txt", "a+",encoding= "utf-8")
	for path in paths :
		fin = open(path, "r+", encoding = "utf-8")
		lines = fin.readlines()
		for line in lines:
			
			if "Error" in line: 
				fout.write(f"name: {path} \n")
				fout.write(f"error: \n")
				for line in lines :
					fout.write(f"{line}\n")
				fout.write("-------------------------------------------------------------------------------------------------- \n")
				break
		fin.close()
	
	fout.close()
	fout=open("erros.txt","r+",encoding = "utf-8")
	lines = fout.readlines()
	for line in lines:
		print(line)
	fout.close()
def readfiles(files):
	for file in files[-2:-1]:
		fout = open(file,"r+",encoding ="utf-8")
		lines = fout.readlines()
		for line in lines:
			print(line)
		fout.close()
paths_For_ipynb = get_path(path,".ipynb")	
make_Files(paths_For_ipynb)
paths_For_txt = get_path(path,".txt")
edit_files(paths_For_txt)   
paths_of_Files_to_run = get_last_path(path,".txt","done")
run_Files(paths_of_Files_to_run)
result_files = get_last_path(path,".txt","result")
print(result_files)
check_For_Errors(result_files)
readfiles(paths_of_Files_to_run)
