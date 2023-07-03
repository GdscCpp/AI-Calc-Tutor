FROM node:20.3.1

WORKDIR /app

COPY / /app/

RUN apt-get update -y

RUN apt-get install xmaxima -y

RUN npm install

EXPOSE 3000

ENTRYPOINT [ "node", "app.js" ]

