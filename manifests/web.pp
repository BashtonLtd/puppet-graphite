# Install Graphite web interface
class graphite::web ($display_timezone = $graphite::web::params::display_timezone) {

  class { 'graphite::web::params': }
  class { 'graphite::web::package': }
  class { 'graphite::web::config': display_timezone => $display_timezone }
}
