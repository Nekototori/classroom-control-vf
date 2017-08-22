class nginx {

package { 'nginx': 
  ensure => installed, 
  name => $ngin
  }
  
service { 'nginx':
  ensure => 'running', 
  enable => 'true',
  
  }  
}
