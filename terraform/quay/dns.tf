resource "digitalocean_record" "quay" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain
  value  = element(digitalocean_droplet.quay,0).ipv4_address
}
