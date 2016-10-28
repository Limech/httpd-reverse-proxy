
FROM centos:centos7

RUN yum -y update && \
    yum -y install httpd && \
    yum clean all


EXPOSE 80
EXPOSE 443


ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh

CMD ["/run-httpd.sh"]

