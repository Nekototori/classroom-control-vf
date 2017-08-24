class nginx {
  case $facts['os']['family'] {
    'RedHat' : {
      $service_user = 'nginx'
      $config_dir = '/etc/nginx'
      $log_dir = '/var/log/nginx'
      $docroot = '/var/www'
      $file_owner = 'root'
      $file_group = 'root'
      $package = 'nginx'
    }
    'debian' : {
      $service_user = 'www-data'
      $config_dir = '/etc/nginx'
      $log_dir = '/var/log/nginx'
      $docroot = '/var/www'
      $file_owner = 'root'
      $file_group = 'root'
      $package = 'nginx'
    }
    'windows' : {
      $service_user = 'nobody'
      $config_dir = 'C:/ProgramData/nginx'
      $log_dir = 'C:/ProgramData/nginx/logs'
      $docroot = 'C:/ProgramData/nginx/html'
      $file_owner = 'Administrator'
      $file_group = 'Administrators'
      $package = 'nginx-service'
    }
    default : {
      fail( "The os family ${facts['os']['family']} is not supported.")
   }
 }
  
  
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
  
#  file { "${config_dir}/nginx.conf":
#    ensure => file,
#    content => epp('nginx/nginx.conf.epp',
#      {
#        user => $service_user,
#        config_dir => $config_dir,
#        log_dir => $log_dir,
#        }),
#    notify => Service['nginx'],
#  }
  
#  file { "${config_dir}/conf.d/default.conf":
#    ensure => file,
#    content => epp('nginx/default.conf.epp'),
#    notify => Service['nginx'],
#  }
  
  service { 'nginx':
    ensure => 'running',
    enable => true,
  }
}
