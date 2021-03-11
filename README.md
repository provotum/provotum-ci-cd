# provotum-ci-cd

This repo contains all the configuration files to deploy the ci/cd infrastructure for provotum. The following architecture will build up droplets on digitalocean with all the software needed. It uses terraform to spin up servers on digitalocean and ansible to configure these servers with the specific software needed.

## Getting started
### Info
The whole infrastructure for provotum will set up the following server:
- Jenkins (CI-Pipeline)
- Quay (Docker Registry)
- Clair (Docker Image Vulnerability Scanner for Quay)


### Prerequisites

To set up the infrastructre the following installations on your local computer are needed:
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- An ssh key

You also need to have a the following things defined on digitalocean:
- [A digitalocean account](https://www.digitalocean.com/)
- [A personal access token](https://www.digitalocean.com/docs/apis-clis/api/create-personal-access-token/)
- [A domain defined in digitalocean](https://www.digitalocean.com/docs/networking/dns/how-to/add-domains/)

### Installation

After installing the prerequisites and setting up digitalocean you are ready to go to deploy the infrastructure for provotum. Do the following steps:

1) Clone this repo
2) Run `cd provotum-ci-cd/terraform`
3) Run `terraform apply -var "do_token=YOUR_PERSONAL_ACCESS_TOKEN" -var "pvt_key=YOUR_PATH_TO_THE_SSH_KEY"`

todo: domain
### Post-installation steps
todo
### Options
todo
