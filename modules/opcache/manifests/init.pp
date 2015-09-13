class opcache () {

  # Zend OpCache Settings/Tuning/Config
  # source: https://www.scalingphpbook.com/best-zend-opcache-settings-tuning-config/
  opcache::config { '/etc/php5/mods-available/opcache.ini':
    revalidate_freq         => '60',
    validate_timestamps     => '1',
    max_accelerated_files   => '8000', # eg. there are 6000 files
    memory_consumption      => '256',
    interned_strings_buffer => '16',
    fast_shutdown           => '1',
    enable_cli              => '1'
  }
}
