# Provotum v3 mn server installation

## Info

Provotum v3 mn server is the setup of a voting authority and a randomizer provotum v3 mn. After the setup, the role provotum-v3-mn-server-start needs to be executed such that the node connects to the bootnode and starts the protocol. In addition, a client is installed such that the node can be accessed to execute commands (like create a new vote).

## Variables

You need to provide the following variables:

  - `docker_registry`: The registry where the node of provotum v3 mn can be pulled from
  - `docker_registry_username`: The username for the registry
  - `docker_registry_password`: The password for the registry

You can overwrite the following variables:

  - `batch_size`: The batch size for the mix-net

## Notes

The server generates its own aura keys locally in order to participate in the network (The va is only the observer and does not sign blocks). To generate a common chain spec file, the public parts of the aura key is stored locally in provotum-v3-mn-server-inst/files after the execution of this role.
