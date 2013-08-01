# Configures graphite web interface and creates an sqlite DB
class graphite::web::config (
  $storagedir = $graphite::web::params::storagedir,
  $sqlitedb   = $graphite::web::params::sqlitedb,
  $display_timezone = $graphite::web::params::display_timezone) {


  file { $graphite::web::params::localsettings:
    ensure    => file,
    owner     => 'root',
    group     => 'root',
    mode      => '0644',
    content   => template('graphite/web/local_settings.py.erb'),
    require   => Package['graphite-web'],
  }

  $managepy = $graphite::web::params::managepy

  exec { 'create_sqlite':
    command => "/usr/bin/python ${managepy} syncdb --noinput",
    user    => $graphite::web::params::wwwuser,
    creates => $sqlitedb,
    require => File[$graphite::web::params::localsettings],
  }
}
