FROM python:3.12
SHELL ["/bin/bash", "-c"]
RUN apt-get update
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs
COPY requirements.txt ./
RUN pip install -r requirements.txt
RUN rfbrowser init
RUN npx playwright install-deps
#ENV NODE_PATH=/usr/lib/node_modules
ENV PATH="/root/.local/bin:${PATH}"