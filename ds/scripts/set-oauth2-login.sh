#!/bin/bash -x

source /host/settings.sh

alias=${1:-@qcl}
server_url=${2:-$OAUTH2_SERVER_URL}
client_id=${3:-$OAUTH2_CLIENT_ID}
client_secret=${4:-$OAUTH2_CLIENT_SECRET}
skip_ssl=1

drush --yes $alias php-script $CODE_DIR/ds/scripts/set-oauth2-login.php  \
    "$server_url" "$client_id" "$client_secret" "$skip_ssl"
drush --yes $alias cc all
