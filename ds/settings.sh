APP=qtr_client/ds

### Docker settings.
IMAGE=qtr_client
CONTAINER=qcl-example-org
SSHD_PORT=2201
#PORTS="80:80 443:443 $SSHD_PORT:22"    ## ports to be forwarded when running stand-alone
PORTS=""    ## no ports to be forwarded when running behind wsproxy

DOMAIN="qcl.example.org"
DOMAINS="dev.qcl.example.org tst.qcl.example.org"  # other domains

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

### Uncomment if this installation is for development.
DEV=true
