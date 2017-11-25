#!/usr/bin/env python

from urllib.request import FancyURLopener
from accounts import accounts

email = accounts.student_email 
password = accounts.student_pass

try:
    url = 'https://%s:%s@mail.google.com/mail/feed/atom' % (email, password)
    opener = FancyURLopener()
    page = opener.open(url)

except OSError:
    pass

else:
    contents = page.read().decode('utf-8')

    ifrom = contents.index('<fullcount>') + 11
    ito = contents.index('</fullcount>')

    fullcount = contents[ifrom:ito]

    print(fullcount)

