class nginx (
$package = $nginx::params::package,
$owner = $nginx::params::owner,
$group = $nginx::params::group,
$docroot = $nginx::params::docroot,
$confdir = $nginx::params::confdir,
$logdir = $nginx::params::logdir,
$user = $nginx::params::user,
$port = $nginx::params::port
) inherits nginx::params {

notify {"Platform OS is: ${facts['os']['family']}":}

File {
owner => $owner,
group => $group,
mode => '0664',
} 

package { $package:
ensure => present,
} 

file { [ $docroot, "${confdir}/conf.d" ]:
ensure => directory,
} 

file { "${docroot}/index.html":
ensure => file,
source => 'puppet:///modules/nginx/index.html',
}

file { "${confdir}/nginx.conf":
ensure => file,
content => epp('nginx/nginx.conf.epp',
{
platform_nginx_user => $user,
platform_nginx_confdir => $confdir,
platform_nginx_logdir => $logdir,
platform_nginx_run_pid_path => $run_pid_path,
}),
notify => Service['nginx'],
}

file { "${confdir}/conf.d/default.conf":
ensure => file,
content => epp('nginx/default.conf.epp',
{
platform_docroot => $docroot,
}),
notify => Service['nginx'],
} 

service { 'nginx':
ensure => running,
enable => true,
}

}
