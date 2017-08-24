class nginx{
  case $facts['os']['family'] {
    'redhat','debian' : {
      $package = 'nginx'
      $owner = 'root'
      $group = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir = '/var/log/nginx'
      $service = 'nginx'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner = 'Administrator'
      $group = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir = 'C:/ProgramData/nginx/logs'
    }
    default : {
      fail("Module ${module_name} is not supported on ${facts['os']['family']}")
    }
  }
  $user = $facts['os']['family'] ? {
    'redhat' => 'nginx',
    'debian' => 'www-data',
    'windows' => 'nobody',
  }

  File{
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  package{'nginx':
    ensure => present
  }
  file {'/var/www':
    ensure => directory,
  }
  file {'/var/www/index.html':
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }

  file {'/etc/nginx/nginx.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  file {'/etc/nginx/conf.d':
    ensure => directory,
  }
  file {'/etc/nginx/conf.d/default.conf':
    ensure => file,
    source => 'puppet:///modules/nginx/nginx.conf',
  }
  service{ 'nginx':
    ensure => 'running',
    enable => true,
  }
}
