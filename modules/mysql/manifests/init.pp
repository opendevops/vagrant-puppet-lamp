class mysql ($root_password = 'password', $config_path = 'puppet:///modules/mysql/vagrant.cnf') {
  $bin = '/usr/bin:/usr/sbin'

# install mysql server
  if ! defined(Package['mysql-server-5.6']) {
    package { 'mysql-server-5.6':
      ensure => 'present',
      require => Exec["apt-get update"]
    }
  }

  if ! defined(Package['mysql-client-5.6']) {
    package { 'mysql-client-5.6':
      ensure => 'present',
      require => Exec["apt-get update"]
    }
  }

  #start mysql service
  service { 'mysql':
    alias   => 'mysql::mysql',
    enable  => 'true',
    ensure  => 'running',
    require => Package['mysql-server-5.6', 'mysql-client-5.6'],
  }

  # Override default MySQL settings.
  file { '/etc/mysql/conf.d/vagrant.cnf':
    owner   => 'mysql',
    group   => 'mysql',
    mode   => '0660',
    source  => $config_path,
    notify  => Service['mysql::mysql'],
    require => Package['mysql-server-5.6'],
  }


  # Set the root password.
  exec { 'mysql::set_root_password':
    unless  => "mysqladmin -uroot -p${root_password} status",
    command => "mysqladmin -uroot password ${root_password}",
    path    => $bin,
    require => Service['mysql::mysql'],
  }

#  # Cache the mysql vagrant password
#  file { '/vagrant/.my.cnf':
##  file { '/etc/my.cnf':
#    owner   => 'root',
#    group   => 'root',
#    mode   => '0660',
#    source  => 'puppet:///modules/mysql/my.cnf',
#    notify  => Service['mysql::mysql'],
##    require => Package['mysql-server-5.6'],
##    require => Package['mysql-client-5.6']
#  }


# Delete the anonymous accounts.
  mysql::user::drop { 'anonymous':
    user => '',
  }
}

