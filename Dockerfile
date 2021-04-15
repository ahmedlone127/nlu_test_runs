FROM ubuntu:latest
WORKDIR   /app/src/new
COPY nlu_test_runs.py .
ENV   LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
RUN apt update \
   
	&& apt install -y software-properties-common nano \
  
  	&& add-apt-repository ppa:deadsnakes/ppa \
    
	&& apt update -y \
  
	&& apt install -y python3.6 \
 
	&& apt install -y python3-pip \
    
    
	&& apt-get install -y openjdk-8-jre
RUN echo 'alias python=python3.6' >> ~/.bashrct 
# RUN export PYSPARK_PYTHON=/usr/bin/python3.6

ENV PYSPARK_PYTHON=/usr/bin/python3.6
RUN python3.6 -m pip install   pip install --index-url https://test.pypi.org/simple/ --extra-index-url https://pypi.org/simple peanut_butter_data_time==3.0.0rc7 \
	&& python3.6 -m pip install  pyspark==3.0.1 spark-nlp==3.0.1 \
	&& python3.6 -m pip install pandas \
	&& apt -y install git \
 	&& git clone https://github.com/JohnSnowLabs/nlu\
	&& python3.6 -m pip install nbconvert \
   	&& python3.6 -m pip install wget \
	&& python3.6 -m pip install matplotlib \
 
	&& python3.6 -m pip install sklearn \
	&& python3.6 -m pip install numpy \
 
	&& python3.6 -m pip install seaborn \
	&& apt -y install nano \
	&& python3.6 -m pip install spacy\
	&& python3.6 -m spacy download en_core_web_sm\
	
	&& apt-get install wget
CMD ["python3.6", "nlu_test_runs.py","-f","/app/src/new/nlu/examples/colab/component_examples/"]
