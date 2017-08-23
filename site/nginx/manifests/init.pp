class nginx{

  package{'nginx':
    ensure => present
  }
  file {'/var/www':
    ensure => directory,
  }
  file {'/var/www/index.html':
    ensure => file
    owner  => 'root',
    groups => 'root',
    source => 'puppet:///modules/nginx/index.html',
  }

  file {'/etc/nginx/nginx.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/nginx/nginx.conf
  }
  file {'/etc/nginx/conf.d':
    ensure => directory,
  }
  file {'/etc/nginx/conf.d/default.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    source => 'puppet:///modules/nginx/nginx.conf
  }
  service{ 'nginx':
    ensure => 'running',
    enable => true,
  }
}
