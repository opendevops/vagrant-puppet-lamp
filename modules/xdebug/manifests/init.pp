class xdebug ($service = 'apache2') {
  package { 'xdebug':
    name    => 'php5-xdebug',
    ensure  => installed,
    require => Package['php5'],
    notify  => Service[$service]
  }
}