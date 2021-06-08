# Clair installation

## Info

Clair is a vulnerability scanner based on the CVE database. It will be queried from quay in order to automatically scan vulnerabilites within the docker images stored on quay.

## Variables

You can overwrite the following variables:

  - `clair_db_user`: The user for the internal Clair DB
  - `clair_db_password`: The password for the internal Clair DB
