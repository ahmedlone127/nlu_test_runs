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
RUN apt-get install wget
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN apt update -y
RUN echo 'alias python=python3.6' >> ~/.bashrct 
# RUN export PYSPARK_PYTHON=/usr/bin/python3.6
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"
RUN apt-get update

RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*


ENV PYSPARK_PYTHON=/usr/bin/python3.6
RUN conda install -c johnsnowlabs -c ahmedlone127 -c conda-forge ahmedlones python=3.6 -y
 
RUN	python3.6 -m pip install pandas \
	&& apt install git -y  && rm -rf /var/lib/apt/lists/* \

 	&& git clone https://github.com/JohnSnowLabs/nlu \


	&& python3.6 -m pip install nbconvert \
   	&& python3.6 -m pip install wget \
	&& python3.6 -m pip install matplotlib \
 
	&& python3.6 -m pip install sklearn \

	&& python3.6 -m pip install numpy \
 
	&& python3.6 -m pip install seaborn \

	&& apt -y install nano \
	&& python3.6 -m pip install spacy
	



CMD ["python3.6", "nlu_test_runs.py","-f","/app/src/new/nlu/examples/colab/Component Examples/Matchers/"]
