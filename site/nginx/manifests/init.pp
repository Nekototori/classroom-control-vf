class nginx {

file { '/etc/nginx/nginx.conf',
ensure =>file,
owner => 'root',
group => 'root',
source => 'puppet:///modules/nginx/files/nginx.conf',
}
file { '/var/wwww':
ensure => directory,
owner => 'root',
group => 'root',
}
file { '/var/www/index.html':
ensure => file,
owner => 'root',
group => 'root',
source => 'puppet:///modules/nginx/files/index.html',
}
package { 'nginx':
ensure => installed,
name => $ngin
}
service { 'nginx':
ensure => 'running',
enable => 'true',
}
  
}
