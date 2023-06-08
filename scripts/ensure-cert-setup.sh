#!/bin/bash
set +x

# config for acme.sh
export ACCOUNT_EMAIL='jmurphyau@me.com'
export USER_AGENT='root@dotnet-webapi'
export LE_WORKING_DIR=/opt/acme
export LE_CONFIG_HOME=/opt/acme-data

# also config for acme.sh
# export AWS_ACCESS_KEY_ID=<removed>
# export AWS_SECRET_ACCESS_KEY=<removed>

# create acme if its missing
[[ ! -f ${LE_WORKING_DIR}/acme.sh ]] && ./setup-acme.sh

# local vars
_domain="${DOMAIN}"
_delegated_domain="${DELEGATED_DOMAIN}"


# local vars
_random_days=$((57 + 1 + $RANDOM % 6 - 3)) #this will be used to spread out the renewal abit
_domain_alias="_acme-challenge.${_delegated_domain}"

/opt/acme/acme.sh --server letsencrypt --issue --days ${_random_days} -d ${_domain} --domain-alias ${_domain_alias} --dns dns_aws --cert-file /opt/certs/cert.pem --key-file /opt/certs/privkey.pem --ca-file /opt/certs/chain.pem --fullchain-file /opt/certs/fullchain.pem
ret=$?
echo "ret=$ret"
[[ $ret -eq 2 ]] && exit 0
