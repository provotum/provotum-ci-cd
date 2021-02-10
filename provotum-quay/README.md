# Provotum-quay

## What does this folder contain?

In this folder all necessary installation steps are included to deploy a Project Quay container image registry for Provotum. It is dockerized meaning that the whole registry itself is hosted in a docker container.

## Installation

 - Create an `.env` file in this folder on the server and set the following variables to the desired values: `DB_USER, DB_PASSWORD, REDIS_PASSWORD`
 - Run `docker-comopse -f docker-compose-storage.yml up -d` to start database and redis
 - Run `docker exec -it postgresql /bin/bash -c 'echo "CREATE EXTENSION IF NOT EXISTS pg_trgm" | psql -d quay -U user'` and exchange `postgresql` with the container id of your postgres container (to find it run `docker ps`)
 - Run quay config: `docker-compose -f docker-compose-config.yml run -p 8081:8080 quay_config config secret` this will set up a gui to create a configuration file for quay (e.g. set connection parameters for the database or connect a security scanner for the image)
 - Go to `ip:8081`, log in with quayconfig/secret and set your connection parameters for the database and redis.
    - Database
        - Database Server: `postgres`
        - User Name: `DB_USER`
        - Password: `DB_PASSWORD`
        - Database Name: `quay`
     - Redis
         - Host: `redis`
         - Password: `REDIS_PASSWORD`
- Download configfile extract it and put it into the `./config` folder
- Stop the quay config container
- Start quay with `docker-compose -f docker-compose-quay.yml up -d`
- Go to `ip:8081`, your quay repository is sucessfully installed.


## Todos

Define Hostname for quay server
Create save standard quay configuration file.
Crate docker image for postgres with enabled extension: docker exec -it postgresql /bin/bash -c 'echo "CREATE EXTENSION IF NOT EXISTS pg_trgm" | psql -d quay -U user'
