# provotum-ci-cd

This repo contains all the configuration files to deploy the ci/cd infrastructure for provotum. The following architecture will build up droplets on digitalocean with all the software needed. It uses terraform to spin up servers on digitalocean and ansible to configure these servers with the specific software needed.

## Getting started
### Info
This repo contains the set up of the following components:
- Jenkins (CI-Pipeline)
- Quay (Docker Registry)
- Clair (Docker Image Vulnerability Scanner for Quay)
- Provotum 2.0
- Provotum 3.0 Mixnet


### Prerequisites

To set up the infrastructre the following installations on your local computer are needed:
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

You also need to have a the following things defined on digitalocean:
- [A digitalocean account](https://www.digitalocean.com/)
- [A personal access token](https://www.digitalocean.com/docs/apis-clis/api/create-personal-access-token/)
- [A domain defined in digitalocean](https://www.digitalocean.com/docs/networking/dns/how-to/add-domains/)

### Add public key

In order to create droplets and configure them it is necessary to create a private/public keypair on your local computer. Create a [keypair](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/) and add the public key to your digitalocean account as described in the documentation. It is important that you name your public key 'terraform' such that terraform is able to use the right one when setting up your droplets. Also set the right permission to your private key (400 r--------)

### Installation

After installing the prerequisites and setting up digitalocean you are ready to go to deploy different components for the infrastructure of Provotum. Clone this repo, go to `/terraform` and choose your component that you would like to deploy (e.q jenkins) and follow the installation steps in this folder.
