FROM centos:7

WORKDIR   /app/src/new

COPY nlu_test_runs.py .
# Install Java
RUN yum update -y \
&& yum install java-1.8.0-openjdk -y \
&& yum clean all \
&& rm -rf /var/cache/yum

# Set JAVA_HOME environment var
ENV JAVA_HOME="/usr/lib/jvm/jre-openjdk"

# Install Python
RUN yum install python3 -y \
&& pip3 install --upgrade pip setuptools wheel \
&& if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi \
&& if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi \
&& yum clean all \	
&& rm -rf /var/cache/yum
	
RUN pip install nlu==1.0.4rc3
RUN pip install pandas
RUN yum -y install git
RUN git clone https://github.com/ahmedlone127/github_nlu_test

ENV PYSPARK_PYTHON=python3
RUN pip install nbconvert
RUN pip install wget
RUN pip install matplotlib
RUN pip install sklearn
RUN pip install numpy
RUN pip install seaborn
RUN yum -y install nano
CMD ["python3", "nlu_test_runs.py","-f","/app/src/new/github_nlu_test/PUBLIC Github Notebooks/Component Examples/Embeddings_for_Sentences/"]
