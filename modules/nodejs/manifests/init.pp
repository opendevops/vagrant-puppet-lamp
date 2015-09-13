class nodejs {

  # additional package install list (on top of /modules/tools/manifests)
  $packages = [
    'nodejs-legacy',
    'npm',
  ]

  # install packages
  package { $packages:
    ensure => present,
    require => Exec['apt-get update']
  }

  # install bower - Package manager
  # https://www.npmjs.com/package/bower
  exec{'install_bower':
    command => 'npm install -g bower',
    require => Package['npm']
  }
  # install grunt-cli - JavaScript Task Runner
  # https://www.npmjs.com/package/grunt-cli
  exec { 'install_grunt_cli':
    command => 'npm install -g grunt-cli',
    require => Package['npm']
  }
  # install gulp - Streaming build system
  # https://www.npmjs.com/package/gulp
  exec { 'install_gulp':
    command => 'npm install -g gulp',
    require => Package['npm']
  }
  # install less - Compiled CSS
  # https://www.npmjs.com/package/less
  exec { 'install_less':
    command => 'npm install -g less',
    require => Package['npm']
  }
  # install yeoman - Scaffolding tool for modern webapps
  # https://www.npmjs.com/package/yo
  exec { 'install_yo':
    command => 'npm install -g yo',
    require => Package['npm']
  }
  # install react - JavaScript library for building user interfaces
  # https://www.npmjs.com/package/react
  exec { 'install_react':
    command => 'npm install -g react',
    require => Package['npm']
  }
  # install karma - Testing
  # https://www.npmjs.com/package/karma
  exec { 'install_karma':
    command => 'npm install -g karma',
    require => Package['npm']
  }

  # setup for node 0.12 - run after npm
  # see https://nodesource.com/blog/nodejs-v012-iojs-and-the-nodesource-linux-repositories
  exec { 'node_012_setup':
    command => 'curl -sL https://deb.nodesource.com/setup_0.12 | sh',
    require => Package['npm']
  }
  # upgrade nodejs to 0.12
  exec { 'node_update':
    command => 'apt-get install -y nodejs',
    require => Exec['node_012_setup']
  }
}
