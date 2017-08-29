cmd_create_help() {
    cat <<_EOF
    create
        Create the container '$CONTAINER'.

_EOF
}

rename_function cmd_create orig_cmd_create
cmd_create() {
    local code_dir=$(dirname $(realpath $APP_DIR))
    orig_cmd_create \
        --mount type=bind,src=$code_dir,dst=/usr/local/src/qtr_client \
        --mount type=bind,src=$(pwd)/var-www,dst=/var/www \
        --workdir /var/www \
        --env CODE_DIR=/usr/local/src/qtr_client \
        --env DRUPAL_DIR=/var/www/qcl

    rm -f qtr_client
    ln -s var-www/qcl/profiles/qtr_client .
}
