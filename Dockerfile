FROM ubuntu

WORKDIR   /app/src/new
COPY nlu_test_runs.py .
RUN apt update \
   
	&& apt install -y software-properties-common nano \
  
  	&& add-apt-repository ppa:deadsnakes/ppa \
    
	&& apt update -y \
  
	&& apt install -y python3.6 \
 
	&& apt install -y python3-pip \
    
	&& python3.6 -m pip install nlu \
    
	&& apt-get install -y openjdk-8-jre


RUN echo 'alias python=python3.6' >> ~/.bashrct 
# RUN export PYSPARK_PYTHON=/usr/bin/python3.6

ENV PYSPARK_PYTHON=/usr/bin/python3.6
RUN pip3 install nlu\
 
	&& pip3 install pandas \
	&& apt -y install git \

 	&& git clone https://github.com/JohnSnowLabs/nlu \


	&& pip3 install nbconvert \
   	&& pip3 install wget \
	&& pip3 install matplotlib \
 
	&& pip3 install sklearn \

	&& pip3 install numpy \
 
	&& pip3 install seaborn \

	&& apt -y install nano \

	&& apt-get install wget

CMD ["python3.6", "nlu_test_runs.py","-f","/app/src/new/nlu/examples/colab/Component Examples/Embeddings_for_Sentences/"]
