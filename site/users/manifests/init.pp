class users {  
  user { 'fundamentals':
    ensure => present,
    groups => ['Users'], 
    }
