FROM alpine:3.11 

#Base settings
ENV HOME /root

COPY requirements.txt /root/requirements.txt

#Install ZeroNet
RUN apk --no-cache --no-progress add musl-dev gcc python python-dev py2-pip tor openssl \
 && pip install --no-cache-dir gevent msgpack \
 && apk del musl-dev gcc python-dev py2-pip \
 && echo "ControlPort 9051" >> /etc/tor/torrc \
 && echo "CookieAuthentication 1" >> /etc/tor/torrc
 
RUN python3 -V \
 && python3 -m pip list \
 && tor --version \
 && openssl version

#Add Zeronet source
COPY . /root
VOLUME /root/data

#Control if Tor proxy is started
ENV ENABLE_TOR false

WORKDIR /root

#Set upstart command
CMD (! ${ENABLE_TOR} || tor&) && python3 zeronet.py --ui_ip 0.0.0.0 --fileserver_port 26552

#Expose ports
EXPOSE 43110 26552
