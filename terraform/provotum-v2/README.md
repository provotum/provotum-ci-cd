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

Optional variable: If you wish to change the subdomain (default v2), you can overwrite the variable `subdomain_server` when doing `terraform apply`

To destroy the server just run `terraform destroy -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`

## Configuration

### Start/restart the voting process

To set up a new vote within Provotum 2.0 move to `/ansible` and run the following command: `ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i 'IP_ADDRESS_OF_SERVER,' --private-key PATH_TO_PRIVATE_KEY --extra-vars 'domain=DOMAIN_SET' provotum-v2-restart-vote.yml`

Replace the following:
- `IP_ADDRESS_OF_SERVER`: The IP adress of the server that Provotum 2.0 is running on
- `PATH_TO_PRIVATE_KEY`: The path to the private key that you have set in the installation step
- `DOMAIN_SET`: The domain Provotum 2.0 is running on (Default v2.provotum.io)

### Change number of voters

If you wish to change the number of eligible voters you can do this in `/ansible/roles/provotum-v2-restart-vote/defaults/main.yml`. The default is set to 10 Voters (user0 to user10). The authentication credentials for each voter is combined as follows:

- username: user$NR_USER$
- password: user$NR_USER$

e.q

- username: user1
- password: user1

If you have changed the number of voters restart the voting process!
