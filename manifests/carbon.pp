# == Class: graphite::carbon
#
# Install and configure carbon and whisper, enabling
# storage and retrieval of time series data
#
# === Parameters
#
# All parameters optional, distro defaults will be used if not
# specified
#
# [**]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { graphite:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
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
  $cache_enabled               = true,
  $use_ppa                     = true,
  $max_updates_per_second      = '500',
  $max_creates_per_minute      = '50',
  $whisper_autoflush           = 'False',
  $whisper_sparse              = 'False',
  $carbon_metric_prefix        = 'carbon',
  $carbon_metric_interval      = '60',
  $flow_control                = 'True',
  $line_interface              = '0.0.0.0',
  $line_port                   = '2003',
  $pickle_interface            = '0.0.0.0',
  $pickle_port                 = '2004',
  $pickle_insecure             = 'False',
  $query_interface             = '0.0.0.0',
  $query_port                  = '7002',
  $amqp                        = 'False',
  $amqp_host                   = undef,
  $amqp_port                   = '5672',
  $amqp_vhost                  = undef,
  $amqp_user                   = undef,
  $amqp_pass                   = undef,
  $amqp_exchange               = undef,
  $amqp_metric_body            = 'False',
  $relay_enabled               = false,
  $relay_line_interface        = '0.0.0.0',
  $relay_line_port             = '2013',
  $relay_pickle_interface      = '0.0.0.0',
  $relay_pickle_port           = '2014',
  $relay_method                = 'rules',
  $relay_replication           = '1',
  $relay_destinations          = '127.0.0.1:2004',
  $aggregator_enabled          = false,
  $aggregator_line_interface   = '0.0.0.0',
  $aggregator_line_port        = '2023',
  $aggregator_pickle_interface = '0.0.0.0',
  $aggregator_pickle_port      = '2024',
  $aggregator_destinations     = '127.0.0.1:2004',
  $aggregator_max_intervals    = '5',
  $aggregator_replication      = '1'
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
