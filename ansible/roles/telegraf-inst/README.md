# Telegraf installation

## Info

Telegraf fetches data from your docker containers (like cpu or memory usage) and send them to the logging server (grafana, influxdb).

## Variables

You need to provide the following variables:

  - `influxdb_url`: The url where the influxdb is running on
  - `influxdb_username`: The username for influxdb
  - `influxdb_password`: The password for influxdb
