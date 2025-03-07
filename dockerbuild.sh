docker stop coturn
docker remove coturn
docker image remove coturn:latest
docker build --tag coturn:latest .
docker run --name=coturn --net host -d coturn:latest
