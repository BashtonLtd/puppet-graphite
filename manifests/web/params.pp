# Graphite params
class graphite::web::params {

  $storagedir    = '/var/lib/graphite-web'
  $sqlitedb      = "${storagedir}/graphite.db"
  $managepy      = '/usr/lib/python2.6/site-packages/graphite/manage.py'
  $localsettings = '/etc/graphite-web/local_settings.py'

  $wwwuser = $::osfamily ? {
    'Debian' => 'www-data',
    'RedHat' => 'apache',
    default  => 'apache'
  }

}
