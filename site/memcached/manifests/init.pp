class memcached {

package { 'memcached':
  ensure => present,
  }
  
  file { '/etc/sysconfig/memcached':
  ensure => 'file',
  owner => 'root',
  group => 'root',
  source => 'puppet:///modules/memcached/memcached',
  require => Package['memcache']
#  content =>  PORT="11211"
#   USER="memcached"
#    MAXCONN="96"
#    CACHESIZE="32"
#    OPTIONS=""
  
  }
  service { 'memcached':
  ensure => running
  enable => true
  subscribe => File['/etc/sysconfig/memcached'],
  
  }
  
  }
