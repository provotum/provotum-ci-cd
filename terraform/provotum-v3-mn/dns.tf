resource "digitalocean_record" "server" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = var.subdomain
  ttl    = 10
  value  = element(digitalocean_droplet.server,0).ipv4_address
}
resource "digitalocean_record" "server_sub" {
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "*.${var.subdomain}"
  ttl    = 10
  value  = element(digitalocean_droplet.server,0).ipv4_address
}
resource "digitalocean_record" "sealer" {
  count  = length(digitalocean_droplet.sealer)
  domain = data.digitalocean_domain.default.name
  type   = "A"
  name   = "sealer${count.index}.${var.subdomain}"
  ttl    = 10
  value  = element(digitalocean_droplet.sealer, count.index).ipv4_address
}
