FROM python:3.8.1-buster

ADD . /app
WORKDIR /app

#USER thedevilsvoice:thedevilsvoice
RUN \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367;\
DEBIAN_FRONTEND=noninteractive apt update; \
DEBIAN_FRONTEND=noninteractive apt install -y apt-utils;\
DEBIAN_FRONTEND=noninteractive apt upgrade -y; \
DEBIAN_FRONTEND=noninteractive apt -y autoremove;\
DEBIAN_FRONTEND=noninteractive apt install -y ruby-full pandoc

RUN \ 
pip install -rpython/requirements.txt; \
pip install -rmakebook/requirements.txt; \
/usr/local/bin/python3.8 makebook/makebook.py; \
/app/makebook/makebook2.sh

CMD ["python", "hacker_cookbook/hacker_cookbook.py"]
