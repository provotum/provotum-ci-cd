# System Log server installation

## Info

The log server contains grafana and influxdb. In order to send logs to this server install role telegraf-inst on another server such logs can be fetched.

## Variables

You need to provide the following variables:

  - `hostname`: The host where grafana and influxdb will be run on

You can overwrite the following variables:

  - `grafana_user`: The user to log in to grafana
  - `grafana_password`: The password to log in to grafana
  - `influx_user`: The user for influxdb
  - `influx_password`: The password for influxdb
