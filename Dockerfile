FROM ubuntu:16.04
WORKDIR   /app/src/new

COPY nlu_test_runs.py .
RUN apt-get update && \
    apt-get install -y curl \
    wget \
    openjdk-8-jdk
# Set JAVA_HOME environment var
ENV JAVA_HOME="/usr/lib/jvm/jre-openjdk"

# Install Python

RUN apt-get update
RUN apt-get install -y software-properties-common vim
RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update

RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv python-dev libssl-dev swig
RUN apt-get install -y git

# update pip
RUN python3.6 -m pip install pip --upgrade
RUN python3.6 -m pip install wheel	
RUN pip install nlu==1.0.4rc3
RUN pip install pandas
RUN apt -y install git
RUN git clone https://github.com/ahmedlone127/github_nlu_test

ENV PYSPARK_PYTHON=python3
RUN pip install nbconvert
RUN pip install wget
RUN pip install matplotlib
RUN pip install sklearn
RUN pip install numpy
RUN pip install seaborn
RUN apt -y install nano
RUN apt -y install wget
CMD ["python3", "nlu_test_runs.py","-f","/app/src/new/github_nlu_test/PUBLIC Github Notebooks/Component Examples/"]
