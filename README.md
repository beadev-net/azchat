# AzChat

Websocket chat application using Azure Cloud Services.
- Redis
- WebApp

### Az Login

```sh
az login
```

### Container Registry Authentication

```sh
docker login acrmycontainers.azurecr.io -u <username> -p <password>
```

```sh
docker build . -t acrmycontainers.azurecr.io/azchat:<version>
```

```sh
docker push acrmycontainers.azurecr.io/azchat:<version>
```