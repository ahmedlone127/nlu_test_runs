import os
def get_path(directory,extension):
    list_of_path = []
    for root,dirs,files in os.walk(directory):
        for file in files:
            if file.endswith(extension):
                list_of_path.append(os.path.join(root,file))
    return list_of_pat
def findOccurrences(s, ch):
    return [i for i, letter in enumerate(s) if letter == ch]
def run_Files(path):
    
    name = findOccurrences(path,"/")
    result_name = f"/app/src/new/outputs{path[name[-1]:]}"
    os.system(f"python3 '{path}' > '{result_name}'")

def check_For_Errors(path):
    fout = open("erros.txt", "w+",encoding= "utf-8")
     
    fin = open(paths, "r+", encoding = "utf-8")
            #output file to write the result to
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

#print(get_path("app/src/new/nlu/examples/colab/Component Examples/"))	
  

run_Files("/app/src/new/nlu/examples/colab/Component Examples/Classifiers/nano NLU_Question_Classification_Example\\ .done.txt")
result_files = get_path("/app/src/new/result/",".txt")
check_For_Errors(result_files)