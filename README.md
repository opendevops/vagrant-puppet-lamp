Open Dev Ops Stacks - lamp-puppet-ubuntu14.04
========================================

Optimised for 
```
puphpet/ubuntu1404-x64
```


## Quick Setup

1) Install virtualbox: https://www.virtualbox.org/wiki/Downloads

2) Install vagrant: https://www.vagrantup.com/downloads.html

3) From project folder > mac/linux rename the "Vagrantfile-nfs" to ""Vagrantfile" (windows rename "Vagrantfile-smb")

4) From project folder > vagrant ssh




## Setup vagrant

### 1) install virtualbox
Download VirtualBox Platform and VirtualBox Extension Pack
- https://www.virtualbox.org/wiki/Downloads

Create a Host-only network to ensure it's working
- File > Preferences > Network > Host-only Networks > Add host-only network

### 2) install vagrant
https://www.vagrantup.com/downloads.html

### 3) add vagrant box
eg. Ubuntu 14.04 with virtualbox
```
vagrant box add puphpet/ubuntu1404-x64 --provider virtualbox
```
eg. Ubuntu 14.04 with vmware
```
vagrant box add puphpet/ubuntu1404-x64 --provider vmware_desktop
```

### 4) vagrant init
If there's no Vagrantfile
```
cd {project_folder}
vagrant init puphpet/ubuntu1404-x64
```

### 5) Vagrantfile custom settings
Use either `Vagrantfile.vbox` or `Vagrantfile.vmware`


### 6) launch vagrant
```
vagrant up --provider=virtualbox
```
or 
```
vagrant up --provider=vmware_workstation
```


### 7) ssh into vagrant
```
vagrant ssh
```
or use MobaXterm to ssh in using the private_network ip (user=vagrant, pw=vagrant)



## Setup

1. Edit `Vagrantfile` and change the `VAGRANT_DOTFILE_PATH` projectname
```
VAGRANT_DOTFILE_PATH = 'C:\vagrant_machines\projectname'
```

2. Edit `manifests\default.pp` and add projectname
```
project {'projectname':
  useProjectDefault => false,
  useProjectCustom => true
}
```

3. Add the project module, eg. `modules\project-projectname`
- modules\project-projectname\database\build-db.sh
- modules\project-projectname\manifests\init.pp
- modules\project-projectname\templates\vhost.pp

4. Add project to webroot folder (eg. `webroot\projectname.dev`)

5. Add database dump (eg. webroot\database\projectname.sql.gz)



### Vagrant

loads 
```
vagrant up
```
This suspends the guest machine Vagrant is managing, rather than fully shutting it down or destroying it.
```
vagrant suspend
```
re-loads (after settings change)
```
vagrant provision
```
shut down
```
vagrant destroy
```



## Notes

### Mysqladmin

#### SSH Tunneling
SSH Host Address = 10.0.2.2
Username = vagrant
SSH Port = 22
Password = vagrant

#### MySQL username + password
username = root
password = password


### Xdebug

- Install include is here: `manifests/default.pp`
- Config is here: `modules/www-test/manifests/php.pp`
For example,
```
xdebug::config { '/etc/php5/mods-available/xdebug.ini':
    remote_port => '9000', # Change default settings
}
```


### Vagrant setup

