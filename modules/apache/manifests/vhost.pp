define apache::vhost ($project = $title, $projectWebroot = $projectWebroot, $template = "project/vhost.erb") {

  # create apache virtualhost record (apache2.conf only reads the *.conf files in sites-enabled)
  file { "/etc/apache2/sites-available/$project.conf":
    ensure => present,
    content => template($template),
    require => Package["apache2"],
  }

  # symlink apache site to the site-enabled directory
  file { "/etc/apache2/sites-enabled/$project.conf":
    ensure => link,
    target => "/etc/apache2/sites-available/$project.conf",
    require => File["/etc/apache2/sites-available/$project.conf"],
    notify => Service["apache2"],
  }
}
