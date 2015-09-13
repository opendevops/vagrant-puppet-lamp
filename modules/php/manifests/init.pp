class php {

  ##
  # PACKAGE NOTES

#  Package: libapache2-mod-php5
#  The following extensions are built in: bcmath bz2 calendar Core ctype date
#  dba dom ereg exif fileinfo filter ftp gettext hash iconv json libxml
#  mbstring mhash openssl pcre Phar posix Reflection session shmop SimpleXML
#  soap sockets SPL standard sysvmsg sysvsem sysvshm tokenizer wddx xml xmlreader xmlwriter zip zlib


# package install list
  $packages = [
    'php-pear',
    'php5',
    'libapache2-mod-php5'
  ]

  package { $packages:
    ensure => 'present',
    require => Exec['apt-get update']
  }

  ##
  # MODULES

  $modules = [
    'curl', # connect and communicate to many different types of servers with many different types of protocols
    'cli', # standalone binary file that can be used to run php script locally on the server
    'mysql', # provides modules for MySQL database connections directly from PHP scripts
    'dev', # provides the files from the PHP5 source needed for compiling additional modules
    'gd', # handles graphics directly from PHP scripts. It supports the PNG, JPEG, XPM formats and Freetype/ttf fonts
    'json',
    'common',
    'rrd', # high performance data logging and graphing system for time series data
    'sasl',
    'intl',
    'mcrypt',
    'apcu'
  ]

  # TODO: require libapache2-mod-php5?
  php::module { $modules:
    ensure => 'present',
    require => Exec['apt-get update'],
#    require => Package['libapache2-mod-php5'],
    notify => Service['apache2']
  }

  # enable mcrypt
  exec { "EnableModule_mcrypt":
    command  => "php5enmod mcrypt",
    require => Package['php5-mcrypt'],
  }

}
