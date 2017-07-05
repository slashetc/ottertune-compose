FROM tensorflow/tensorflow

RUN apt-get update && apt-get install git python-pip python-dev python-mysqldb libssl-dev libmysqlclient-dev libffi-dev -yqq && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/oltpbenchmark/website.git
WORKDIR /notebooks/website/
RUN pip2 install -U -r requirements.txt

RUN cd /notebooks/website/website/settings/ && cp credentials_TEMPLATE.py credentials.py && sed -i "s/ADD ME!!/root/g" credentials.py && sed -i "s/'HOST': '',/'HOST': 'db',/g" credentials.py && sed -i "s#BROKER_URL = 'amqp://guest:guest@localhost:5672//'#BROKER_URL = 'amqp://guest:guest@rabbitmq:5672//'#g" common.py && cat credentials.py && cat common.py

#CMD ["pip2", "freeze"]

#CMD ["mysqladmin", "create", "-uroot", "-proot", "ottertune"]

#CMD ["/usr/bin/python2", "manage.py", "makemigrations", "website"]
#CMD ["/usr/bin/python2", "manage.py", "migrate"]