===================================
 Zabbix Alert Script SMTP with tls
===================================

This script enables the zabbix to send alert email via SMTP with tls.
(ie. Gmail, Amazon SES)

Requirements
------------

python 2.6 or over


Install
-------

Clone source::

  $ git clone https://git@bitbucket.org:superdaigo/zabbix-alert-smtp.git


Copy shell-script file into alertscripts folder::

  $ sudo cp zabbix-alert-smtp/zabbix-alert-smtp.sh /usr/local/share/zabbix/alertscripts/
