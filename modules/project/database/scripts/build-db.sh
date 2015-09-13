#!/bin/bash
gunzip < /var/www/webroot/database/default_db.sql.gz | mysql -u vagrant -h localhost -ppassword default_db
