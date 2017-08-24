class nginx (
  $root = undef,
) {
  
  
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
