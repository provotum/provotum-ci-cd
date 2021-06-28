# Provotum 2.0

## Info

This folder contains the full deployment for provotum 2.0.
WARNING: This deployment uses the branch roger-deployment from the [Provotum 2 repository](https://github.com/provotum/provotum-v2)

## Installation

1. Navigate to this folder: `cd terraform/provotum-v2`
2. Initialize terraform: `terraform init`
3. Set up server: `terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`
4. Confirm deployment with `YES`

Optional variable: If you wish to change the subdomain (default v2), you can overwrite the variable `subdomain_server` when doing `terraform apply`

To destroy the server just run `terraform destroy -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`

## Configuration

### Start/restart the voting process

To set up a new vote within Provotum 2.0 move to `/ansible` and run the following command: `ansible-playbook -u root -i 'IP_ADDRESS_OF_SERVER,' --private-key $PATH_TO_SK --extra-vars 'domain=DOMAIN_SET' provotum-v2-restart-vote.yml`

Replace the following:
- `IP_ADDRESS_OF_SERVER`: The IP adress of the server that Provotum 2.0 is running on
- `DOMAIN_SET`: The domain Provotum 2.0 is running on (Default v2.provotum.io)

### Change number of voters

If you wish to change the number of eligible voters you can do this in `/ansible/roles/provotum-v2-restart-vote/defaults/main.yml`. The default is set to 10 Voters (user0 to user10). The authentication credentials for each voter is combined as follows:

- username: user$NR_USER$
- password: user$NR_USER$

e.q

- username: user1
- password: user1

If you have changed the number of voters restart the voting process!

## Default values

The following urls are set as default:

- voter_frontend_url: `voter.v2.provotum.io`
- voting_authority_url: `voting-authority.v2.provotum.io`
- access_provider_url: `access-provider.v2.provotum.io`
- identity_provider_url: `identity-provider.v2.provotum.io`
- sealer1_url: `sealer1.v2.provotum.io`
- sealer1_parity_url: `parity1.v2.provotum.io`
- sealer2_url: `sealer2.v2.provotum.io`
- sealer2_parity_url: `parity2.v2.provotum.io`
- sealer3_url: `sealer2.v2.provotum.io`
- sealer3_parity_url: `parity3.v2.provotum.io`
- ethstats_url: `ethstats.v2.provotum.io`
