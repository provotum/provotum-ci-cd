variable "do_token" {}
variable "pvt_key" {}
variable "docker_registry" {}
variable "docker_registry_username" {}
variable "docker_registry_password" {}
variable "subdomain_server" {
  type = string
  default = "server.v3-mn"
}
variable "nr_sealers" {
  type = number
  default = 2
}
