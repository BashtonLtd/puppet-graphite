node default {

  class { 'apache': }
  class { '::apache::mod::wsgi': }
  class { 'epel': }->
  class { 'graphite::carbon':
    whisper_sparse => 'True',
  }->
  class { 'graphite::web': }->
  class { 'graphite::web::apache': vhost => 'example.vhost' }

  graphite::carbon::storage { 'default':
    order      => 50,
    pattern    => '.*',
    retentions => '1m:1y,15m:3y',
  }
}
