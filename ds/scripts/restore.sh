#!/bin/bash -x

restore_custom_scripts() {
    if [[ ! -f /host/backup.sh ]] && [[ -f backup.sh ]]; then
        cp backup.sh /host/
    fi
    if [[ ! -f /host/restore.sh ]] && [[ -f restore.sh ]]; then
        cp restore.sh /host/
    fi
    if [[ ! -d /host/cmd ]] && [[ -d cmd ]]; then
        cp -a cmd /host/
    fi
    if [[ ! -d /host/scripts ]] && [[ -d scripts ]]; then
        cp -a scripts /host/
    fi
}

# go to the backup directory
backup=$1
cd /host/$backup

# restore qcl users
drush @qcl sql-query --file=$(pwd)/qcl_users.sql

# delete any existing content
drush --yes @qcl pm-enable delete_all
drush --yes @qcl delete-all all --reset

# enable features
while read feature; do
    drush --yes @qcl pm-enable $feature
    drush --yes @qcl features-revert $feature
done < qcl_features.txt

# restore private variables
drush @qcl php-script $(pwd)/restore-private-vars-qcl.php

# restore any custom scripts
restore_custom_scripts

# custom restore script
[[ -f /host/restore.sh ]] && source /host/restore.sh
