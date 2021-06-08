# Provotum v2 server installation

## Info

Provotum v2 is a distributed REV system providing Frontend, Backend and peer-to-peer applications.

## Variables

You need to provide the following variables:

  - `domain`: The domain where you want provotum v2 to be running on. It will set a label to it's containers such that they can be detected by trafik (reverse proxy) which will generate certificates and redirect request to the corresponding containers.

## Notes

This role depends on the following repository `https://github.com/provotum/provotum-v2.git` and checks out the following branch `roger-deployment`. The application is then natively built on the server without the use of any docker registry.
