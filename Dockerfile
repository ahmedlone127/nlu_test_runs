FROM ubuntu:18.04
RUN apt update \
   
	&& apt install -y software-properties-common nano \
  
  	&& add-apt-repository ppa:deadsnakes/ppa \
    
	&& apt update -y \
  
	&& apt install -y python3.6 \
 
	&& apt install -y python3-pip \
	&& python3.6 - m pip install --upgrade setuptools.\
    
	&& apt-get install -y openjdk-8-jre\

	&& python3.6 -m   pip install nlu \
	&& python3.6 -m pip install pyspark==2.4.7
ENV PYSPARK_PYTHON=/usr/bin/python3.6
RUN python3.6 -m pip install streamlit 

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

EXPOSE 8501
