FROM ubuntu:latest
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
RUN python3.6 -m pip install  nlu==1.1.1.rc1  \
	&& python3.6 -m pip install pyspark==2.4.7\

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
	
	&& apt-get install wget
#CMD ["python3.6", "nlu_test_runs.py","-f","/app/src/new/nlu/examples/colab"]
CMD ["python3.6", "nlu_training_multi_class_text_classifier_demo_hotel_reviews.py""]
