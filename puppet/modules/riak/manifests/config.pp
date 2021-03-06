class riak::config inherits riak {


  group { 'riak':
    ensure => present,
    system => true,
  }
  user { 'riak':
    ensure  => present,
    system  => true,
    home    => '/var/lib/riak',
    require  => [
      Group['riak']
    ]
  }

  file { '/etc/default/riak':
    ensure => present,
    content => "ulimit -n $ulimit"
  }

  define param(
    $value = false,
    $config = '/etc/riak/riak.conf',
    $ensure = present
  ){
  	ini_setting { $name:
      ensure => $ensure,
      path => $config,
      section => '',
      setting => $name,
      value => $value
  	}
  }

  create_resources( riak::config::param, $riak_conf )
}
