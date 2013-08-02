# Graphite params
class graphite::web::params {

  $display_timezone      = 'UTC'
  $storagedir    = '/var/lib/graphite-web'
  $sqlitedb      = "${storagedir}/graphite.db"
  $managepy      = '/usr/lib/python2.6/site-packages/graphite/manage.py'
  $localsettings = '/etc/graphite-web/local_settings.py'
  $default_vhost = 'graphite-web'
  $media_dir = '/usr/lib/python2.6/site-packages/django/contrib/admin/media/'
  $docroot   = '/usr/share/graphite/webapp'
  $accesslog = 'graphite-web-access.log'
  $errorlog  = 'graphite-web-error.log'

  $wwwuser = $::osfamily ? {
    'Debian' => 'www-data',
    'RedHat' => 'apache',
    default  => 'apache'
  }

}
