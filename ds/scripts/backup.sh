#!/bin/bash -x

#source /host/settings.sh

# create the backup dir
backup="backup-data-$(date +%Y%m%d)"
cd /host/
rm -rf $backup
rm -f $backup.tgz
mkdir $backup
cd $backup/

# disable the site for maintenance
drush --yes @local_qcl vset maintenance_mode 1

# clear the cache
drush --yes @local_qcl cache-clear all

# backup qcl users
mysqldump=$(drush @qcl sql-connect | sed -e 's/^mysql/mysqldump/' -e 's/--database=/--databases /')
table_list="users users_roles"
$mysqldump --tables $table_list > $(pwd)/qcl_users.sql

# backup enabled features
drush @qcl features-list --pipe --status=enabled \
      > $(pwd)/qcl_features.txt

# backup drupal variables
dir=/var/www/qcl/profiles/qtr_client/modules/features
$dir/save-private-vars.sh @qcl
mv restore-private-vars.php restore-private-vars-qcl.php

# make the backup archive
cd /host/
tar --create --gzip --preserve-permissions --file=$backup.tgz $backup/
rm -rf $backup/

# enable the site
drush --yes @local_qcl vset maintenance_mode 0
