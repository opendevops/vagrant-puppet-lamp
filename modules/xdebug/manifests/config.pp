# http://xdebug.org/docs/all_settings
define xdebug::config (
  $default_enable          = 1,
  $remote_autostart        = 0,
  $remote_connect_back     = 1, # 0
  $remote_enable           = 1,
  $remote_handler          = 'dbgp',
  $remote_host             = 'localhost', # localhost
  $remote_mode             = 'req',
  $remote_port             = 9000,
  $show_exception_trace    = 0,
  $show_local_vars         = 0,
  $var_display_max_data    = 10000,
  $var_display_max_depth   = 20,
  $max_nesting_level       = 250,
  $profiler_enable         = 1, # 0
  $profiler_enable_trigger = 1,
  $profiler_output_name    = "cachegrind.out.%t.%p",
  $profiler_output_dir     = '/vagrant/profiler_output',
  $idekey                  = 'ide-xdebug'
) {

  $settings = {
    default_enable          => $default_enable,
    remote_autostart        => $remote_autostart,
    remote_connect_back     => $remote_connect_back,
    remote_enable           => $remote_enable,
    remote_handler          => $remote_handler,
    remote_host             => $remote_host,
    remote_mode             => $remote_mode,
    remote_port             => $remote_port,
    show_exception_trace    => $show_exception_trace,
    show_local_vars         => $show_local_vars,
    var_display_max_data    => $var_display_max_data,
    var_display_max_depth   => $var_display_max_depth,
    max_nesting_level       => $max_nesting_level,
    profiler_enable         => $profiler_enable,
    profiler_enable_trigger => $profiler_enable_trigger,
    profiler_output_name    => $profiler_output_name,
    profiler_output_dir     => $profiler_output_dir,
    idekey                  => $idekey
  }

  $template = 'xdebug/ini.erb'
  $ensure   = 'present'

  file { $title:
    ensure  => 'present',
    content => template($template),
    require => Package['xdebug'],
    notify => Package['apache2'],
  }

  # EXAMPLE
  # $title = '/etc/php5/mods-available/xdebug.ini'
  # xdebug::config { $title:
  #   remote_port => '9000', # Change default settings
  # }

}
