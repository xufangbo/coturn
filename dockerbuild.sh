docker stop coturn
docker remove coturn
docker image remove coturn:lasted
docker build --tag coturn:lasted .
docker run --name=coturn --net host -d coturn:latest
