#!/bin/bash -x

# go to the backup dir
backup=$1
cd /host/$backup

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
