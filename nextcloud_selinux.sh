#!/bin/bash
ocpath='/var/www/html/nextcloud'
httpdrw='httpd_sys_rw_content_t'

setsebool -P httpd_can_sendmail 1
setsebool -P httpd_can_network_connect 1

printf "Set SELinux HTTPD RW on  Directories\n"
semanage fcontext -a -t ${httpdrw} "${ocpath}/config(/.*)?"
restorecon -R ${ocpath}/config
semanage fcontext -a -t ${httpdrw} "${ocpath}/apps(/.*)?"
restorecon -R ${ocpath}/apps
semanage fcontext -a -t ${httpdrw} "/data(/.*)?"
restorecon -R ${ocpath}/data
semanage fcontext -a -t ${httpdrw} "${ocpath}/updater(/.*)?"
restorecon -R ${ocpath}/updater
