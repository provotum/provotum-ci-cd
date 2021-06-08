# Reverse proxy installation

## Info

The reverse proxy used for this project is trafik. This role sets up a traefik docker container. Make sure to set labels at your applications such that traefik can identify them, create certificates and redirect requests to the applications.

## Variables

You need to provide the following variables:

  - `network`: The docker network where traefik will be running
  - `domain`: The domain where traefik will listen on

You can overwrite the following variables:

  - `default_mail`: The mail address, where certificate expiration warnings from Let's Encrypt will be sent to
