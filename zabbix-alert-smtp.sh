#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Zabbix SMTP Alert script (Gmail and SES available).
"""

import sys
import smtplib
from email.MIMEText import MIMEText
from email.Header import Header
from email.Utils import formatdate

# Create your own settings.py
from settings import (SENDER_EMAIL, SMTP_USERNAME, SMTP_PASSWORD, SMTP_SERVER,
                      SMTP_PORT, SENDER_NAME, SMTP_SSL_TYPE)
# You can create your own settings.py
# or commentout above import and define these variables here.
example = """# settings.py - zabbix-alert-smtp

# Mail Account
SENDER_NAME = u'Zabbix Alert'
SENDER_EMAIL = 'your.account@gmail.com'

# Gmail
SMTP_USERNAME = 'your.account@gmail.com'
SMTP_PASSWORD = 'your mail password'

# Mail Server
SMTP_SERVER = 'smtp.gmail.com'
SMTP_PORT = 587

# SSL Type ('SMTP_TLS': Gmail, 'SMTP_SSL': SES, None: no SSL)
SMTP_SSL_TYPE = SMTP_TLS

# # Amazon SES
# SMTP_USERNAME = 'Access Key Id'
# SMTP_PASSWORD = 'Secret Access Key'
#
# # Mail Server
# SMTP_SERVER = 'email-smtp.us-east-1.amazonaws.com'
# SMTP_PORT = 587
#
# # SSL Type ('SMTP_TLS': Gmail, 'SMTP_SSL': SES, None: no SSL)
# SMTP_SSL_TYPE = SMTP_SSL
"""

def send_mail(recipient, subject, body, encoding='utf-8'):
    session = None
    msg = MIMEText(body, 'plain', encoding)
    msg['Subject'] = Header(subject, encoding)
    msg['From'] = Header(u'"{0}" <{1}>'.format(SENDER_NAME, SENDER_EMAIL), encoding)
    msg['To'] = recipient
    msg['Date'] = formatdate()
    try:
        if SMTP_SSL_TYPE == 'SMTP_SSL':
            session = smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT)
        else:
            session = smtplib.SMTP(SMTP_SERVER, SMTP_PORT)
            if SMTP_SSL_TYPE == 'SMTP_TLS':
                session.ehlo()
                session.starttls()
                session.ehlo()
        session.login(SMTP_USERNAME, SMTP_PASSWORD)
        session.sendmail(SENDER_EMAIL, recipient, msg.as_string())
    except Exception as e:
        raise e
    finally:
        # close session
        if session:
            session.quit()

if __name__ == '__main__':
    """
    recipient = sys.argv[1]
    subject = sys.argv[2]
    body = sys.argv[3]
    """
    if len(sys.argv) == 4:
        send_mail(
            recipient=sys.argv[1],
            subject=sys.argv[2],
            body=sys.argv[3])
    elif (len(sys.argv) == 2 and 
            sys.argv[1] == 'example'):
        print example
    else:
        print u"""requires 3 parameters (recipient, subject, body)
\t$ zabbix-alert-smtp.sh recipient subject body
"""
