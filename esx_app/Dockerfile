FROM alpine:3.13.5

RUN apk update \
&& apk add py-pip \
&& apk add curl 

WORKDIR /esx

COPY requirements.txt /esx/requirements.txt
COPY api.py /esx/api.py
COPY teste.sh /esx/teste.sh

RUN pip install -r requirements.txt \
&& chmod +x /esx/teste.sh