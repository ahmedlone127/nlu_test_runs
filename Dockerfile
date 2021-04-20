FROM ubuntu:latest
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
RUN python3.6 -m pip install  pyspark==2.4.4
