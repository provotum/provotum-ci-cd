# Jenkins

## Info

Jenkins is a CI-Pipeline that is responsible for building docker images and pushing them to quay docker registry. The provisioning of a VM and installation of Jenkins is done through a terraform script which automatically runs an ansible script after provisioning. Follow the steps in configuration, to set up a pipeline for a specific repository.

## Installation

1. Navigate to this folder: `cd terraform/jenkins`
2. Initialize terraform: `terraform init`
3. Set up server: `terraform apply -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`
  - `YOUR_DIGITALOCEAN_ACCESS_TOKEN`: Your token for DO
  - `PATH_TO_YOUR_PRIVATE_KEY`: Path to the private key that is used to set for root user authentication. The corresponding public key needs to be saved on digitalocean with the name 'terraform'
4. Confirm deployment with `YES`

To destroy the server just run `terraform destroy -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`

## Configuration

todo
