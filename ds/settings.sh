APP=qtr_client/ds

### Docker settings.
IMAGE=qtr_client
CONTAINER=qcl-example-org
DOMAIN="qcl.example.org"

### Uncomment if this installation is for development.
DEV=true

### Other domains.
[[ -n $DEV ]] && DOMAINS="dev.qcl.example.org tst.qcl.example.org"

### Gmail account for notifications.
### Make sure to enable less-secure-apps:
### https://support.google.com/accounts/answer/6010255?hl=en
GMAIL_ADDRESS=qcl.example.org@gmail.com
GMAIL_PASSWD=

### Admin settings.
ADMIN_PASS=123456

### Translation language of Q-Translate Client.
### Can be: 'fr', 'de', 'sq' etc. or can be 'all'
TRANSLATION_LNG='all'

### Settings for OAuth2 Login.
OAUTH2_SERVER_URL='https://dev.qtranslate.org'
OAUTH2_CLIENT_ID='client1'
OAUTH2_CLIENT_SECRET='0123456789'
