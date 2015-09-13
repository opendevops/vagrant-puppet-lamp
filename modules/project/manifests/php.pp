define project::php {

  # override global php
  php::ini { '/etc/php5/apache2/php.ini':
    #ensure                => '5.3.3',
    short_open_tag        => 'On',
    display_errors        => 'On',
    memory_limit          => '256M',
    upload_max_filesize   => '32M',
    date_timezone         => 'Australia/Melbourne',
#    error_reporting       => 'E_ALL & ~E_NOTICE',
    require               => Package['libapache2-mod-php5'],
    notify                => Service['apache2']
  }
}
