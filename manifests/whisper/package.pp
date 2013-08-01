# Installs appropriate whisper package
class graphite::whisper::package {
  $package_name = 'python-whisper'

  package { $package_name:
    ensure => installed,
  }

}
