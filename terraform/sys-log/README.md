# System Log

## Info

The logging system contains grafana, influxdb and telegraf. Telegraf fetches logs from the docker daemon and sends them directly to the influxdb. Grafana then displays the data from the influxdb. The server is set up containing grafana and influxdb and telegraf is installed on an arbitrary server, where data should be fetched.

## Installation

1. Navigate to this folder: `cd terraform/sys-log`
2. Initialize terraform: `terraform init`
3. Set up server: `terraform apply -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`
4. Confirm deployment with `YES`

To destroy the server just run `terraform destroy -var "do_token=$DO_TOKEN" -var "pvt_key=$PATH_TO_SK"`

Optional variable: If you wish to change the subdomain (default logs), you can overwrite the variable `subdomain` when doing `terraform apply`

## Configuration

After installing the log server, you can access the grafana (default: grafana.logs.provotum.io) and influxdb (default: influx.logs.provotum.io).

## Set up Telegraf

Telegraf can easily be installed on a server using docker by adding the telegraf ansible role (in `ansible/roles/telegraf-inst`). More information can be found in the folder of this ansible role.
