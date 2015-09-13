# options: http://php.net/manual/en/opcache.configuration.php
define opcache::config (
    $revalidate_freq         = '0',
    $validate_timestamps     = '0',
    $max_accelerated_files   = '7963',
    $memory_consumption      = '192',
    $interned_strings_buffer = '16',
    $fast_shutdown           = '1',
    $enable_cli              = '1'
) {


  $template = 'opcache/ini.erb'
  $ensure   = 'present'
  #$title = '/etc/php5/mods-available/opcache.ini'

  file { $title:
    ensure  => 'present',
    content => template($template),
    require => Package['php5-dev'],
    notify => Package['apache2'],
  }

# EXAMPLE


}
