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
RUN sudo apt update
RUN sudo apt install software-properties-common
RUN sudo add-apt-repository ppa:deadsnakes/ppa
RUN sudo apt update
RUN sudo apt install python3.7
 



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
