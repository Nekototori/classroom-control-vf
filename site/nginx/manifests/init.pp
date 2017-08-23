class nginx {
<<<<<<< HEAD
package { 'nginx':
ensure => present,
}
file { '/var/www':
ensure => directory,
owner => 'root',
group => 'root',
mode => '0775',
}
file { '/var/www/index.html':
ensure => file,
owner => 'root',
group => 'root',
mode => '0664',
source => 'puppet:///modules/nginx/index.html',
}
file { '/etc/nginx/nginx.conf':
ensure => file,
owner => 'root',
group => 'root',
mode => '0664',
source => 'puppet:///modules/nginx/nginx.conf',
require => Package['nginx'],
notify => Service['nginx'],
}
file { '/etc/nginx/conf.d':
ensure => directory,
owner => 'root',
group => 'root',
mode => '0775',
}
file { '/etc/nginx/conf.d/default.conf':
ensure => file,
owner => 'root',
group => 'root',
mode => '0664',
source => 'puppet:///modules/nginx/default.conf',
require => Package['nginx'],
notify => Service['nginx'],
}
service { 'nginx':
ensure => running,
enable => true,
}
=======

  package { 'nginx':
    ensure => present,
  }
  
  File {
    owner  => 'root',
    group  => 'root',
    mode => '0644',
  }

  file { '/var/www':
    ensure => directory,
  }
  
  file { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
  }
  
  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
  }
  
  service { 'nginx':
    ensure => 'running',
    enable => true,
    subscribe => File['/etc/nginx/nginx.conf'],
  }
>>>>>>> e0db9d0614fe978f7ec97c11a693df0a6dcf3854
}
