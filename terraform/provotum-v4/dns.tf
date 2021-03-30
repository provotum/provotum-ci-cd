resource "digitalocean_record" "server" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain_server
  value  = element(digitalocean_droplet.server,0).ipv4_address
}
