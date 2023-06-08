# dotnet-webapi

## Setup / Run Locally

1. Build and push the docker image to your ECR
```
docker build --platform linux/amd64 -t dotnet-webapi -f Dockerfile .
docker tag dotnet-webapi:latest 000000000000.dkr.ecr.ap-southeast-2.amazonaws.com/dotnet-webapi:latest
docker push 000000000000.dkr.ecr.ap-southeast-2.amazonaws.com/dotnet-webapi:latest
```
2. Update `dotnet-webapi.json` - changing the placeholder values

3. Create docker-compose files from the ECS json definition
```
ecs-cli local create --task-def-file dotnet-webapi.json -o docker-compose-dotnet-webapi.yml
```

4. Remove the volumes section from `docker-compose-dotnet-webapi.yml` and create a similar section in `docker-compose-dotnet-webapi.override.yml`. `docker-compose-dotnet-webapi.override.yml` should look something like this:
```
version: "3.4"
services:
  dotnet-webapi:
    logging:
      driver: json-file
    volumes:
    - type: bind
      source: /my/local/dir/acme
      target: /opt/acme
    - type: bind
      source: /my/local/dir/acme-data
      target: /opt/acme-data
    - type: bind
      source: /my/local/dir/certs/https-inside-ecs.jmurphyau.dev
      target: /opt/certs
```

5. Create the container (and the required network if you don't already have one)
```
docker network create ecs-local-network
docker-compose -f docker-compose-dotnet-webapi.yml -f docker-compose-dotnet-webapi.override.yml create
```

6. Start it
```
docker-compose -f docker-compose-dotnet-webapi.yml -f docker-compose-dotnet-webapi.override.yml start
```
