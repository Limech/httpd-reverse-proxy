FROM centos:centos7

RUN yum -y update && \
    yum -y install httpd openssl mod_ssl mod_proxy mod_proxy_http && \
    yum clean all

ADD run-httpd.sh /run-httpd.sh

RUN chmod -v +x /run-httpd.sh && \
    mkdir /etc/httpd/conf/reverse/ 

## 80 redirects to 443 
EXPOSE 80
EXPOSE 443

ARG serverName=myserver

ADD ssl-enable.conf /etc/httpd/conf.d/
RUN sed -i "s/MYSERVERNAME/${serverName}/g" /etc/httpd/conf.d/ssl-enable.conf
ADD sites.json /tmp/sites.json
ADD gen-proxies.py /

## Generate the lookup config entries for httpd.
RUN python gen-proxies.py

CMD ["/run-httpd.sh"]

