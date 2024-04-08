FROM python:3.12
SHELL ["/bin/bash", "-c"]
RUN apt-get update
RUN apt-get install -y wget
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt-get install -y ./google-chrome-stable_current_amd64.deb
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs
COPY requirements.txt ./
RUN pip install -r requirements.txt
RUN rfbrowser init
#ENV NODE_PATH=/usr/lib/node_modules
ENV PATH="/root/.local/bin:${PATH}"