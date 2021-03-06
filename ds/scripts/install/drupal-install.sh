#!/bin/bash -x

source /host/settings.sh

### settings for the database and the drupal site
site_name="Q-Translate"
site_mail="$GMAIL_ADDRESS"
account_name=admin
account_pass="$ADMIN_PASS"
account_mail="$GMAIL_ADDRESS"

### start site installation
sed -e '/memory_limit/ c memory_limit = -1' -i /etc/php/7.1/cli/php.ini
cd $DRUPAL_DIR
drush site-install --verbose --yes qtr_client \
      --db-url="mysql://$DBUSER:$DBPASS@$DBHOST:$DBPORT/$DBNAME" \
      --site-name="$site_name" --site-mail="$site_mail" \
      --account-name="$account_name" --account-pass="$account_pass" --account-mail="$account_mail"

### install additional features
drush="drush --root=$DRUPAL_DIR --yes"

$drush pm-enable qcl_qtrClient
$drush features-revert qcl_qtrClient

$drush pm-enable qcl_misc
$drush features-revert qcl_misc

$drush pm-enable qcl_layout
$drush features-revert qcl_layout

$drush pm-enable bootstrap
$drush pm-enable qtr_client

$drush pm-enable qcl_content

#$drush pm-enable qcl_captcha
#$drush features-revert qcl_captcha

$drush pm-enable qcl_permissions
$drush features-revert qcl_permissions

#$drush pm-enable qcl_invite
#$drush pm-enable qcl_simplenews
#$drush pm-enable qcl_mass_contact

### update to the latest version of core and modules
#$drush pm-refresh
#$drush pm-update

### refresh and update translations
if [[ -z $DEV ]]; then
    $drush l10n-update-refresh
    $drush l10n-update
fi
