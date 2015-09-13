# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

## MODULE INCLUDES
# ensure local apt cache index is up to date before beginning
include bootstrap

# install listed packages with apt-get update (curl, vim, htop, git, openssl)
include tools

# install testing tools (xvfb, firefox) and fonts?
#include testing

# install apache
include apache

# install and configure php
include php
include php::pear
include php::pecl

# install and configure xdebug
include xdebug

# install and start mysql + set root password
include mysql

# configure opcache (only for php 5.5+)
include opcache

# install and configure nodejs
# npm, bower, grunt-cli, gulp, less, yo, react, karma
include nodejs

# install ruby
include ruby

#install java
include java


# DEFAULT PROJECT
project {'test':
  useProjectDefault => true,
  projectWebroot => '/test/project',
  databaseName => 'test'
}

## SECONDARY PROJECT(s)

project {'test2':
  useProjectCustom => true,
  projectWebroot => '/apps/test2/project',
  databaseName => 'test2',
  require => Package['apache2']
}

