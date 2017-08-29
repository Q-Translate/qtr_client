#!/bin/bash -x

source /host/settings.sh

# setup cron
cat <<EOF > /etc/cron.d/twitter
### the script is called as the user 'twitter'
0 4 * * *  twitter  $DRUPAL_DIR/profiles/qtr_client/utils/twitter.sh > /dev/null 2>&1

### uncomment this line only for debugging
#*/5 * * * *  twitter  $DRUPAL_DIR/profiles/qtr_client/utils/twitter.sh
EOF
