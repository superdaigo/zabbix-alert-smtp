===================================
 Zabbix Alert Script SMTP with tls
===================================

This script enables the zabbix to send alert email via SMTP with tls.
(ie. Gmail, Amazon SES)

Requirements
------------

python 2.6 or over


Installation
------------

Clone source into your zabbix 'alertscripts' directory

::

  $ cd /path/to/zabbix/alertscripts
  $ git clone https://git@bitbucket.org:superdaigo/zabbix-alert-smtp.git

Confirm your system's python path with first line of a script 'zabbix-alert-smtp.sh'.


Mail Account Settings
---------------------

Create settings.py and edit::
  $ cd zabbix-alert-smtp
  $ zabbix-alert-smtp.sh example > settings.py


Confirm to send mail::

  $ zabbix-alert-smtp.sh your@email.address 'Subject: Test Mail' 'Message: Ahoy!'


Setup Zabbix Media
------------------

Follow zabbix documents to create custom media.
https://www.zabbix.com/documentation/2.0/manual/config/notifications/media/script
