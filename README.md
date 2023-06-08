# dotnet-webapi

## Setup / Run Locally
1. Update dotnet-webapi.json - changing the placeholder values

2. Create docker-compose files from the ECS json definition
```
ecs-cli local create --task-def-file dotnet-webapi.json -o docker-compose-dotnet-webapi.yml
```

3. Remove the volumes section from `docker-compose-dotnet-webapi.yml` and create a similar section in `docker-compose-dotnet-webapi.override.yml`. `docker-compose-dotnet-webapi.override.yml` should look something like this:
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

4. Create the container (and the required network if you don't already have one)
```
docker network create ecs-local-network
docker-compose -f docker-compose-dotnet-webapi.yml -f docker-compose-dotnet-webapi.override.yml create
```

5. Start it
```
docker-compose -f docker-compose-dotnet-webapi.yml -f docker-compose-dotnet-webapi.override.yml start
```
