# Installs Graphite web package
class graphite::web::package {

  package { 'graphite-web':
    ensure => installed,
  }
}
