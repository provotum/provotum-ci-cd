# Jenkins installation

## Info

Jenkins is a CI/CD pipeline in order to build projects, run tests and deploy applications. This installation sets up Jenkins in a docker container.

## Variables

You need to provide the following variables:

  - `hostname`: The hostname where you want jenkins to be running on. It will set a label to it's container such that it is detected by trafik (reverse proxy) which will generate a certificate and redirect request to this container.
