FROM ubuntu:16.04

# To solve add-apt-repository : command not found
RUN apt-get update -qq 
RUN apt-get install -y openjdk-8-jdk-headless -qq
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


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