1. install git with unix tools from cmd (http://git-scm.com/downloads)
```
Select "Use Git and optional Unix tools from the Windows Command Prompt"
Add the `Git\bin` folder to windows `path` environment variable, eg. ";C:\Program Files (x86)\Git\bin"
```
2. install VMware OR VirtualBox & extension pack (https://www.virtualbox.org/wiki/Downloads)
3. install vagrant (https://www.vagrantup.com/downloads.html)
4. test vagrant installation
```
vagrant --version
```
5. Add vagrant box
also see vagrantbox.es for more vagrant boxes
```
vagrant box add https://vagrantcloud.com/puphpet/ubuntu1404-x64
```
6. View the available vagrant boxes
```
vagrant box list
```
7. vagrant init - Make sure there is no pre-existing vagrant files or folders (eg. `Vagrantfile` and `.vagrant`)
```
cd {project_folder}
vagrant init puphpet/ubuntu1404-x64
```



### Vagrant Permissions

Can't set file permissions in vagrant




## Performance



## Vagrant Synced Folder Performance on Windows


### SMB

- docs: https://docs.vagrantup.com/v2/synced-folders/smb.html
- use the windows login username and password (can't be empty)

__example 1__
```
Vagrant.configure("2") do |config|
  config.vm.synced_folder ".", "/vagrant", type: "smb"
end
```

__example 2__
```
  # SMB synced folder (improves performance on windows)
  config.vm.synced_folder './webroot', '/var/www/webroot',
  :group => 'www-data',
  :owner => 'vagrant',
  :mount_options => ['dir_mode=0775', 'file_mode=0664'],
  :type => 'smb',
  :smb_username => 'pcUser',
  :smb_password => 'pcUser'
  # config.vm.synced_folder '.', '/vagrant', type: 'smb', smb_username: 'pcUser', smb_password: 'pcUser'
```

__Troubleshooting__

_Failed to mount folders in Linux guest._
- use the windows login username and password (can't be empty)


### RSYNC

1. Install mingw
2. In the mingw package installer gui find and install rsync and open-ssh
3. Modify your PATH to include the (...)\MinGW\msys\1.0\bin\ directory, so Vagrant can use what it needs

Vagrantfile example:
```
  config.vm.synced_folder ".", "/vagrant", :owner => "www-data", type: "rsync",
      rsync__exclude: ".git/"
```


### NFS


source: http://www.jankowfsky.com/blog/2013/11/28/nfs-for-vagrant-under-windows/

You can install the plugin by using 
```
vagrant plugin install vagrant-winnfsd
```

source: https://coderwall.com/p/uaohzg

and add `:nfs => true` to the Vagrantfile, example:
```
config.winnfsd.logging = 'on'
# Required for NFS to work, pick any local IP
config.vm.network :private_network, ip: '192.168.50.50'
# Use NFS for shared folders for better performance
config.vm.synced_folder '.', '/vagrant', nfs: true
```


if this doesn't work, uninstall the plugin
```
vagrant plugin uninstall vagrant-winnfsd
```





### Use more ram (eg. 4GB RAM)
```
vb.customize ["modifyvm", :id, "--memory", "4096"]
```

### Symfony Performance


__Improve dev assetic performance using assetic:watch__

By default, each asset path generated in the dev environment is handled dynamically by Symfony,
and assets could load noticeably slow.

By using the `assetic:watch` command, assets will be regenerated automatically as they change:

```
php app/console assetic:watch
```



__Optimize Symfony Autoloader__ 


```
cd /var/www/webroot/test.dev/
```

```
sudo php composer.phar dump-autoload --optimize 
```


__Move `cache` and `logs` folders outside the synced folder__

Here is the code you should add to your AppKernel to give you a considerable performance boost on a Vagrant box:
```
<?php

class AppKernel extends Kernel
{
    // ...

    public function getCacheDir()
    {
        if (in_array($this->environment, array('dev', 'test'))) {
            return '/dev/shm/appname/cache/' .  $this->environment;
        }

        return parent::getCacheDir();
    }

    public function getLogDir()
    {
        if (in_array($this->environment, array('dev', 'test'))) {
            return '/dev/shm/appname/logs';
        }

        return parent::getLogDir();
    }
}

This brings the page rendering speeds down to between 0.5 and 1.5 seconds, which is quite normal for the development environment even outside a virtual machine.
```


http://www.erikaheidi.com/blog/optimizing-symfony-applications-vagrant-boxes
http://www.whitewashing.de/2013/08/19/speedup_symfony2_on_vagrant_boxes.html



### TODO

- htaccess
- clean-up vhost
- setup db
- db build script
- test with vmware + virtualbox
- more notes to setup vmware
- behat
- improve readme instructions
- allow for different versions of php
- organise main README.md



### TODO - etc_root_password

Don't hardcode $etc_root_password = true (in /modules/mysql/manifests/init.pp). 
Instead use the override_options, for example:
```puppet
class { '::mysql::server':
   root_password    => 'strongpassword',
   override_options => { 'mysqld' => { 'max_connections' => '1024' } }
 }
```

