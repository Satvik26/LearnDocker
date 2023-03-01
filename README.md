# LearnDocker

### Basic Docker Commands

#### This command is used to download the docker images with the specific version/tag:
```diff
docker pull {imagename}:{tag}
```
#### This command is used to create a container from the given image and start it:
```diff
docker run {imagename}:{tag}
```
#### This command is used to run the container in the detach/background mode:
```diff
docker run -d {imagename}:{tag}
```
#### This command is used to see the logs if the container is running in the detach/background mode:

We can get the container_id using the docker ps command
```diff
docker logs {container_id}
OR
docker logs {container_name}
```
##### NOTE: We can just skip the docker pull command and directly use the docker run command if we don't have the image locally. The run command will first try to locate the image remotely and if it does not find it locally it will try to pull it directly from the docker hub and run it. So, it does the work of both the commands.

### Command used for showing status of all the running containers
```diff
docker ps
```
![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/container_status.png)

### Command used for showing status of all the images
```diff
docker images
```
![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/images_status.png)

### Port Binding

How to access the container after it started running?

We can't access the container as its running in the closed docker network and we can't access it from our local computer browser. We have to first expose the container to our local network using Port Binding. It is a technique that bind the container's port to the host's port to make the service available to the outside world.

##### NOTE:

1. Only 1 service can run on a specific port on the host.
2. It's your wish to choose any port but its standard to use the same port on your host as container is using

![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/port_binding.png)

#### This command is used to publish a container's port to the host (PORT BINDING)
```diff
docker run -d -p 9000:80 {imagename}:{tag}
```
### Start and stop containers

#### This command is used too start the docker container
```diff
docker start {container_id}
OR
docker start {container_name}
```
#### This command is used too stop the docker container
```diff
docker stop {container_id}
OR
docker stop {container_name}
```
##### Note: docker run command creates a new container everytime we use it. It doesn't re-use the previous container. Therefore, we have multiple container created everytime we run the command but we can only see one container on using "docker ps"

#### This command is used to see all the containers that are created.
```diff
docker ps -a
```

#### This command is used to give the container a meaningfull name using the --name flag.
```diff
docker run --name {container_name} -d -p 9000:80 {imagename}:{tag}
```

### Build Docker Images

We need to create a definition of how to build an image from our application in a file called Dockerfile.

Docker file is a text document that contains commands to assemble an image.
Docker can then build an image by reading those instructions.

### Structure of Dockerfile

#### FROM
Build this image from the specified image

#### COPY
Copies files or directories from <src> and adds them to the filesystem of the container at the path <dest>.
While "RUN" is executed in the container, "COPY" is executed on the host

#### WORKDIR
Sets the working directory for all following commands.
Like changing into a directory: "cd..."

#### RUN
Will execute any command in a shell inside the container environment

#### CMD
The instruction that is to be executed when a Docker container starts.
There can only be one "CMD" instruction in a Dockerfile

#### This command is used for building the docker image
```diff
docker build -t node-app:1.0 .
```
-t flag : Sets a name and optionally a tag in the "name:tag" format.

Then we have to give a name to the image and a specific tag.

Then we have to give the location of the dockerfile since we are in the same directory where the docker file is located that's why we have given "."



