project
========================


- make sure project folder (eg. webroot/project.dev) is created (or add that to project/manifest/init.pp


### Database

```
cd /vagrant/modules/project/database
./v-db-build.sh
```


### Cache folder
```
/var/www/tmp/$project/cache
```
example:
```
/var/www/tmp/test/cache
```


### Logs folder
```
/var/www/tmp/$project/logs
```
example:
```
/var/www/tmp/test/logs
```






### Clear cache

```
cd /vagrant/modules/project/scripts
sudo ./v-clear-cache.sh
```


### Error log

apache error log
```
cd /var/log/apache2
tail -f error.log
```

app error log
```
cd /var/www/tmp/project/logs
```
or
```
cd /var/www/webroot/project/app/tmp/logs
```
