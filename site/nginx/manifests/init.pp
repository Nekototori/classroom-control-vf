class nginx {

case $facts['os']['family'] {
  'redhat','debain' : {
  $package = 'nginx'
  $owner = 'root'
  $group = 'root'
  $docroot = '/var/www'
  $configdir = '/etc/nginx'
  $logdir = '/var/log/nginx'
}
'windows' : {
  $package = 'nginx-service'
  $owner = 'Administrator'
  $group = 'Administrators'
  $docroot = 'C:/ProgramData/nginx/html'
  $configdir = 'C:/ProgramData/nginx'
  $logdir = 'C:/ProgramData/nginx/logs'
}
default : {
fail("Module ${module_name} is not supported on ${facts['os']['family']}")
}
# user the service will run as. Used in the nginx.conf.epp template
$user = $facts['os']['family'] ? {
'redhat' => 'nginx',
'debian' => 'www-data',
'windows' => 'nobody',
}

File {
  owner  => $owner,
  group => $group,
  mode => '0644',
    }


file { [ ${docroot}, "${configdir}/conf.d"]:
  ensure =>directory,
}
file { '/var/wwww':
ensure => directory,

}
file { "${docroot}/index.html":
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
}

file { ${configdir}/nginx.conf":
  ensure => file
  content => epp('nginx.nginx.conf.epp
    {
        user => $user,
        configdir => %configdir,
        logdir => $logdir,
        }),
     notifty => Service['nginx'],
  }
  
  file { "${configdir}/conf.d/default.conf":
    ensure => file
    content => epp('nginx/default.conf.epp
  }
service { 'nginx':
ensure => 'running',
enable => 'true',
}
  
}
