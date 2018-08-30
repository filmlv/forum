# The base image is the latest 8.x node (LTS)
FROM node:alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY install/package.json /usr/src/app/package.json
RUN npm install && npm cache clean --force
COPY . /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

# the default port for NodeBB is exposed outside the container
EXPOSE 4567

CMD [ "./nodebb", "start" ]
