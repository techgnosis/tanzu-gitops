FROM python:3

RUN pip install locust

COPY locustfile.py /usr/src/myapp/locustfile.py

WORKDIR /usr/src/myapp

EXPOSE 8089

CMD "locust"
