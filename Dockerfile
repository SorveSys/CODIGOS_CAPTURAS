FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
# Fuso horário de Brasília (sem o tzdata o container fica em UTC)
ENV TZ=America/Sao_Paulo

# O coletor.jar é compilado para Java 17 (o default-jdk do Ubuntu 22.04 é o 11 e não roda)
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    python3 \
    python3-pip \
    tzdata \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

COPY captura.py /app/captura.py
COPY coletor.jar /app/coletor.jar
