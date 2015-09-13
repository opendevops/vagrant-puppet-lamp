class ruby {

  $packages = [
    'git-core',
    'zlib1g-dev',
    'build-essential',
    'libssl-dev',
    'libreadline-dev',
    'libyaml-dev',
    'libsqlite3-dev',
    'sqlite3',
    'libxml2-dev',
    'libxslt1-dev',
    'libcurl4-openssl-dev',
    'python-software-properties',
    'libffi-dev',
#    'rails'
  ]

  # install packages
  package { $packages:
    ensure => present,
    require => Exec['apt-get update']
  }

  # install rails
  package { 'rails':
    ensure => present,
    require => Package['build-essential']
  }

  # ruby gems integration
  exec { 'gem_rails':
    command => 'sudo -i gem install rails -v 4.2.1',
  require => Package['rails']
  }

  # install foundation
  exec { 'gem_install_foundation':
    command => 'sudo -i gem install foundation',
    require => Exec['gem_rails']
  }
  # install sass
  exec { 'gem_install_sass':
    command => 'sudo -i gem install sass',
    require => Exec['gem_install_foundation']
  }
  # install compass
  exec { 'gem_install_compass':
    command => 'sudo -i gem install compass',
    require => Exec['gem_install_sass']
  }
}
