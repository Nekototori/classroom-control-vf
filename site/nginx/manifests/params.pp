class nginx::params (
  $root = undef
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

  $document_root = $root ? {
    undef => $default_document_root,
    default => $root,
  }

}
