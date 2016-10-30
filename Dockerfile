FROM centos:centos7

RUN yum -y update && \
    yum -y install httpd openssl mod_ssl mod_proxy mod_proy_http && \
    yum clean all

ADD run-httpd.sh /run-httpd.sh

RUN openssl genpkey -algorithm RSA -des3 -out private.key -pkeyopt rsa_keygen_bits:2048 -pass pass:hello
RUN cp private.key private.key.orig 
RUN openssl rsa -in private.key.orig -out private.key  -passin pass:hello
RUN openssl req -new -key private.key -out localhost.csr -subj "/C=CA/ST=Ottawa/L=Ottawa/O=Organization/CN=limech.duckdns.org"
RUN openssl x509 -req -days 365 -in localhost.csr -signkey private.key -out localhost.crt 

#ADD hardening.conf /etc/httpd/conf.d/

RUN chmod -v +x /run-httpd.sh 
 
EXPOSE 80
EXPOSE 443

ADD reverse-proxy.conf /etc/httpd/conf.d/

CMD ["/run-httpd.sh"]

