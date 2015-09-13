define project::apache ($project = $title, $vhost = true, $config = true, $ports = true, $projectWebroot = $projectWebroot) {

  # add apache vhost
  if ($vhost) {
    apache::vhost { $project:
      projectWebroot => $projectWebroot
    }
  }

  # override global apache config
  apache::config { $project: }

  # override apache ports config
  apache::ports { $project: }
}
