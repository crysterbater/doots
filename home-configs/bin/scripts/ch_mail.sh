#!/bin/sh
# Script to check email on gmail...
read -p "  --> Name in email: " username;
read -p "  --> Password in email: " password;

echo -e "Checking for new messages... \c"
 atomlines=`wget -T 3 -t 1 -q --secure-protocol=TLSv1 \
 --no-check-certificate \
 --user=$username --password=$password \
 https://mail.google.com/mail/feed/atom -O - \
 | wc -l`
 
 echo -e "\r\c"
 [ $atomlines -gt "4" ] \
   && echo -e " You have new mail.  \c" \
   || echo -e " No new mail.  \c"
 # GitHub (c) 2015
 # Required Certificate.
