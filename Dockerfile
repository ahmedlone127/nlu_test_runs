FROM ubuntu:latest
WORKDIR   /app/src/new
COPY nlu_test_runs.py .
COPY nlu_training_multi_class_text_classifier_demo_hotel_reviews.py .
COPY calller_.py .
RUN apt update \
   
	&& apt install -y software-properties-common nano \
  
  	&& add-apt-repository ppa:deadsnakes/ppa \
    
	&& apt update -y \
  
	&& apt install -y python3.6 \
 
	&& apt install -y python3-pip \
    
	&& apt-get install -y openjdk-8-jre\

	&& python3.6 -m   pip install nlu \
	&& python3.6 -m pip install pyspark==2.4.7
ENV PYSPARK_PYTHON=/usr/bin/python3.6
RUN python3.6 -m pip install streamlit 

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

EXPOSE 8501
CMD ["python3.6", "calller_.py"]
