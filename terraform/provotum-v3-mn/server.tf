resource "digitalocean_droplet" "server" {
  count  = 1
  image  = "ubuntu-20-04-x64"
  name   = "server"
  region = "fra1"
  size   = "s-4vcpu-8gb"

  ssh_keys = [
      data.digitalocean_ssh_key.terraform.id
  ]

  provisioner "remote-exec" {
    inline = ["sudo apt update", "echo Done!"]

    connection {
      host        = self.ipv4_address
      type        = "ssh"
      user        = "root"
      private_key = file(var.pvt_key)
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} --extra-vars 'docker_registry=${var.docker_registry} docker_registry_username=${var.docker_registry_username} docker_registry_password=${var.docker_registry_password}' ../../ansible/provotum-v3-mn-server.yml"
  }
}
