variable "subdomain_jenkins" {
  type = string
  default = "jenkins"
}

resource "digitalocean_droplet" "jenkins" {
  count  = 1
  image  = "ubuntu-20-04-x64"
  name   = "jenkins-${count.index}"
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
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root -i '${self.ipv4_address},' --private-key ${var.pvt_key} --extra-vars 'hostname=${var.subdomain_jenkins}.${data.digitalocean_domain.default.name}' ../ansible/jenkins.yml"
  }
}

resource "digitalocean_record" "jenkins" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain_jenkins
  value  = element(digitalocean_droplet.jenkins,0).ipv4_address
}
