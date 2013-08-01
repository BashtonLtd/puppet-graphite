# Installs appropriate carbon package
class graphite::carbon::package {

  $package_name = 'python-carbon'

  package { $package_name:
    ensure => installed,
  }

}
