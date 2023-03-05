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

### Troubleshooting Commands

#### This command is used to see the logs if the container is running in the detach/background mode:

We can get the container_id using the docker ps command
```diff
docker logs {container_id}
OR
docker logs {container_name}
```
#### This command is used to see the last logs
```diff
docker logs {container_id} | tail
```
#### This command is used to stream the lgs
```diff
docker logs {container_id} -f
```
#### This command is used to get the terminal of the container, navigate a directory, check the log file, check the configuration file, print the environment variables.

```diff
docker exec -it {container_id} /bin/bash
OR
docker exec -it {container_name} /bin/bash
```

```diff
docker exec -it {container_id} /bin/sh
OR
docker exec -it {container_name} /bin/sh
```
#### Commands inside the interactive shell

To display the envionment variables
```diff
env
```

To exit the docker terminal
```diff
exit
```
it = interactive terminal

exit = For exiting for the interactive terminal


### Port Binding

How to access the container after it started running?

We can't access the container as its running in the closed docker network and we can't access it from our local computer browser. We have to first expose the container to our local network using Port Binding. It is a technique that bind the container's port to the host's port to make the service available to the outside world.



##### NOTE:

1. Only 1 service can run on a specific port on the host.
2. It's your wish to choose any port but its standard to use the same port on your host as container is using
3. Multiple containers can have the have the same container port if they are binded to the different host port.

![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/port_binding.png)

#### This command is used to publish a container's port to the host (PORT BINDING)
```diff
docker run -d -p 9000:80 {imagename}:{tag}
```
### Start and stop containers

#### This command is used too start/restart the docker container
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

#### This command is used to delete the docker container
```diff
docker rm {container_id}
OR
docker rm {container_name}
```

#### This command is used to delete the docker images
```diff
docker rmi {container_id}
OR
docker rmi {container_name}
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
Will execute any command in a shell inside the container environment.We can execute any linux command using RUN Any directory created using run command is created in the container not on the host.

#### CMD
The instruction that is to be executed when a Docker container starts.
There can only be one "CMD" instruction in a Dockerfile as it is a entry point command.

![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/DockerFile.png)

#### This command is used for building the docker image
```diff
docker build -t node-app:1.0 .
```
-t flag : Sets a name and optionally a tag in the "name:tag" format.

Then we have to give a name to the image and a specific tag.

Then we have to give the location of the dockerfile since we are in the same directory where the docker file is located that's why we have given "."

We can add the environment variables in the dockerfile as well but its recommended to configure them in the docker-compose.yaml file.

### Docker Network

Docker creates it's isolated docker network where the containers are running in. So, when we deploy two docker container in the same docker network. They can talk to each other using just the container name because there are in the same network. The application that run outside the docker isolated environment will connect to docker container through the host i.e. the local host and the port number. So, when we package our application into its own application image we will have the docker container and the application image connected to the docker containers and to the browser which is running on the host but outside the docker network will connect to the application using the hostname and the port number

```diff
docker network ls
```
#### This command creates the docker network
```diff
docker network create {network_name}
```

### Docker scenario with two containers and an application image running in the docker network.

command for running the docker containers in the docker network we have to provide the option in the run command

##### Note: 
1.We can also specify the environment variables in the docker run command using the -e flag

2. --net = network

Container One
```diff
docker run -p 27017:27017 -d -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=password --name mongodb --net mongo-network mongo 
```
Container two
```diff
docker run -d -p 8081:8081 -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=password --net mongo-network --name mongo-express -e ME_CONFIG_MONGODB_SERVER=mongodb mongo-express
```

### Docker Compose

The above way of running the container is little bit tedious and we dont want to run the docker command every time we run the container and it will become more tedious when we have multiple containers.

We can automate this process by using docker-compose and it helps in running multiple container and setting all the configurations.

Yaml Configuration for Container One

![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/mongo.png)

Yaml Configuration for Container One

![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/mongo-express.png)


Note : Docker Compose takes care of creating a common network and specify in which network these container are running.

#### This command is used to start the container using docker-compose file
```diff
docker-compose -f {Name_of_yaml_file_with_extension} up
```
example: docker-compose -f mongo.yaml up

#### This command is used to shutdown/stop the container using docker-compose file
```diff
docker-compose -f {Name_of_yaml_file_with_extension} down
```
example: docker-compose -f mongo.yaml down

Note: When we restart a container everything that we have configured in the container application is gone. So, Data is lost. There is no data persistence. 
We have concept called Docker Volumes for Data Persistence that we learn later.
  
 ### Create Private Docker repository on AWS
 
 We have to login to the AWS console and create repository in ECR(Elastic Container Registry).
 We have one image per docker repository with differen tags (versions) of the same image.
  
 We need to create an IAM user with the access key and the secret key so that we can use the AWS Cli and we need the credentials configured.
  
 ### Image Naming in Docker registries
  
 registryDomain/imageName:tag
  
 ##### Note: In DockerHub whenever we pull an image we didn't use this convention because with docker hub we can pull an image with a shorthand without specifiy a registry domain. docker pull mongo:4.2 is an shorthand for docker pull docker.io/library/mongo:4.2 Since we were working with docker hub we were able to use a shortcut. In a private registry like ECR we can't skip that part because we don't have configuration for that.
  
  #### Command use to push the image to the private repository.
  
 ```diff
  docker tag {image_name}:tag {registryDomain}/{image_name}:tag
  ```
  Example for the above command
  
  docker tag my-app:1.0 8555232422333.dkr.ecr.eu-central-2.amazonaws.com/my-app:1.0
  
  Where tag is used to rename the image name
  
  ```diff
  docker push {registryDomain}/{image_name}:tag
  ```
  Example for the above command
  
  docker push 85552332232232.dkr.ecr.eu-central-2.amazonaws.com/my-app:1.0
  
  #### When we need to push the newer version of the image to the AWS ECR since we made some changes to the code or project we need to follow the steps below:
  
  1. Build the new image using the build command with the new tag/version
  ```diff
  docker build -t my-app:1.1
  ```
  2. Use the above commands and push agaiin with the new tag/version as 1.1
  
     tag command:
  
     docker tag my-app:1.1 8555232422333.dkr.ecr.eu-central-2.amazonaws.com/my-app:1.1
  
     push command:
  
     docker push 85552332232232.dkr.ecr.eu-central-2.amazonaws.com/my-app:1.1
  
 ### Persisting Data with Volumes
  
  Docker volumes are used for data persistence in docker. For example we have databases or other stateful applications we will use docker volumes for that
  
  Use Cases for docker volumes:
  
  When a container runs on a host. Let's say we have a database container and the container has a virtual file system where the data is usually stored but here we dont have any persistence. If we restart the container the data in the virtual file system will be gone and it will be in a fresh state which is not very practical as we need to save the data of our application in the docker volumes.
  
  What is a Docker Volume?
  
  On a host we have a physical file system and the way volume work we plug the physical file system path eg: folder, directory into the containers file system path. Folder in physical host file system us mounted into the virtual file system if Docker. So, when the container writes to its file system its gets automatically replicated or written in the host file system directory or vice-versa if we change anything in the host file system it gets changed in the container virtual file system. So, if the container starts from the fresh state its gets the data in its virtual file system from the host file system because the data is still there.
  
  #### Different types of docker volume.
  
  Named Volumes
  
  ![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/hostvolumes.png)
  
  Anonymous Volumes
  
  ![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/anonymousvolumes.png)
  
  Names Volumes
  
  ![alt text](https://github.com/Satvik26/LearnDocker/blob/main/images/NamedVolumes.png)
  
  
  
  
  
  
  
  





