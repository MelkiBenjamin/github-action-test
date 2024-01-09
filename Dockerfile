FROM ubuntu:22.04
WORKDIR /home
COPY script.py .
     requirements.txt .
RUN apt update && \ 
    apt install -y python3 && \ 
    pip install -r requirements.txt
    