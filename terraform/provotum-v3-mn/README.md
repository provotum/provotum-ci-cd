# Provotum 3.0 MN

## Info

This folder contains the full distributed deployment for Provotum 3.0 MN.

## Installation

1. Install jq: `sudo apt-get install jq`
2. Navigate to this folder: `cd terraform/provotum-v3-mn`
3. Initialize terraform: `terraform init`
4. Set up server: `terraform apply -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY" -var "docker_registry=DOCKER_REGISTRY" -var "docker_registry_username=DOCKER_REGISTRY_USERNAME" -var "docker_registry_password=DOCKER_REGISTRY_PASSWORD`
  - `YOUR_DIGITALOCEAN_ACCESS_TOKEN`: Your token for DO
  - `PATH_TO_YOUR_PRIVATE_KEY`: Path to the private key that is used to set for root user authentication. The corresponding public key needs to be saved on digitalocean with the name 'terraform'
  - `DOCKER_REGISTRY`: The docker registry containing the docker images for Provotum 3.0 MN (use default quay.provotum.io)
  - `DOCKER_REGISTRY_USERNAME`: The username for the docker docker registry
  - `DOCKER_REGISTRY_PASSWORD`: The password for the docker docker registry
5. Confirm deployment with `YES`
6. You have now installed all the components for Provotum 3.0 MN. Next, we need to create the custom chain spec in order to configure all nodes to connect to the same network.
7. Navigate to this folder: `cd ../../scripts/provotum-v3-mn`
8. Run the following script with sudo: `sudo ./create_custom_chain_spec.sh`
9. Next we need to start up the p2p network and run the DL protocol.
10. Navigate to this folder: `cd ../../ansible`
11. Start the server (Voting Authority and Randomizer): `ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key PATH_TO_YOUR_PRIVATE_KEY provotum-v3-mn-server-start.yml`
12. Start the sealers: `ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i provotum-v3-mn-sealer-inventory --private-key PATH_TO_YOUR_PRIVATE_KEY provotum-v3-mn-sealer-start.yml`

Note: The sealers should automatically connect to the bootnode (Voting Authority) and start the POA-protocol. Keys (Aura, Grandpa) are generated in the installation step.

To destroy the server just run `terraform destroy -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`

## Configuration

### Change number of sealers

If you with to change the number of sealers add variable `nr_sealers` to step 3.

## Use the protocol

### Create vote

### Create sealer keys

### Combine public key shares

### Generate a vote

### Set phase to tallying

### Decrypt vote shares

### Tally votes

### Show results
