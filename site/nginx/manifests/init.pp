class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode => '6044',
  }
  package { 'nginx':
    ensure => installed,
    }
  
  file { '/etc/sysconfig/nginx.conf'
  }
}
