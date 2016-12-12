## This script takes the content of the sites.json file
## and add entries for each in the reverse-proxy redirection
## within the VirtualHost block

import json

from pprint import pprint

f = open('/etc/httpd/conf/reverse/reverse-proxy.conf', 'w')

with open('/tmp/sites.json') as data_file:    
    data = json.load(data_file)


for val in data:
    f.write("ProxyPass " + val[0] + " " + val[1] + "\n")
    f.write("ProxyPassReverse " + val[0] + " " + val[1]  + "\n")

f.close()