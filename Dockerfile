FROM python:3.6-slim

WORKDIR /usr/src/app

# Try to fix vulnerabilities
RUN apt-get update && \
    apt-get upgrade && \
    apt-get clean

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

ARG AQUA_TOKEN
RUN apt-get -q update && \
    apt-get install -yq curl && \
    apt-get clean
RUN curl -s -o /microscanner https://get.aquasec.com/microscanner && \
    chmod +x /microscanner && \
    /microscanner ${AQUA_TOKEN} && \
    rm -rf /microscanner

COPY . .
CMD [ "python", "./app.py" ]
