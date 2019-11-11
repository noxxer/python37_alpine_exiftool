FROM python:3.7-alpine

RUN apk update && apk add --update --no-cache \
    bash \
    git \
    curl \
    postgresql-client \
    postgresql-dev \
    build-base \
    gettext \
    libffi-dev \
    libxslt-dev \
    libmagic

RUN apk add jpeg-dev \
    zlib-dev \
    freetype-dev \
    openjpeg-dev

ENV EXIFTOOL_VERSION=11.65

RUN apk add --no-cache perl make
RUN cd /tmp \
	&& wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
	&& tar -zxvf Image-ExifTool-${EXIFTOOL_VERSION}.tar.gz \
	&& cd Image-ExifTool-${EXIFTOOL_VERSION} \
	&& perl Makefile.PL \
	&& make test \
	&& make install \
	&& cd .. \
	&& rm -rf Image-ExifTool-${EXIFTOOL_VERSION}

RUN pip3 install --upgrade pip
RUN pip3 install -U pip setuptools

WORKDIR /base
COPY requirements.txt /base

RUN pip3 install --no-cache-dir --upgrade -r requirements.txt
