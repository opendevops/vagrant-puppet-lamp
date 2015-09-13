define apache::config ($domain = $title, $template = "project/apache2.erb") {

  # set the apache config
  file {'/etc/apache2/apache2.conf':
    ensure => 'present',
    content => template($template),
    require => Package['apache2'],
    notify => Service['apache2']
  }
}
