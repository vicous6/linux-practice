#!/bin/bash

docker stop linux-practice-instance
docker rm linux-practice-instance

docker build -t vicous/linux-practice .
# Run the container in detached mode
docker run -d -p 8080:8080 --name linux-practice-instance vicous/linux-practice

# Open a shell in the running container
docker exec -it linux-practice-instance /bin/bash