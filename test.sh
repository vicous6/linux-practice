#!/bin/bash

docker stop my-ansible-container-instance
docker rm my-ansible-container-instance

docker build -t my-ansible-container .
# Run the container in detached mode
docker run -d -p 8080:8080 --name my-ansible-container-instance my-ansible-container

# Open a shell in the running container
docker exec -it my-ansible-container-instance /bin/bash