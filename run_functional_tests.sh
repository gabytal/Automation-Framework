#!/bin/bash
# This script is the entry point of the automation system.
# it should run on every new version release as a part of CI/CD approval process.
# Usage, for example: './run_functional_tests.sh latest'

docker network create testing
# create a new Server docker container with the new image provided
docker run -dit --name app-server --network testing -p 80:80 ben:$1
if [ $? -eq 0 ]; then
    echo "APP container with new version has been created!"
else
    echo "APP container has not been created!, please investigate"
    exit 1
fi

# validate that APP container is running
if [ "$( docker container inspect -f '{{.State.Running}}' app-server )" == "true" ]; then
    echo "APP container is running!"
else
    echo "APP container is not running! please investigate"
    exit 1
fi

sleep 10

# create an automation docker client to execute tests against the server
docker run --name automation -it --network testing -v "$(pwd):/behave:rw" automation


