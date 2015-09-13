class java {

  $packages = [
      'default-jre',
  ]

  # install packages
  package { $packages:
    ensure => present,
    require => Exec['apt-get update']
  }
}
