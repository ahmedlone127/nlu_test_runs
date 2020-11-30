FROM ubuntu:18.04

# To solve add-apt-repository : command not found
RUN apt-get update -qq 
RUN apt-get install -y openjdk-8-jdk-headless -qq
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update
RUN apt-get install python3.6 libpython3.6

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.5 2
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1

RUN rm /usr/bin/python3
RUN ln -s python3.6 /usr/bin/python3

RUN pip install nlu
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
RUN apt-get install wget
CMD ["python3.6", "nlu_test_runs.py","-f","/app/src/new/github_nlu_test/PUBLIC Github Notebooks/Training/"]
