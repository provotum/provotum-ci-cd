resource "digitalocean_droplet" "sealer" {
  count  = var.nr_sealers
  image  = "ubuntu-20-04-x64"
  name   = "v3-mn-sealer-${count.index}"
  region = "fra1"
  size   = "s-2vcpu-2gb"

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
    when    = destroy
    command = "echo '' > ../../ansible/provotum-v3-mn-sealer-inventory"
  }

  provisioner "local-exec" {
    command = "echo ${self.ipv4_address} >> ../../ansible/provotum-v3-mn-sealer-inventory"
  }

  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} --extra-vars 'docker_registry=${var.docker_registry} docker_registry_username=${var.docker_registry_username} docker_registry_password=${var.docker_registry_password} domain=${data.digitalocean_domain.default.name} sealer_number=${count.index} influxdb_url=${var.influxdb_url} influxdb_username=${var.influxdb_username} influxdb_password=${var.influxdb_password}' ../../ansible/provotum-v3-mn-sealer.yml"
  }
}
