ARG python_ver=3.8
FROM mcr.microsoft.com/devcontainers/python:1-3.8-bullseye

ARG netbox_ver=v3.3.3
ENV PYTHONUNBUFFERED 1

RUN mkdir -p /opt

RUN pip install --upgrade pip

# -------------------------------------------------------------------------------------
# Install NetBox
# -------------------------------------------------------------------------------------
RUN apt update && \
    apt install -y python3 python3-pip python3-venv python3-dev build-essential libxml2-dev libxslt1-dev libffi-dev libpq-dev libssl-dev zlib1g-dev postgresql && \
    git clone --single-branch --branch ${netbox_ver} https://github.com/netbox-community/netbox.git /opt/netbox/ && \
    cd /opt/netbox/ && \
    pip install rq==1.13.0 && \
    pip install -r /opt/netbox/requirements.txt

# Work around https://github.com/rq/django-rq/issues/421
RUN pip install django-rq==2.3.2

COPY ./configuration.py /opt/netbox/netbox/netbox

# -------------------------------------------------------------------------------------
# Install Netbox Plugin
# -------------------------------------------------------------------------------------
RUN mkdir -p /source
WORKDIR /source
COPY . /source

#RUN pip install -r requirements.txt
#RUN python setup.py develop

WORKDIR /opt/netbox/netbox/

RUN adduser --system --group netbox && \
    chown --recursive netbox /opt/netbox/netbox/media/ && \
    chown --recursive netbox /opt/netbox/netbox/reports/ && \
    chown --recursive netbox /opt/netbox/netbox/scripts/ 