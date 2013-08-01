# Install Graphite web interface
class graphite::web {

  class { 'graphite::web::params': }
  class { 'graphite::web::package': }
  class { 'graphite::web::config': }
}
