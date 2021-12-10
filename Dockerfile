FROM python:3.9.7-slim

WORKDIR /app

ARG SECRET_KEY
ARG DEBUG
ARG DB_NAME
ARG DB_USER
ARG DB_PASSWORD
ARG DB_HOST
ARG DB_PORT

ENV TZ Asia/Tokyo
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8

RUN apt-get update -y && apt-get install -y \
    build-essential \
    libmariadb-dev \
    default-mysql-client \
    locales \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN echo "${TZ}" > /etc/timezone \
 && dpkg-reconfigure -f noninteractive tzdata \
 && locale-gen en_US.UTF-8 \
 && localedef -f UTF-8 -i en_US en_US.utf8

COPY requirements.txt /app/

RUN pip3 install -r requirements.txt

COPY . /app/

CMD python3 manage.py runserver 0.0.0.0:${PORT}
