FROM ubuntu:18.04
WORKDIR   /app/src/new
COPY nlu_test_runs.py .
# ENV Variables
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHON_VERSION="3.6.5"

# Install core packages
RUN apt-get update
RUN apt-get install -y build-essential checkinstall software-properties-common llvm cmake wget git nano nasm yasm zip unzip pkg-config \
    libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev mysql-client default-libmysqlclient-dev

# Install Python 3.6.5
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz \
    && tar xvf Python-${PYTHON_VERSION}.tar.xz \
    && rm Python-${PYTHON_VERSION}.tar.xz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure \
    && make altinstall \
    && cd / \
    && rm -rf Python-${PYTHON_VERSION}
RUN apt-get update && apt-get install -y \
    php5-mcrypt \
    python-pip


RUN apt-get update && apt-get install -y \
    software-properties-common
RUN add-apt-repository universe
RUN apt-get update && apt-get install -y \
    apache2 \
    curl \
    git \
    libapache2-mod-php5 \
    php5 \
    php5-mcrypt \
    php5-mysql \
    python3.4 \
    python3-pip
# Set JAVA_HOME environment var
ENV JAVA_HOME="/usr/lib/jvm/jre-openjdk"

# Install Python





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
RUN apt -y install wget
CMD ["python3", "nlu_test_runs.py","-f","/app/src/new/github_nlu_test/PUBLIC Github Notebooks/Component Examples/"]
