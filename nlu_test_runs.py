import argparse
import os
# getting arguments 
parser = argparse.ArgumentParser(description = "pass file")
parser.add_argument("-f","--file",type = str,help = "directory")
args=parser.parse_args()
path = args.file
list_of_names = []
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
        os.system(f"jupyter nbconvert --to script '{path}' ")
def edit_files(paths):
    """Removes some parts of the file to make it runnable
        
    Keyword arguments:
    paths   -- path of files to convert 
    """
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
                        #list__[tags[0]] =",verbose = True)" 
                        fout.write("".join(list__).encode('ascii', 'ignore').decode('ascii'))
                    elif ("read_csv" in line):
                        line = line.rstrip("\n")
                        line = line+ ".iloc[0:50]\n"
                        fout.write(line.encode('ascii', 'ignore').decode('ascii'))
                    
                   
                    elif ("!" not in line and "os.environ" not in line and "%" not in line):
                        fout.write(line.encode('ascii', 'ignore').decode('ascii'))
            fout.close()
            fin.close()
def run_Files(paths):
    """Runs file and saves output to a file 
        
    Keyword arguments:
    paths   -- path of files to run
    """

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
            if "Error" in line and "UnicodeEncode" not in line and "NoSuchMethod" not in line : 
                fout.write(f"name: {path} \n".encode('ascii', 'ignore').decode('ascii'))
                list_of_names.append(path)
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
paths_For_ipynb = get_path(path,".ipynb")   
make_Files(paths_For_ipynb)
paths_For_txt = get_path(path,".txt")
edit_files(paths_For_txt)   
paths_of_Files_to_run = get_last_path(path,".txt","done")
run_Files(paths_of_Files_to_run)
result_files = get_last_path(path,".txt","result")
check_For_Errors(result_files)
print(list_of_names)
