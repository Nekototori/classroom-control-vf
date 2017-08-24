class nginx::params {

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
           owner  => $owner, 
           group => $group, 
           mode => '0644', 
               } 

}
$port = '80'
}
