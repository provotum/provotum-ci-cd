# Provotum 3.0 MN

## Info

This folder contains the full distributed deployment for Provotum 3.0 MN.

## Installation

1. Set the additional ENV variables

  - `export DOCKER_REGISTRY=<YOUR_DOCKER_REGISTRY>`
    - `YOUR_DOCKER_REGISTRY`: The docker registry containing the docker images for Provotum 3.0 MN (use default quay.provotum.io)
  - `export DOCKER_REGISTRY_USERNAME=<YOUR_DOCKER_REGISTRY_USERNAME>`
    - `YOUR_DOCKER_REGISTRY_USERNAME`: The username for the docker docker registry
  - `export DOCKER_REGISTRY_PASSWORD=<YOUR_DOCKER_REGISTRY_PASSWORD>`
    - `DOCKER_REGISTRY_PASSWORD`: The password for the docker docker registry


1. Install jq: `sudo apt-get install jq`
2. Navigate to this folder: `cd terraform/provotum-v3-mn`
3. Initialize terraform: `terraform init`
4. Set up server: `terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK" -var "docker_registry=$DOCKER_REGISTRY" -var "docker_registry_username=$DOCKER_REGISTRY_USERNAME" -var "docker_registry_password=$DOCKER_REGISTRY_PASSWORD"`
5. Confirm deployment with `YES`
6. You have now installed all the components for Provotum 3.0 MN. Next, we need to create the custom chain spec in order to configure all nodes to connect to the same network.
7. Navigate to this folder: `cd ../../scripts/provotum-v3-mn`
8. Run the following script with sudo: `sudo ./create_custom_chain_spec.sh`
9. Next we need to start up the p2p network and run the DL protocol.
10. Navigate to this folder: `cd ../../ansible`
11. Start the server (Voting Authority and Randomizer): `ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key $PATH_TO_SK provotum-v3-mn-server-start.yml`
12. Start the sealers: `ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i provotum-v3-mn-sealer-inventory --private-key $PATH_TO_SK provotum-v3-mn-sealer-start.yml`

Note: The sealers should automatically connect to the bootnode (Voting Authority) and start the POA-protocol. Keys (Aura, Grandpa) are generated in the installation step.

To destroy the server just run `terraform destroy -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK" -var "docker_registry=$DOCKER_REGISTRY" -var "docker_registry_username=$DOCKER_REGISTRY_USERNAME" -var "docker_registry_password=$DOCKER_REGISTRY_PASSWORD"`

## Configuration

### Change number of sealers

If you with to change the number of sealers (default 2) add variable `nr_sealers` to step 4.

## Use the protocol

If you would like to test the protocol, the following commands are possible to execute with ansible. Ansible automatically connects to the right node (e.q. va) and lets you execute a command (e.q. create a vote).

To execute commands go to the folder `ansible`

### Create vote

With the following command you can create a new vote:

`ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key $PATH_TO_SK provotum-v3-mn-create-vote.yml --extra-vars "vote=VOTE question=QUESTION"`

  - `VOTE`: The name of your new vote
  - `QUESTION`: Your new election question

### Create sealer keys

Create the sealers ElGamal keypairs:

`ansible-playbook -u root -i provotum-v3-mn-sealer-inventory --private-key $PATH_TO_SK provotum-v3-mn-sealer-keygen.yml --extra-vars "vote=VOTE"`

  - `VOTE`: The name of your vote

### Combine public key shares

Combine the public key shares with the va:

`ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key $PATH_TO_SK provotum-v3-mn-combine-pk-shares.yml --extra-vars "vote=VOTE"`

  - `VOTE`: The name of your vote

### Generate a vote

Add a new vote from a voter:

`ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key $PATH_TO_SK provotum-v3-mn-vote.yml --extra-vars "vote=VOTE question=QUESTION votes=VOTES nrVotes=NUMBER_OF_VOTES"`

  - `VOTE`: The name of your vote
  - `QUESTION`: Your election question
  - `VOTES`: The answer of the voter: e.q. 1
  - `NUMBER_OF_VOTES`: the number of votes that should be generated for this voter with his votes

### Set phase to tallying

Change phase to tallying if the voting phase finished:

`ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key $PATH_TO_SK provotum-v3-mn-set-phase.yml --extra-vars "vote=VOTE phase=Tallying"`

  - `VOTE`: The name of your vote

Note: After setting the vote into tallying, the sealers start to mix the votes. After this is finished, the votes can be decrypted.

### Decrypt vote shares

After the mixing, the votes can be decrypted:

`ansible-playbook -u root -i provotum-v3-mn-sealer-inventory --private-key $PATH_TO_SK provotum-v3-mn-sealer-decrypt.yml --extra-vars "vote=VOTE question=QUESTION"`

  - `VOTE`: The name of your vote
  - `QUESTION`: Your election question

### Tally votes

The decrypted shares can now be combined and tallied:

`ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key $PATH_TO_SK provotum-v3-mn-tally.yml --extra-vars "vote=VOTE question=QUESTION"`

  - `VOTE`: The name of your vote
  - `QUESTION`: Your election question

### Show results

Display the final results of a question:

`ansible-playbook -u root -i provotum-v3-mn-server-inventory --private-key $PATH_TO_SK provotum-v3-mn-result.yml --extra-vars "question=QUESTION"`

  - `QUESTION`: Your election question
