# Dockerfiles start from a parent image or "base image".
# It's a Docker image that your image is based on
# You choose the base imag, dependingon which tools you need to have available

# In this example we have used our base image as node as it is required to start the application
# FROM command is equal to or means INSTALL
# WORKDIR command is equal to CD
# We can execute any linux base commands inside docker container



FROM node:19-alpine

COPY package.json /app/
COPY src /app/
# The / in the end is really important so that the docker knows to create the folder if it does not exists yet

WORKDIR /app

RUN npm install

CMD ["node","server.js"]

