variable "subdomain_server" {
  type = string
  default = "server"
}

resource "digitalocean_droplet" "server" {
  count  = 1
  image  = "ubuntu-20-04-x64"
  name   = "server-${count.index}"
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
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} ../ansible/provotum-server.yml"
  }
}

resource "digitalocean_record" "server" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain_server
  value  = element(digitalocean_droplet.server,0).ipv4_address
}

resource "digitalocean_record" "server_sub" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "*.${var.subdomain_server}"
  value  = element(digitalocean_droplet.server,0).ipv4_address
}
