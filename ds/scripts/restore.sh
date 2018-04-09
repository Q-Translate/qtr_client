#!/bin/bash -x

# disable the site for maintenance
drush --yes @local_qcl vset maintenance_mode 1
drush --yes @local_qcl cache-clear all

# extract the backup archive
file=$1
cd /host/
tar --extract --gunzip --preserve-permissions --file=$file
backup=${file%%.tgz}
backup=$(basename $backup)
cd $backup/

# restore qcl users
drush @qcl sql-query --file=$(pwd)/qcl_users.sql

# enable features
while read feature; do
    drush --yes @qcl pm-enable $feature
    drush --yes @qcl features-revert $feature
done < qcl_features.txt

# restore private variables
drush @qcl php-script $(pwd)/restore-private-vars-qcl.php

# clean up
cd /host/
rm -rf $backup

# enable the site
drush --yes @local_qcl cache-clear all
drush --yes @local_qcl vset maintenance_mode 0
