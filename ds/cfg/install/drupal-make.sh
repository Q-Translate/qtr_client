#!/bin/bash -x

source /host/settings.sh

### make sure that we have the right git branch on the make file
makefile="$CODE_DIR/build-qtrclient.make"
git_branch=$(git -C $CODE_DIR branch | cut -d' ' -f2)
sed -i $makefile \
    -e "/qtr_client..download..branch/ c projects[qtr_client][download][branch] = $git_branch"

### retrieve all the projects/modules and build the application directory
rm -rf $DRUPAL_DIR
drush make --prepare-install --force-complete \
           --contrib-destination=profiles/qtr_client \
           $makefile $DRUPAL_DIR

### Replace the profile qtr_client with a version
### that is a git clone, so that any updates
### can be retrieved easily (without having to
### reinstall the whole application).
cd $DRUPAL_DIR/profiles/
mv qtr_client qtr_client-bak
cp -a $CODE_DIR .
### copy contrib libraries and modules
cp -a qtr_client-bak/libraries/ qtr_client/
cp -a qtr_client-bak/modules/contrib/ qtr_client/modules/
cp -a qtr_client-bak/themes/contrib/ qtr_client/themes/
### cleanup
rm -rf qtr_client-bak/

### copy the bootstrap library to the custom theme, etc.
cd $DRUPAL_DIR/profiles/qtr_client/
cp -a libraries/bootstrap themes/contrib/bootstrap/
cp -a libraries/bootstrap themes/qtr_client/
cp libraries/bootstrap/less/variables.less themes/qtr_client/less/

### copy hybriauth provider DrupalOAuth2.php to the right place
cd $DRUPAL_DIR/profiles/qtr_client/libraries/
cp hybridauth-drupaloauth2/DrupalOAuth2.php \
   hybridauth/hybridauth/Hybrid/Providers/

### copy the logo file to the drupal dir
ln -s $DRUPAL_DIR/profiles/qtr_client/qtr_client.png $DRUPAL_DIR/logo.png

### get a clone of qtrclient from github
if [[ -n $DEV ]]; then
    cd $DRUPAL_DIR/profiles/qtr_client/modules/contrib/qtrclient
    git clone https://github.com/Q-Translate/qtrclient.git
    cp -a qtrclient/.git .
    rm -rf qtrclient/
fi

### set propper directory permissions
mkdir -p $DRUPAL_DIR/sites/all/translations
chown -R www-data: $DRUPAL_DIR/sites/all/translations
mkdir -p sites/default/files/
chown -R www-data: sites/default/files/
mkdir -p cache/
chown -R www-data: cache/
### create the downloads dir
mkdir -p /var/www/downloads/
chown www-data /var/www/downloads/
