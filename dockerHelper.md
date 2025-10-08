## Docker

| topic | command                    | Task                           |
| --- | -------------------------- | ------------------------------ |
| docker | docker ps                  | show docker processes          |
| docker | docker ps -a               | show all docker processes      |
| docker | docker start _containerID_ | docker container starten       |
| docker | docker stop _containerID_  | docker container stoppen       |
| docker | docker rm _containerID_    | remove docker container        |
| docker | docker image ls            | list all images on docker host |
| docker | docker rmi _imagename_     | remove image from docker host  |
| docker | docker volume ls           | show all container data        |
| docker | colima start/stop          | start/stop docker on mac       |
| docker | docker tag fastapi:latest fastapiacr85080.azurecr.io/fastapi:lates | tag image to acr |
| docker | docker push fastapiacr85080.azurecr.io/fastapi:latest | push image to acr |
