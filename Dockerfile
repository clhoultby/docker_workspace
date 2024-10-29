FROM node:22.10-alpine3.19

USER root

RUN mkdir -p /workspace/

COPY ./package.json /workspace/package.json
COPY ./test.js /workspace/test.js


RUN cd /workspace && npm install

RUN apk update

RUN apk add \
nss \
freetype \
freetype-dev \
harfbuzz \
ttf-freefont \
chromium \
git

RUN chromium-browser \
--headless \
--no-sandbox \
--disable-gpu \
--disable-software-rasterizer \
--disable-dev-shm-usage \
--screenshot=out.png \
http://neverssl.com


RUN node /workspace/test.js >> out.log