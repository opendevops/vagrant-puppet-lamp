class apache {

  # install apache
  package { 'apache2':
    ensure => present,
    require => Exec['apt-get update']
  }

# starts the apache2 service once the packages installed, and monitors changes to its configuration files and reloads if nesessary
  service { 'apache2':
    ensure => running,
    enable  => true,
    require => Package['apache2'],
    subscribe => [
      File['/etc/apache2/mods-enabled/rewrite.load'],
    # File['/etc/apache2/sites-available/webroot.dev.conf']
    ],
  }

  # ensures that mode_rewrite is loaded and modifies the default configuration file
  file { '/etc/apache2/mods-enabled/rewrite.load':
    ensure => link,
    target => '/etc/apache2/mods-available/rewrite.load',
    require => Package['apache2']
  }

  # create directory
  # NB. this will purge /etc/apache2/sites-enabled/000-default.conf
  file {'/etc/apache2/sites-enabled':
    ensure => directory,
    recurse => true,
    purge => true,
    force => true,
    # before => File['/etc/apache2/sites-enabled/webroot.dev.conf'],
    require => Package['apache2'],
  }


#  # Change the web user to the vagrant user
#  exec { 'ApacheUserChange' :
#    command => 'sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars',
#    onlyif  => 'grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars',
#    require => Package['apache2'],
#    notify  => Service['apache2'],
#  }
#
#  # Change the web group to the vagrant group
#  exec { 'ApacheGroupChange' :
#    command => 'sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars',
#    onlyif  => 'grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars',
#    require => Package['apache2'],
#    notify  => Service['apache2'],
#  }

}
