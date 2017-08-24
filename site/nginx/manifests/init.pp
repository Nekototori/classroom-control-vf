class nginx (
  
      $package_name =           $nginx::params::package_name ,
      $file_owner =             $nginx::params::file_owner ,
      $file_group =             $nginx::params::file_group ,
      $document_root =          $nginx::params::document_root ,
      $config_directory =       $nginx::params::config_directory ,
      $server_block_directory = $nginx::params::server_block_directory ,
      $logs_directory =         $nginx::params::logs_directory ,
      $user_service_run_as =    $nginx::params::user_service_run_as ,
  ) inherits nginx::params {

  File {
    owner  => $file_owner,
    group  => $file_group,
    mode => '0644'
  }

  package { $package_name:
    ensure => present,
  }

  file { $document_root:
    ensure => directory,
  }
  
  file { "${document_root}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }
  
  file { "${config_directory}/nginx.conf":
    ensure => file,
    require => Package['nginx'],
    notify => Service['nginx'],
    content => epp('nginx/nginx.conf.epp', {
                    user_service_run_as => $user_service_run_as,
		    config_directory => $config_directory,
		    logs_directory => $logs_directory,
		    server_block_directory => $server_block_directory
		    })
  }
  
  file { $server_block_directory :
    ensure => directory,
  }
  
  file { "${server_block_directory}/default.conf":
    ensure => file,
    require => Package['nginx'],
    notify => Service['nginx'],
    content => epp('nginx/default.conf.epp', { document_root => $document_root })
  }
  
  service { $service_name:
    ensure => 'running',
    enable => true,
  }
}
