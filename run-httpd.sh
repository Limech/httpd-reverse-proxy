#!/bin/bash

#Ensure httpd is not running
rm -rf /run/httpd/* /tmp/httpd*

## Run apache but don't let call end so container stays alive.
exec /usr/sbin/apachectl -DFOREGROUND

