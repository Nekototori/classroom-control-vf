class nginx::params {
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
}
