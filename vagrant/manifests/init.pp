node default {

  class { 'epel': }->
  class { 'graphite::carbon':
    whisper_sparse => 'True',
  }->
  class { 'graphite::web': }

  graphite::carbon::storage { 'default':
    order      => 50,
    pattern    => '.*',
    retentions => '1m:1y,15m:3y',
  }
}
