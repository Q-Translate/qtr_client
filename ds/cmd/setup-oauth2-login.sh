cmd_setup-oauth2-login_help() {
    cat <<_EOF
    setup-oauth2-login @<qtr-server>
        Setup the oauth2 login between the client and the qtr server.
        The argument '@<qtr-server>' is the container of the server.

_EOF
}

cmd_setup-oauth2-login() {
    # get the container of the server
    local qtr_server=$1
    [[ ${qtr_server:0:1} == '@' ]] || fail "Usage:\n$(cmd_setup-oauth2-login_help)"

    # get variables
    local client_url=$(ds exec drush @qcl php-eval 'print $GLOBALS["base_url"]')
    local server_url=$(ds $qtr_server exec drush @qtr php-eval 'print $GLOBALS["base_url"]')
    local redirect_uri="$client_url/oauth2/authorized"
    local client_key=$(mcookie)
    local client_secret=$(mcookie)

    # register an oauth2 client on qtr_server
    ds $qtr_server inject oauth2-client-add.sh @qtr $client_key $client_secret $redirect_uri
    # set the variable qtr_client of the server
    ds $qtr_server exec drush --yes @qtr vset qtr_client $client_url
    # setup oauth2 login on qtr_client
    ds inject set-oauth2-login.sh @qcl $server_url $client_key $client_secret

    # fix cache
    ds exec drush @qcl cc all
    ds $qtr_server exec drush @qtr cc all
    ds exec chown www-data: -R /var/www/qcl/cache
    ds $qtr_server exec chown www-data: -R /var/www/qtr/cache

    if [[ -n $DEV ]]; then
        # get variables
        client_url=$(ds exec drush @qcl_dev php-eval 'print $GLOBALS["base_url"]')
        server_url=$(ds $qtr_server exec drush @qtr_dev php-eval 'print $GLOBALS["base_url"]')
        redirect_uri="$client_url/oauth2/authorized"
        client_key='localclient'
        client_secret=$(mcookie)

        # register an oauth2 client on qtr_server
        ds $qtr_server inject oauth2-client-add.sh @qtr_dev $client_key $client_secret $redirect_uri
        # set the variable qtr_client of the server
        ds $qtr_server exec drush --yes @qtr_dev vset qtr_client $client_url
        # setup oauth2 login on qtr_client
        ds inject set-oauth2-login.sh @qcl_dev $server_url $client_key $client_secret

        # fix cache
        ds exec drush @qcl_dev cc all
        ds $qtr_server exec drush @qtr_dev cc all
        ds exec chown www-data: -R /var/www/qcl_dev/cache
        ds $qtr_server exec chown www-data: -R /var/www/qtr_dev/cache
    fi
}
