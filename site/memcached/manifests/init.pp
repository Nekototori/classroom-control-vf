class memcached {

package { 'memcached':
ensure => present,
} 

file { '/etc/sysconfig/memcached':
ensure => file,
owner => 'root',
group => 'root',
mode => '0644',
source => 'puppet:///modules/memcached/memcached',
#content => 'PORT="11211"
#USER="memcached"
#MAXCONN="96"
#CACHESIZE="32"
#OPTIONS=""',
require => Package['memcached'],
} 

service { 'memcached':
ensure => running,
enable => true,
subscribe => File['/etc/sysconfig/memcached'],
}

}
