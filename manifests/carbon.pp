# == Class: graphite::carbon
#
# Install and configure carbon and whisper, enabling
# storage and retrieval of time series data
#
# === Authors
#
# Sam Bashton <sam@bashton.com>
#
# === Copyright
#
# Copyright 2013 Bashton Ltd
#
class graphite::carbon (
  $cache_enabled               = graphite::params::cache_enabled,
  $use_ppa                     = graphite::params::use_ppa,
  $max_updates_per_second      = graphite::params::max_updates_per_second,
  $max_creates_per_minute      = graphite::params::max_creates_per_minute,
  $whisper_autoflush           = graphite::params::whisper_autoflush,
  $whisper_sparse              = graphite::params::whisper_sparse,
  $carbon_metric_prefix        = graphite::params::carbon_metric_prefix,
  $carbon_metric_interval      = graphite::params::carbon_metric_interval,
  $flow_control                = graphite::params::flow_control,
  $line_interface              = graphite::params::line_interface,
  $line_port                   = graphite::params::line_port,
  $pickle_interface            = graphite::params::pickle_interface,
  $pickle_port                 = graphite::params::pickle_port,
  $pickle_insecure             = graphite::params::pickle_insecure,
  $query_interface             = graphite::params::query_interface,
  $query_port                  = graphite::params::query_port,
  $amqp                        = graphite::params::amqp,
  $amqp_host                   = graphite::params::amqp_host,
  $amqp_port                   = graphite::params::amqp_port,
  $amqp_vhost                  = graphite::params::amqp_vhost,
  $amqp_user                   = graphite::params::amqp_user,
  $amqp_pass                   = graphite::params::amqp_pass,
  $amqp_exchange               = graphite::params::amqp_exchange,
  $amqp_metric_body            = graphite::params::amqp_metric_body,
  $relay_enabled               = graphite::params::relay_enabled,
  $relay_line_interface        = graphite::params::relay_line_interface,
  $relay_line_port             = graphite::params::relay_line_port,
  $relay_pickle_interface      = graphite::params::relay_pickle_interface,
  $relay_pickle_port           = graphite::params::relay_pickle_port,
  $relay_method                = graphite::params::relay_method,
  $relay_replication           = graphite::params::relay_replication,
  $relay_destinations          = graphite::params::relay_destinations,
  $aggregator_enabled          = graphite::params::aggregator_enabled,
  $aggregator_line_interface   = graphite::params::aggregator_line_interface,
  $aggregator_line_port        = graphite::params::aggregator_line_port,
  $aggregator_pickle_interface = graphite::params::aggregator_pickle_interface,
  $aggregator_pickle_port      = graphite::params::aggregator_pickle_port,
  $aggregator_destinations     = graphite::params::aggregator_destinations,
  $aggregator_max_intervals    = graphite::params::aggregator_max_intervals,
  $aggregator_replication      = graphite::params::aggregator_replication
  ) {

    class { 'graphite::carbon::package': }

    class { 'graphite::carbon::service':
      cache      => $cache_enabled,
      relay      => $relay_enabled,
      aggregator => $aggregator_enabled,
    }

    file { '/etc/carbon/carbon.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template('graphite/carbon/carbon.conf.erb'),
      notify  => Class['graphite::carbon::service'],
    }

    concat { '/etc/carbon/storage-schemas.conf':
      owner  => 'root',
      group  => 'root' ,
      mode   => '0644',
      notify => Class['graphite::carbon::service'],
    }

    concat::fragment { 'header':
      order  => 1,
      target => '/etc/carbon/storage-schemas.conf',
      source => 'puppet:///modules/graphite/carbon/storage-schemas.conf.header',
      notify => Class['graphite::carbon::service'],
    }

}
