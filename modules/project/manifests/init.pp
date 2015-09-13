define project (
  $project = $title,
  $databaseName = $databaseName,
  $createProjectTmpFolder = true,

  # default project module
  $projectWebroot         = '',
  $useProjectDefault      = false,
  $defaultVhost           = true,
  $defaultCreateDb        = true,
  $enableApache           = true,
  $enablePhp              = true,
#  $enableRuby             = true,
#  $enableNodeJs           = true,
  $enableXdebug           = true,
  $enableMysql            = true,
  $createTmpFolder        = true,

  # custom project module
  $useProjectCustom       = false,
) {

  # project modules
  if ($useProjectDefault) {
    # apache
    if ($enableApache) {
      project::apache{ $project:
        vhost => $defaultCreateDb,
        projectWebroot => $projectWebroot,
      }
    }
    # php
    if ($enablePhp) {
      project::php{ $project: }
    }
#    if ($enableRvm) {

#    }
#    # ruby
#    if ($enableRuby) {
#      project::ruby{ $project: }
#    }
#    # nodejs
#    if ($enableNodeJs) {
#      project::nodejs{ $project: }
#    }
    # xdebug
    if ($enableXdebug) {
      project::xdebug{ $project: }
    }
    # mysql
    if ($enableMysql) {
      project::mysql{ $project:
        createDb => $defaultCreateDb
      }
    }

    # tmp folder
    if ($createTmpFolder) {
      file { ['/var/www/tmp']:
        ensure => 'directory',
        group  => 'www-data',
        owner  => 'www-data',
        mode   => 0777
      }
    }
  }

  # project cache & logs folder
  if ($createProjectTmpFolder) {
    # cache and log folders
    file { ["/var/www/tmp/$project", "/var/www/tmp/$project/cache", "/var/www/tmp/$project/logs"]:
      ensure => 'directory',
      group  => 'www-data',
      owner  => 'www-data',
      mode   => 0777,
      require => File['/var/www/tmp']
    }
  }

  # include custom project module
  if ($useProjectCustom) {
    # apache
    apache::vhost { $project:
      template => "project/vhost.erb",
      projectWebroot => $projectWebroot,

    }
    # add mysql databases
    mysql::db::create { $databaseName:
      require => Package['mysql-server-5.6']
    }
    #include "project-$project"
  }
}
