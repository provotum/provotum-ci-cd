# Quay installation

## Info

Quay is a docker registry. It stores and version docker images. This role sets up quay as a docker container on a server.

## Variables

You can overwrite the following variables:

  - `quay_db_user`: The user for the internal Quay DB
  - `quay_db_password`: The password for the internal Quay DB
  - `quay_redis_password`: The password for the internal Quay Redis storage
  - `contact_info`: The contact info of your organisation that will be shown on the home-page
  - `enterprise_logo_url`: The logo of your organisation that will be shown on the home-page
  - `registry_title`: The title of your organisation that will be shown on the home-page
