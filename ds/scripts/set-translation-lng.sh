#!/bin/bash -x

source /host/settings.sh

alias=${1:-@local_qcl}

### set drupal variable qtrClient_translation_lng
drush $alias --yes --exact vset qtrClient_translation_lng $TRANSLATION_LNG

### add $TRANSLATION_LNG as a drupal language
if [[ "$TRANSLATION_LNG" != 'all' ]]; then
    drush $alias --yes language-add $TRANSLATION_LNG
fi

if [[ -z $DEV ]]; then
    drush $alias --yes l10n-update-refresh
    drush $alias --yes l10n-update
fi
