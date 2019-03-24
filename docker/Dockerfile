FROM python:3.6
ADD . /app
WORKDIR /app
#USER thedevilsvoice:thedevilsvoice

#RUN pip install --upgrade pip
RUN pip install -rrequirements.txt
CMD ["python", "hacker_cookbook/hacker_cookbook.py"]