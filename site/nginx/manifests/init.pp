class nginx (
  String $docroot      = $nginx::params::docroot,
  String $service_user = $nginx::params::service_user,
  String $config_dir   = $nginx::params::config_dir,
  String $log_dir      = $nginx::params::log_dir,
  String $file_owner   = $nginx::params::file_owner,
  String $file_group   = $nginx::params::file_group,
  String $package      = $nginx::params::package,
) inherits nginx::params {
  
  
  File {
    owner => $file_owner,
    group => $file_group,
    mode  => '0644',
  }
  
  
  package { $package:
    ensure => present,
  }

  file { [$docroot, "${confdir}/conf.d"]:
    ensure => directory,
  }
  
  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${config_dir}/nginx.conf":
    ensure => file,
    content => epp('nginx/nginx.conf.epp',
      {
        user => $service_user,
        config_dir => $config_dir,
        log_dir => $log_dir,
        }),
    notify => Service['nginx'],
  }
  
  file { "${config_dir}/conf.d/default.conf":
    ensure => file,
    content => epp('nginx/default.conf.epp',
      {
        docroot => $docroot
        }),
    notify => Service['nginx'],
  }
  
  service { 'nginx':
    ensure => 'running',
    enable => true,
  }
}

class { 'nginx':
    docroot => '/var/abc',
  }
