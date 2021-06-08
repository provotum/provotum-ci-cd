# Jenkins

## Info

Jenkins is a CI-Pipeline that is responsible for building docker images and pushing them to quay docker registry. The provisioning of a VM and installation of Jenkins is done through a terraform script which automatically runs an ansible script after provisioning. Follow the steps in configuration, to set up a pipeline for a specific repository.

## Installation

1. Navigate to this folder: `cd terraform/jenkins`
2. Initialize terraform: `terraform init`
3. Set up server: `terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`
4. Confirm deployment with `YES`

To destroy the server just run `terraform destroy -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`

Optional variable: If you wish to change the subdomain (default jenkins), you can overwrite the variable `subdomain` when doing `terraform apply`

## Configuration

After installing jenkins, you can open it in your browser (default jenkins.provotum.io). Enter the initial password that can be found in the in the installation logs at the place `Initial Admin Password for Jenkins `.
Next, you are able to set-up a new user and you can start configuring jenkins.
