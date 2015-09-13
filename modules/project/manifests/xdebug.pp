define project::xdebug {

  # xdebug config override
  xdebug::config { '/etc/php5/mods-available/xdebug.ini':
    remote_port => '9000',
    remote_host => '10.0.2.2',
    remote_connect_back => '1',
  }
}
