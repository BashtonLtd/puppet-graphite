# Default parameters for carbon
class graphite::carbon::params {

  $cache_enabled               = true
  $use_ppa                     = true
  $max_updates_per_second      = '500'
  $max_creates_per_minute      = '50'
  $whisper_autoflush           = 'False'
  $whisper_sparse              = 'False'
  $carbon_metric_prefix        = 'carbon'
  $carbon_metric_interval      = '60'
  $flow_control                = 'True'
  $line_interface              = '0.0.0.0'
  $line_port                   = '2003'
  $pickle_interface            = '0.0.0.0'
  $pickle_port                 = '2004'
  $pickle_insecure             = 'False'
  $query_interface             = '0.0.0.0'
  $query_port                  = '7002'
  $amqp                        = 'False'
  $amqp_host                   = undef
  $amqp_port                   = '5672'
  $amqp_vhost                  = undef
  $amqp_user                   = undef
  $amqp_pass                   = undef
  $amqp_exchange               = undef
  $amqp_metric_body            = 'False'
  $relay_enabled               = false
  $relay_line_interface        = '0.0.0.0'
  $relay_line_port             = '2013'
  $relay_pickle_interface      = '0.0.0.0'
  $relay_pickle_port           = '2014'
  $relay_method                = 'rules'
  $relay_replication           = '1'
  $relay_destinations          = '127.0.0.1:2004'
  $aggregator_enabled          = false
  $aggregator_line_interface   = '0.0.0.0'
  $aggregator_line_port        = '2023'
  $aggregator_pickle_interface = '0.0.0.0'
  $aggregator_pickle_port      = '2024'
  $aggregator_destinations     = '127.0.0.1:2004'
  $aggregator_max_intervals    = '5'
  $aggregator_replication      = '1'

}
