# Provotum v3 mn sealer installation

## Info

Provotum v3 mn sealer is the setup of a substrate validation node for provotum v3 mn. After the setup, the role provotum-v3-mn-sealer-start needs to be executed such that the node connects to the bootnode and starts the protocol. In addition, a client is installed such that the node can be accessed to execute commands (like decrypt vote shares).

## Variables

You need to provide the following variables:

  - `docker_registry`: The registry where the node of provotum v3 mn can be pulled from
  - `docker_registry_username`: The username for the registry
  - `docker_registry_password`: The password for the registry
  - `sealer_number` The sealers unique id

## Notes

The sealer node generates its own aura and grandpa keys locally in order to validate and finalize blocks in the network. To generate a common chain spec file, the public parts of the aura and grandpa keys are stored locally in provotum-v3-mn-server-inst/files after the execution of this role.
