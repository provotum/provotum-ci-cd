# Quay

## Info

Quay is a private docker image registry. This folder contains all steps to set up a Quay Registry with a Clair vulnerability scanner.

## Installation

1. Navigate to this folder: `cd terraform/quay`
2. Initialize terraform: `terraform init`
3. Set up server: `terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`
4. Confirm deployment with `YES`

To destroy the server just run `terraform destroy -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`

Optional variable: If you wish to change the subdomain (default quay), you can overwrite the variable `subdomain` when doing `terraform apply`

## Configuration

After installing quay, you can open it in your browser (default quay.provotum.io).
