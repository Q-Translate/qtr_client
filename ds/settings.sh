APP=qtr_client/ds

### Docker settings.
IMAGE=qtr_client
CONTAINER=qcl.example.org
DOMAIN="qcl.example.org"

### Uncomment if this installation is for development.
DEV=true

### Other domains.
[[ -n $DEV ]] && DOMAINS="dev.qcl.example.org tst.qcl.example.org"

### DB settings
DBHOST=mariadb
DBPORT=3306
DBNAME=qcl
DBUSER=qcl
DBPASS=qcl

### SMTP server for sending notifications. You can build an SMTP server
### as described here:
### https://github.com/docker-scripts/postfix/blob/master/INSTALL.md
### Comment out if you don't have a SMTP server and want to use
### a gmail account (as described below).
SMTP_SERVER=smtp.example.org
SMTP_DOMAIN=example.org

### Gmail account for notifications. This will be used by ssmtp.
### You need to create an application specific password for your account:
### https://www.lifewire.com/get-a-password-to-access-gmail-by-pop-imap-2-1171882
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
