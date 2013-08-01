# Create storage fragments
define graphite::carbon::storage (
  $pattern,
  $retentions,
  $order = 100
) {

  concat::fragment { $name:
    target  => '/etc/carbon/storage-schemas.conf',
    order   => $order,
    content => template('graphite/carbon/storage-schemas.erb'),
    notify  => Class['graphite::carbon::service'],
  }
}

