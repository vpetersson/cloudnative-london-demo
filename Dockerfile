FROM python:3-slim

WORKDIR /usr/src/app

# Try to fix vulnerabilities
RUN apt-get update && \
    apt-get upgrade && \
    apt-get clean

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .
CMD [ "python", "./app.py" ]
