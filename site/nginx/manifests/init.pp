class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }
  package { 'nginx':
    ensure => present,
  }
  file { '/var/www/index.html':
    ensure => file,
    source => 'puppet:///module/nginx/index.html',
  }
  file { '/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///module/nginx/nginx.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  file { '/etc/nginx/conf.d':
    ensure => directory,
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///module/nginx/default.conf',
    require => Package['nginx'],
    notify => Service['nginx'],
  }
  service { 'nginx':
    ensure => running,
    enable => true,
  }  
}
