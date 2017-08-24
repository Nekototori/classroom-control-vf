class nginx (
$package = $nginx::params::package,
$owner = $nginx::params::owner,
$group = $nginx::params::group,
$docroot = $nginx::params::docroot,
$configdir = $nginx::params::confdir,
$logdir = $nginx::params::logdir,
$user = $nginx::params::user,
$port = $nginx::params::port
) inherits nginx::params {

File {
  owner  => $owner,
  group => $group,
  mode => '0644',
    }
    
package { $package:
  ensure => present,
  }

file { [ $docroot, "${configdir}/conf.d"]:
  ensure =>directory,
}

file { "${docroot}/index.html":
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
}

file { "${configdir}/nginx.conf":
  ensure => file,
  content => epp('nginx/nginx.conf.epp',
    {
        user => $user,
        configdir => $configdir,
        logdir => $logdir,
        }),
     notify => Service['nginx'],
  }
  
  file { "${configdir}/conf.d/default.conf":
    ensure => file,
    content => epp('nginx/default.conf.epp',
      {
      docroot => $docroot,
      }),
      notify => Service['nginx'],
  }
  
service { 'nginx':
ensure => 'running',
enable => 'true',
}
  
}
