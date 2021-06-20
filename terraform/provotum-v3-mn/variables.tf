variable "do_token" {}
variable "pvt_key" {}
variable "docker_registry" {}
variable "docker_registry_username" {}
variable "docker_registry_password" {}
variable "subdomain" {
  type = string
  default = "v3-mn"
}
variable "nr_sealers" {
  type = number
  default = 2
}
variable "influxdb_url" {
  type = string
  default = "influx.logs.provotum.io"
}
variable "influxdb_username" {
  type = string
  default = "influx"
}
variable "influxdb_password" {
  type = string
  default = "password"
}
