# Provotum 3.0 HE

## Info

This folder contains the distributed deployment for Provotum 3.0 HE.
WARNING: This deployment does not work properly yet. See known issues for more details!

## Installation

1. Set the additional ENV variables

  - `export DOCKER_REGISTRY=<YOUR_DOCKER_REGISTRY>`
    - `YOUR_DOCKER_REGISTRY`: The docker registry containing the docker images for Provotum 3.0 HE (use default quay.provotum.io)
  - `export DOCKER_REGISTRY_USERNAME=<YOUR_DOCKER_REGISTRY_USERNAME>`
    - `YOUR_DOCKER_REGISTRY_USERNAME`: The username for the docker docker registry
  - `export DOCKER_REGISTRY_PASSWORD=<YOUR_DOCKER_REGISTRY_PASSWORD>`
    - `DOCKER_REGISTRY_PASSWORD`: The password for the docker docker registry

2. Navigate to this folder: `cd terraform/provotum-v3-he`
3. Initialize terraform: `terraform init`
4. Set up server: `terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK" -var "docker_registry=$DOCKER_REGISTRY" -var "docker_registry_username=$DOCKER_REGISTRY_USERNAME" -var "docker_registry_password=$DOCKER_REGISTRY_PASSWORD"`
5. Confirm deployment with `YES`
6. Note that after the installation, the setup might take more time as DNS entries might still be cached. It should work after 30-60 minutes.
7. You have now installed all the components for Provotum 3.0 HE. Next, you can continue with with the setup of the voting. For that follow the Setup instructions in [provotum-infrastructure](https://github.com/provotum/provotum-infrastructure). Note: replace the localhost environment with the following (in case of default configuration):
  - vaUrl = localhost:3000 -> voting-authority.v3-he.provotum.io
  - sealerBobUrl = localhost:3001 -> sealer0.v3-he.provotum.io
  - sealerCharlieUrl = localhost:3002 -> sealer1.v3-he.provotum.io

To destroy the server just run `terraform destroy -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK" -var "docker_registry=$DOCKER_REGISTRY" -var "docker_registry_username=$DOCKER_REGISTRY_USERNAME" -var "docker_registry_password=$DOCKER_REGISTRY_PASSWORD"`

## Configuration

### Change number of sealers

If you with to change the number of sealers (default 2) add variable `nr_sealers` to step 4.

## Known issues
It is important to note that this deployment still continues issues. They are open for future work. The known issues are the following:

1. Building of voter GUI: The voter GUI still contains hard-coded urls for the randomizer, va and ws. These urls are hard-coded in the Jenkins pipeline.
The voter GUI should allow for environment variables for these urls. Then they can be dynamically assigned directly on the deplyoment server! This should be possible using a nodejs server which replaces the urls (see section Runtime Variables): https://adostes.medium.com/using-environment-variables-in-a-react-application-ac3b6c307373

  Jenkins overwrites these urls before Docker build in a shell script:

  `sed -i 's/ws:\/\/localhost:9944/wss:\/\/ws.chain.v3-he.provotum.io/g' src/substrate-lib/config/docker.json`

  `sed -i 's/http:\/\/localhost:5000/https:\/\/voting-authority.v3-he.provotum.io/g' public/Config.js`

  `sed -i 's/http:\/\/localhost:7000/https:\/\/randomizer.v3-he.provotum.io/g' public/Config.js`

2. The substrate nodes do not connect properly. The bootstrapping is working in general but the connection from the sealers to the bootnode is not working properly. The reason is that the va server is behind a reverse proxy and only sends his internal ip (and no external host) to the sealers proposing his bootnode. This bootnode should contain the external hostname of the voting authority (as sealers and va are not on the same server and behind reverse proxies). It should be possible to set the external address by starting the node with the option `--public-addr` with the right hostname as proposed [here](https://github.com/paritytech/substrate/issues/7518). The node is started in the substrate-client [here](https://github.com/provotum/substrate-client/blob/feature_check_chain_running/src/client/substrate-binary.ts) and does not allow to set the external options. This function should be extended to allow an input for the option `--public-addr`. The substrate-client should then be rebuilt and deployed on the digitalocean binary storage.
