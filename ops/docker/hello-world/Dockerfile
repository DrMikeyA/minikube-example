FROM python:stretch
RUN apt-get update
RUN apt-get -y install apache2 libapache2-mod-wsgi-py3

#Copy flask app to /var/www
COPY app/src/ /var/www/flaskapp/
COPY app/requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

#Configure apache
COPY /config/apache/flaskapp.conf /etc/apache2/sites-available/flaskapp.conf
RUN a2enmod wsgi
RUN a2ensite flaskapp
# Copy over the wsgi file
COPY config/wsgi/flaskapp.wsgi /var/www/flaskapp/flaskapp.wsgi

RUN service apache2 start && service apache2 reload
RUN echo "root            soft    ulimit            3096"  >> /etc/security/limits.conf
CMD ["apachectl", "-DFOREGROUND"]
