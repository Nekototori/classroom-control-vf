class nginx {

  package { 'nginx':
    ensure => present,
  }
  
  File {
    owner  => 'root',
    group  => 'root',
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
    require => Package['mginx'],
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
}
