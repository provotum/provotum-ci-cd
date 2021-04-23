# Provotum 2.0

## Info

This folder contains the full deployment for provotum 2.0.

## Installation

1. Navigate to this folder: `cd terraform/provotum-v2`
2. Initialize terraform: `terraform init`
3. Set up server: `terraform apply -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`
  - `YOUR_DIGITALOCEAN_ACCESS_TOKEN`: Your token for DO
  - `PATH_TO_YOUR_PRIVATE_KEY`: Path to the private key that you would like to use to set for root user authentication
4. Confirm deployment with `YES`

To destroy the server just run `terraform destroy -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`

## Configuration

### Restart the voting process

To set up a new vote within Provotum 2.0 move to `/ansible` and run the following command: `ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i 'IP_ADDRESS_OF_SERVER,' --private-key PATH_TO_PRIVATE_KEY --extra-vars 'domain=DOMAIN_SET' provotum-v2-restart-vote.yml`

Replace the following:
- `IP_ADDRESS_OF_SERVER`: The IP adress of the server that Provotum 2.0 is running on
- `PATH_TO_PRIVATE_KEY`: The path to the private key that you have set in the installation step
- `DOMAIN_SET`: The domain Provotum 2.0 is running on (Default v2.provotum.io)
