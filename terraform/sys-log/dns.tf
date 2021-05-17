resource "digitalocean_record" "sys-log" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain
  value  = element(digitalocean_droplet.sys-log,0).ipv4_address
}
resource "digitalocean_record" "sys-log-sub" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "*.${var.subdomain}"
  value  = element(digitalocean_droplet.sys-log,0).ipv4_address
}
