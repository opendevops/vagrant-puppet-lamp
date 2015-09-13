define apache::ports ($domain = $title, $template = "project/ports.erb") {

  # set the apache ports config
  file {'/etc/apache2/ports.conf':
    ensure => 'present',
    content => template($template),
    require => Package['apache2'],
    notify => Service['apache2']
  }
}
