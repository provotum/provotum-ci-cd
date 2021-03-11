variable "subdomain_quay" {
  type = string
  default = "quay"
}

resource "digitalocean_droplet" "quay" {
  count  = 1
  image  = "ubuntu-20-04-x64"
  name   = "quay-${count.index}"
  region = "fra1"
  size   = "s-2vcpu-4gb"

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
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} --extra-vars 'hostname=${var.subdomain_quay}.${data.digitalocean_domain.default.name}' ../ansible/quay.yml"
  }
}

resource "digitalocean_record" "quay" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain_quay
  value  = element(digitalocean_droplet.quay,0).ipv4_address
}
