#!/bin/bash

export ACCOUNT_EMAIL='jmurphyau@me.com'
export USER_AGENT='root@dotnet-webapi'
export LE_WORKING_DIR=/opt/acme
export LE_CONFIG_HOME=/opt/acme-data

[[ ! -d $LE_WORKING_DIR ]] && mkdir $LE_WORKING_DIR
[[ ! -d $LE_CONFIG_HOME ]] && mkdir $LE_CONFIG_HOME

curl https://get.acme.sh | sh -s email=$ACCOUNT_EMAIL --noprofile --server letsencrypt --force
