# Q-Translate Client

Drupal installation profile for Q-Translate Client.

Q-Translate is an application that helps to improve the translations
of the Quran, by getting review and feedback from lots of
people. http://info.qtranslate.org

## Installation

  - First install Docker:
    https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository

  - Then install `ds`, `wsproxy` and `mariadb`:
     + https://github.com/docker-scripts/ds#installation
     + https://github.com/docker-scripts/wsproxy#installation
     + https://github.com/docker-scripts/mariadb#installation


  - Get the code from GitHub:
    ```
    git clone https://github.com/Q-Translate/qtr_client /opt/docker-scripts/qtr_client
    ```

  - Create a directory for the container: `ds init qtr_client/ds @qcl.example.org`

  - Fix the settings:
    ```
    cd /var/ds/qcl.example.org/
    vim settings.sh
    ```

  - Build image, create the container and configure it: `ds make`


## Access the website

  - Tell `wsproxy` to manage the domain of this container: `ds wsproxy add`

  - Tell `wsproxy` to get a free letsencrypt.org SSL certificate for this domain:
    ```
    ds wsproxy ssl-cert --test
    ds wsproxy ssl-cert
    ```

  - If installation is not on a public server, add to `/etc/hosts` the
    line `127.0.0.1 qcl.example.org` and then try in browser:
    https://qcl.example.org


## Backup and restore

    ds backup data
    ds backup
    ds restore <backup-file.tgz>


## Other commands

    ds help

    ds shell
    ds stop
    ds start
    ds snapshot

    ds setup-oauth2-login @<qtr-server>

    ds inject set-oauth2-login.sh [<@alias> <server-url> <client-key> <client-secret>]
    ds inject set-emailsmtp.sh 'smtp_server' <smtp-server> <smtp-domain>
    ds inject set-emailsmtp.sh 'gmail_account' <gmail-user> <gmail-passwd>
    ds inject set-adminpass.sh <new-drupal-admin-passwd>
    ds inject set-domain.sh <new.domain>
    ds inject set-translation-lng.sh

    ds inject dev/clone.sh test
    ds inject dev/clone-del.sh test
    ds inject dev/clone.sh 01
