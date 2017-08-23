class nginx {

File {
  owner  => 'root',
  group => 'root',
  mode => '0644',
    }


file { '/etc/nginx/nginx.conf',
source => 'puppet:///modules/nginx/nginx.conf',
}
file { '/var/wwww':
ensure => directory,

}
file { '/var/www/index.html':
source => 'puppet:///modules/nginx/index.html',
}

file { '/etc/nginx/conf.d',
  ensure => directory
  }
  
  file { '/etc/nginx/conf.d/default.conf':
    source => puppet:///modules/nginx/default.conf
  }
package { 'nginx':
ensure => installed,

}
service { 'nginx':
ensure => 'running',
enable => 'true',
}
  
}
