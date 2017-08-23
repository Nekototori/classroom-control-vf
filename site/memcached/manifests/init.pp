class memchached{

  package { 'memcached':
    ensure => present
  }
  file { '/etc/sysconfig/memcached':
    ensure => 'present',
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/memcached/memcached',
    require => Package['memcached'],
  }
  service {'memcached':
    ensure  => 'running',
    enabled => true,
    subscribe => File['/etc/sysconfig/memcached']
  }
}
