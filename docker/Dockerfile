FROM python:3.8.2-buster

ADD . /app
WORKDIR /app

#USER thedevilsvoice:thedevilsvoice
RUN \
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367;\
DEBIAN_FRONTEND=noninteractive apt update; \
DEBIAN_FRONTEND=noninteractive apt install -y apt-utils;\
DEBIAN_FRONTEND=noninteractive apt -y autoremove;\
DEBIAN_FRONTEND=noninteractive apt install -y ruby-full pandoc

RUN \ 
pip install -rpython/requirements.txt; \
pip install -rpython/requirements-sphinx.txt; \
DEBIAN_FRONTEND=noninteractive apt install -y texlive-latex-extra latexmk

# Run the Flask app locally on port 5000
CMD ["python", "hacker_cookbook/hacker_cookbook.py"]
