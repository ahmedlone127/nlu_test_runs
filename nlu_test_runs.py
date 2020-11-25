import argparse
import os
import nbconvert

# getting arguments 
parser = argparse.ArgumentParser(description = "pass file")
parser.add_argument("-f","--file",type = str,help = "directory")
args=parser.parse_args()
path = args.file

def findOccurrences(s, ch):
	"""Finds Occurences of a character in a string.
	
	Keyword arguments:
	s -- string
	ch -- character
    """
    return [i for i, letter in enumerate(s) if letter == ch]

def get_path(directory,extension):
	"""Finds all specific type of files in given directory.
	
	Keyword arguments:
	direcotry  -- directory to search file for 
	extension -- what kind of file to search for
	"""
	list_of_path = []
	for root,dirs,files in os.walk(directory):
		for file in files:
			if file.endswith(extension):
				list_of_path.append(os.path.join(root,file))# join root and file to form a complete path 
	return list_of_path

def get_last_path(directory,extension,keyword):
	"""Finds all specific type of files in given directory with a specific keyword in their name .
	
	Keyword arguments:
	direcotry  -- directory to search file for 
	extension -- what kind of file to search for
	keyword  -- what keyword should the file name contain 
	"""
	list_of_path = []
	for root,dirs,files in os.walk(directory):
		for file in files:
			if file.endswith(extension) and keyword in file :
				list_of_path.append(os.path.join(root,file))# join root and file to form a complete path
	return list_of_path

def make_Files(paths):
	"""Conerts notebooks to python scripts.
	
	Keyword arguments:
	paths   -- path of files to convert 
	"""
	for path in paths :
		os.system(f"jupyter nbconvert '{path}'  --to script")

def edit_files(paths):
	"""Removes some parts of the file to make it runnable
	
	Keyword arguments:
	paths   -- path of files to convert 
	"""
	for name in paths:
		if "done" not in name:
			fin = open(name, "r+", encoding = "utf-8")

			fout = open(name.replace("txt","done.txt"), "w+",encoding= "utf-8")
			lines = fin.readlines()
			
			fout.write("import wget\n")
			
			for line in lines : 
				if ("wget" in line):#downloads data frame from url 
					url = line.split(" ")
					for adress in url :
						if "http" in adress :
							url = adress
							break
					fout.write(f"wget.download('{url}')\n")
    				
				elif ("pd.read_csv" in line):
					LIST_ =findOccurrences(url,"/")# changes path 
					name =url[LIST_[-1]:]
					fout.write(f"df=pd.read_csv('/app/src/new/{name}')\n")
    					
				elif ("nlu.load(" in line  and "verbose" not in line): #adds verbose to nlu load 
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
	"""Runs file and saves output to a file 
	
	Keyword arguments:
	paths   -- path of files to run
	"""

		for path in paths:
			result_name =path.replace(".done.txt","result.txt")
			try :
				os.system(f"python3 '{path}' > '{result_name}'")
			except Exception as e:# if it fails write error to file 
				fout = open("errors.txt", "a+",encoding= "utf-8")
				fout.write(f"name : {path}")
				fout.write(f"{e}\n")
				fout.write("----------------------------------------------------------------------------------------------------------")
				fout.close()
def check_For_Errors(paths):
	"""Checks whether the output contains any errors and saves errors to a file 
	
	Keyword arguments:
	paths   -- path of files to check errors for 
	"""
	fout = open("errors.txt", "a+",encoding= "utf-8")
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
	fout=open("errors.txt","r+",encoding = "utf-8")
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
