class testing {

# package install list
  $packages = [
  # xvfb (for selenium / behat testing)
    'xvfb',
    'x11-xkb-utils',
    'xfonts-100dpi',
    'xfonts-75dpi',
    'xfonts-scalable',
    'xfonts-cyrillic',
    'x11-apps',
  # browsers
    'firefox',
  ]

# install packages
  package { $packages:
    ensure => present,
    require => Exec['apt-get update']
  }
}
