FROM python:3.7.3-stretch

ADD . /app
WORKDIR /app

#USER thedevilsvoice:thedevilsvoice
RUN \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367;\
apt-get -y update; \
pip install -rrequirements.txt; \
pip install -rmakebook/requirements.txt; \
/usr/local/bin/python3.7 makebook/makebook.py; \
/app/makebook/makebook2.sh;\
#pip install --upgrade pip
sed -i -e 's/stretch/buster/g' /etc/apt/sources.list;\
apt upgrade -y ruby

CMD ["python", "hacker_cookbook/hacker_cookbook.py"]
