# Provotum 3.0 HE Central

## Info

This folder contains the centralized deployment for Provotum 3.0 HE (i.e. 2 fixed sealers and all components centrally deployed on one instance).

## Installation

1. Set the additional ENV variables

  - `export DOCKER_REGISTRY=<YOUR_DOCKER_REGISTRY>`
    - `YOUR_DOCKER_REGISTRY`: The docker registry containing the docker images for Provotum 3.0 HE (use default quay.provotum.io)
  - `export DOCKER_REGISTRY_USERNAME=<YOUR_DOCKER_REGISTRY_USERNAME>`
    - `YOUR_DOCKER_REGISTRY_USERNAME`: The username for the docker docker registry
  - `export DOCKER_REGISTRY_PASSWORD=<YOUR_DOCKER_REGISTRY_PASSWORD>`
    - `DOCKER_REGISTRY_PASSWORD`: The password for the docker docker registry

2. Navigate to this folder: `cd terraform/provotum-v3-he-central`
3. Initialize terraform: `terraform init`
4. Set up server: `terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK" -var "docker_registry=$DOCKER_REGISTRY" -var "docker_registry_username=$DOCKER_REGISTRY_USERNAME" -var "docker_registry_password=$DOCKER_REGISTRY_PASSWORD"`
5. Confirm deployment with `YES`
6. Note that after the installation, the setup might take more time as DNS entries might still be cached. It should work after 30-60 minutes.
7. You have now installed all the components for Provotum 3.0 HE. Next, you can continue with with the setup of the voting. For that follow the Setup instructions in [provotum-infrastructure](https://github.com/provotum/provotum-infrastructure). Note: replace the localhost environment with the following (in case of default configuration):
  - vaUrl = localhost:3000 -> voting-authority.v3-he-central.provotum.io
  - sealerBobUrl = localhost:3001 -> sealer1.v3-he-central.provotum.io
  - sealerCharlieUrl = localhost:3002 -> sealer2.v3-he-central.provotum.io

To destroy the server just run `terraform destroy -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK" -var "docker_registry=$DOCKER_REGISTRY" -var "docker_registry_username=$DOCKER_REGISTRY_USERNAME" -var "docker_registry_password=$DOCKER_REGISTRY_PASSWORD"`


## Default values

The following urls are set as default:

- identity_provider_url: `identity.v3-he-central.provotum.io`
- randomizer_url: `randomizer.v3-he-central.provotum.io`
- voting_authority_url: `voting-authority.v3-he-central.provotum.io`
- frontend_url: `voter.v3-he-central.provotum.io`
- sealer_1_url: `sealer1.v3-he-central.provotum.io`
- sealer_2_url: `sealer2.v3-he-central.provotum.io`

## Known issues
It is important to note that this deployment still continues issues. They are open for future work. The known issues are the following:

1. Building of voter GUI: The voter GUI still contains hard-coded urls for the randomizer, va and ws. These urls are hard-coded in the Jenkins pipeline.
The voter GUI should allow for environment variables for these urls. Then they can be dynamically assigned directly on the deplyoment server! This should be possible using a nodejs server which replaces the urls (see section Runtime Variables): https://adostes.medium.com/using-environment-variables-in-a-react-application-ac3b6c307373

  Jenkins overwrites these urls before Docker build in a shell script:

  `sed -i 's/ws:\/\/localhost:9944/wss:\/\/ws.chain.v3-he-central.provotum.io/g' src/substrate-lib/config/docker.json`

  `sed -i 's/http:\/\/localhost:5000/https:\/\/voting-authority.v3-he-central.provotum.io/g' public/Config.js`

  `sed -i 's/http:\/\/localhost:7000/https:\/\/randomizer.v3-he-central.provotum.io/g' public/Config.js`

2. Well known sealers used: Two well known sealers bob and charlie are used in this centralized deployment. 
