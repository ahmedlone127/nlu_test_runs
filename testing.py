import os

def get_path(directory):
	list_of_path = []
	for root,dirs,files in os.walk(directory):
		for file in files:
			if file.endswith('.ipynb'):
				list_of_path.append(os.path.join(root,file))
	return list_of_path


print(get_path("app/src/new/nlu/examples/colab/Component Examples/"))