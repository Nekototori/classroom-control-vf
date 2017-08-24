class nginx (
  $root = "not_defined"
  ){

  $service_name = 'nginx'

  case $facts['os']['family'] {
    'windows' : {
      $package_name = 'nginx-service'
      $file_owner = 'Administrator'
      $file_group = 'Administrators'
      $default_document_root = 'C:/ProgramData/nginx/html'
      $config_directory = 'C:/ProgramData/nginx'
      $server_block_directory = 'C:/ProgramData/nginx/conf.d'
      $logs_directory = 'C:/ProgramData/nginx/logs'
    }
    'debian','redhat' : {
      $package_name = 'nginx'
      $file_owner = 'root'
      $file_group = 'root'
      $default_document_root = '/var/www'
      $config_directory = '/etc/nginx'
      $server_block_directory = '/etc/nginx/conf.d'
      $logs_directory = '/var/log/nginx'
     }
     default : { fail("${facts['os']['family']} is not supported by this module: ${module_name}")}
  }

  $user_service_run_as = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody'
  }

  if $root != "not_defined" {
    $document_root = $root
  } else {
    $document_root = $default_document_root
  }

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
