#!/bin/bash
WORK IN PROGRESS
sudo find /var/www/html -type f -print0 | sudo xargs -0 chmod 0640
sudo find /var/www/html -type d -print0 | sudo xargs -0 chmod 0750
sudo chown -R root:apache /var/www/html
sudo chown -R apache:apache /var/www/html/apps
sudo chown -R apache:apache /var/www/html/config
sudo chown -R apache:apache /var/www/html/themes
sudo chown -R apache:apache /var/www/html/updater
sudo chmod 0644 /var/www/html/.htaccess
sudo chown root:apache /var/www/html/.htaccess
sudo chmod 0644 /var/www/html/data/.htaccess
sudo chown root:apache /var/www/html/data/.htaccess
