# Quay

## Info

Quay is a private docker image registry. This folder contains all steps to set up a Quay Registry with a Clair vulnerability scanner.

## Installation

1. Navigate to this folder: `cd terraform/quay`
2. Initialize terraform: `terraform init`
3. Set up server: `terraform apply -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`
  - `YOUR_DIGITALOCEAN_ACCESS_TOKEN`: Your token for DO
  - `PATH_TO_YOUR_PRIVATE_KEY`: Path to the private key that you would like to use to set for root user authentication
4. Confirm deployment with `YES`

To destroy the server just run `terraform destroy -var "do_token=YOUR_DIGITALOCEAN_ACCESS_TOKEN" -var "pvt_key=PATH_TO_YOUR_PRIVATE_KEY"`

## Configuration

todo
