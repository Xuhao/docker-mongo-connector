Mongo Connector (Elasticsearch 5)
===
Docker images for the mongo-connector.

Based on [`yeasy/docker-mongo-connector`](https://github.com/yeasy/docker-mongo-connector).

# Supported tags and respective Dockerfile links

* [`latest` (latest/Dockerfile)](https://github.com/Xuhao/docker-mongo-connector/blob/master/Dockerfile)

# What is docker-mongo-connector?
Docker image with mongo-connector installed. The image is built based on `phusion/baseimage`.

# How to use this image?
The docker image is auto built at [https://hub.docker.com/r/xuhao/docker-mongo-connector/](https://hub.docker.com/r/xuhao/docker-mongo-connector/).

## In Dockerfile
```sh
FROM Xuhao/mongo-connector:latest
```

## Local Run

Config your `config.json` and mount to `/data/config.json`

```sh
$ docker run -d -v /path/to/config.json:/data/config.json xuhao/docker-mongo-connector
```

It will connect the two containers together to sync data between each other.

# Which image is based on?
The image is based on `phusion/baseimage`.

# What has been changed?

## Config TZ
Config timezone to Asia/Shanghai.

# Install mongo-connector
Install the mongo-connector[elastic5]
