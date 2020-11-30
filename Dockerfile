FROM ubuntu:latest
WORKDIR   /app/src/new

COPY nlu_test_runs.py .
# To solve add-apt-repository : command not found
RUN apt-get update -qq 
RUN apt-get install -y openjdk-8-jdk-headless -qq
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update
RUN apt-get install -y python3.6 libpython3.6
RUN apt-get install -y python3-pip
RUN rm /usr/bin/python3
RUN ln -s python3.6 /usr/bin/python3

RUN pip3 install nlu
RUN pip3 install pandas
RUN apt -y install git
RUN git clone https://github.com/ahmedlone127/github_nlu_test

ENV PYSPARK_PYTHON=python3
RUN pip3 install nbconvert
RUN pip3 install wget
RUN pip3 install matplotlib
RUN pip3 install sklearn
RUN pip3 install numpy
RUN pip3 install seaborn
RUN apt -y install nano
RUN apt-get install wget
CMD ["python3.6", "nlu_test_runs.py","-f","/app/src/new/github_nlu_test/PUBLIC Github Notebooks/Training/"]
