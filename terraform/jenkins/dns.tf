resource "digitalocean_record" "jenkins" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain
  value  = element(digitalocean_droplet.jenkins,0).ipv4_address
}
