# Start the requested Carbon services
class graphite::carbon::service (
  $cache = true,
  $relay = false,

  $aggregator = false) {
  $cachesvc = 'carbon-cache'
  $relaysvc = 'carbon-relay'
  $aggsvc   = 'carbon-aggregator'

  if ($cache) {
    service { $cachesvc:
      ensure  => running,
      enable  => true,
      require => Class['graphite::carbon::package'],
    }
  }

  if ($relay) {
    service { $relaysvc:
      ensure  => running,
      enabled => true,
      require => Class['graphite::carbon::package'],
    }
  }

  if ($aggregator) {
    service { $aggsvc:
      ensure  => running,
      enabled => true,
      require => Class['graphite::carbon::package'],
    }
  }
}
