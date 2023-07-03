FROM node:16

WORKDIR /app

COPY / /app/

RUN apt-get update -y

RUN apt-get install xmaxima -y

RUN npm install

EXPOSE 3000

ENTRYPOINT [ "node", "app_linux.js" ]

