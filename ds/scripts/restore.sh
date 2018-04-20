#!/bin/bash -x

# go to the backup directory
backup=$1
cd /host/$backup

# restore qcl users
drush @qcl sql-query --file=$(pwd)/qcl_users.sql

# enable features
while read feature; do
    drush --yes @qcl pm-enable $feature
    drush --yes @qcl features-revert $feature
done < qcl_features.txt

# restore private variables
drush @qcl php-script $(pwd)/restore-private-vars-qcl.php

# custom restore script
[[ -f /host/restore.sh ]] && source /host/restore.sh
