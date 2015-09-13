define project::mysql ($project = $title, $createDb = true) {

  # add mysql database
  if ($createDb) {
    mysql::db::create { "db_$project":
      require => Package['mysql-server-5.6']
    }
  }
}