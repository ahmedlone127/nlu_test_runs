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
RUN python3.6 -m pip install nlu\
 
	&& python3.6 -m pip install pandas \
	&& apt -y install git \

 	&& git clone https://github.com/JohnSnowLabs/nlu \


	&& python3.6 -m pip install nbconvert \
   	&& python3.6 -m pip install wget \
	&& python3.6 -m pip install matplotlib \
 
	&& python3.6 -m pip install sklearn \

	&& python3.6 -m pip install numpy \
 
	&& python3.6 -m pip install seaborn \

	&& apt -y install nano \
	&& python3.6 -m pip install spacy\
	

	&& apt-get install wget
RUN wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
RUN bash Anaconda3-5.0.1-Linux-x86_64.sh -b
RUN rm Anaconda3-5.0.1-Linux-x86_64.sh

# Set path to conda
#ENV PATH /root/anaconda3/bin:$PATH
ENV PATH /home/ubuntu/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all

CMD ["python3.6", "nlu_test_runs.py","-f","/app/src/new/nlu/examples/colab/"]
