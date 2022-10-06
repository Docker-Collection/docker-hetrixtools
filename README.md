# Docker Hetrixtools

A keep updating repo for hetrixtools container.

(Maybe someday, I will make this to alpine again?)

Original author is mmohoney from [mmohoney/hetrixtools-agent](https://github.com/mmohoney/hetrixtools-agent).

## Note

> Why ``network_mode`` is on ``host``?
>
> Because container needs to catch the real network usage if don't put network mode on host, then it will only collect inside container network usage.

## Command

```sh
docker run -d --name='hetrixtools-agent' -e 'HETRIX_AGENT_PARAMS'='ID 0 0 0 0 0' 'ghcr.io/docker-collection/hetrixtools:latest'
```

## Docker Compose (Recommand)

```yml
version: "3"
services:
  hetrixtools-agent:
    image: ghcr.io/docker-collection/hetrixtools:latest
    container_name: hetrixtools-agent
    environment:
      - HETRIX_AGENT_PARAMS=ID 0 0 0 0 0
    network_mode: "host"
    restart: unless-stopped
```
