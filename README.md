# description :
this docker container is used to automate the running of notebooks and is mainly used for the purpose of testing. It uses nbconvert along with a python script to convert notebooks into python3 scripts and then runs those scripts and records the results in a txt file, after that it reads the txt files for errors and writes those errors to another txt file.

# Usage:
the main script that handles everything in here is nlu_test_runs.py and it is made up of multiple functions which are all described below
```
python3.6 nlu_test_runs.py -f '{file_to_path}'
```
To start everything call the nlu_test_runs script and pass the path to the jupyter notoebooks as the -f argument 
## findOccurrences
```
def findOccurrences(s, ch):

    return [i for i, letter in enumerate(s) if letter == ch]

```
this function is pretty basic, it takes a string and a character and finds all occurrences of a given character, and returns a list of all the indexes of the occurrences of the character inside the list .it is used in the edit_files function.

## get_path
```
def get_path(directory,extension):
  
	list_of_path = []
	for root,dirs,files in os.walk(directory):
		for file in files:
			if file.endswith(extension):
				list_of_path.append(os.path.join(root,file))# join root and file to form a complete path 
	return list_of_path
```
this function takes a directory and an extensiona and returns a list of paths of all files ending with the given extenison . the get_last_path function is similar to this but it takes a third parameter which is keyword and it returns all the files inside the direrctory whose names have the keyword in them and end with the given extension

## make_Files
```
def make_Files(paths):

	for path in paths :
		os.system(f"jupyter nbconvert '{path}'  --to script")
```
this function takes in a list of paths of jupyter notebooks and makes a python script for each of them

## edit_filse:
```
def edit_files(paths):
	for name in paths:
		save= False
		if "done" not in name:
		    fin = open(name, "r+", encoding = "utf-8")
		    fout = open(name.replace("txt","done.txt"), "w+",encoding= "utf-8")
		    lines = fin.readlines()

		    for line in lines : 

			if ".save(" in line : 
			    save = True
			if save == False:
			    if ("wget" in line):#downloads data frame from url 

					#.encode('ascii', 'ignore').decode('ascii'))
				if "-P" in line:
				    line = line.replace("!","")
				    fout.write(f"os.system('''{line}''')\n".encode('ascii', 'ignore').decode('ascii'))


				elif "-P" not in line:
				    line = line.split(" ")
				    for  i in line :
					if "http" in i : 
					    list_ = findOccurrences(i,"/")
					    name = i
					    name_ = i[list_[-1]:]
					    path_to_file= f"/content{name_}".rstrip("\n")
					    break

				    fout.write(f"os.system('''wget  -P /content {name}''')\n".encode('ascii', 'ignore').decode('ascii'))



			    elif ("nlu.load(" in line  and "verbose" not in line): #adds verbose to nlu load 
				tags = findOccurrences(line,")")
				list__ = list(line)
				list__[tags[0]] =",verbose = True)" 
				fout.write("".join(list__).encode('ascii', 'ignore').decode('ascii'))
			    elif ("read_csv" in line):
				line = line.rstrip("\n")
				line = line+ ".iloc[0:5]\n"
				fout.write(line.encode('ascii', 'ignore').decode('ascii'))
			    elif "import spacy" in line:


				fout.write(line.encode('ascii', 'ignore').decode('ascii'))
				fout.write(f"os.system('''python3.6 -m spacy download en_core_web_sm''')\n".encode('ascii', 'ignore').decode('ascii'))  
			    elif ("!" not in line and "os.environ" not in line and "%" not in line):
				fout.write(line.encode('ascii', 'ignore').decode('ascii'))
		    fout.close()
		    fin.close()
```
the above function takes the patht to the python scripts and removes some of the parts that could crash during execution and makes a new file with all the required changes, it removes the nlu installtion and java enviromet configuration part , it also removes the condifguration for matplotlib . It imports the wget library to download the data frame and replaces the code for downloading with the correct synatx .

## run_Files
```
def run_Files(paths):
		
    for path in paths:

        result_name =path.replace(".done.txt","result.txt")
        #  &> '{result_name}'
        try :
            os.system(f"python3.6 '{path}'  >'{result_name}' 2>&1")
        except Exception as e:# if it fails write error to file 
            fout = open("errors.txt", "a+",encoding= "utf-8")    
            fout.write(f"name : {path}\n".encode('ascii', 'ignore').decode('ascii'))
            fout.write(f"{e}\n".encode('ascii', 'ignore').decode('ascii'))
            fout.write("----------------------------------------------------------------------------------------------------------\n".encode('ascii', 'ignore').decode('ascii'))
            fout.close()
```
This function tries to run the edited files and if they fail it writes them to the error file

## check_For_Errors
```
def check_For_Errors(paths):
    fout = open("errors.txt", "a+",encoding= "utf-8")
    for path in paths :
        fin = open(path, "r+", encoding = "utf-8")
        lines = fin.readlines()
        for line in lines:
            if "Error" in line and "UnicodeEncode" not in line and "NoSuchMethod" not in line : 
                fout.write(f"name: {path} \n".encode('ascii', 'ignore').decode('ascii'))
                fout.write(f"error: ".encode('ascii', 'ignore').decode('ascii'))
                for line in lines :
                    fout.write(f"{line}".encode('ascii', 'ignore').decode('ascii'))
                fout.write("-------------------------------------------------------------------------------------------------- \n".encode('ascii', 'ignore').decode('ascii'))
                break
                
        fin.close()
                        
    fout.close()
    fout=open("errors.txt","r+",encoding = "utf-8")
    lines = fout.readlines()
    for line in lines:
        print(line)
    fout.close()
-
```
this function takes tha paths of the output made by runnin the edited scripts and goes over them to see if they have any errors in them , if it finds an error while scannning the file ,it adds the file's name and error to the error.txt
```

paths_For_ipynb = get_path(path,".ipynb")	
make_Files(paths_For_ipynb)
paths_For_txt = get_path(path,".txt")
edit_files(paths_For_txt)   
paths_of_Files_to_run = get_last_path(path,".txt","done")
run_Files(paths_of_Files_to_run)
result_files = get_last_path(path,".txt","result")
print(result_files)
check_For_Errors(result_files)
```
in the files line we use the get path function and pass the path we got as input and the extension .ipynb to get all the notebooks inside the directory, after that we made python scripts from those notebooks using make_Files . after that we called the get_path function and pass the same path but with the .txt extension to get all the python scripts .then we edit the files and get the paths to the edited files, pass that to run files and scan the output of the run for errors

When running the script we pass in the path of the folder we want to scan for with the -f flag
