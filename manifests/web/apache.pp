# Create suitable Apache vhost using puppetlabs apache module
class graphite::web::apache (
  $vhost = $graphite::web::params::default_vhost,
  $media_dir = $graphite::web::params::media_dir,
  $docroot   = $graphite::web::params::docroot
  ){

  include graphite::web::params

  apache::vhost { $vhost:
    port            => 80,
    access_log_file => $graphite::web::params::accesslog,
    error_log_file  => $graphite::web::params::errorlog,
    docroot         => $docroot,
    custom_fragment => template('graphite/web/apache_fragment.erb'),
    aliases         => [ {
      alias => '/media/',
      path  => '/usr/lib/python2.6/site-packages/django/contrib/admin/media/'
    }],
  }

}
