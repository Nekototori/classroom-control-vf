define users::managed_user (
  $managed_user_group = $title,
) {
  user { $title:
    ensure => present,
    group => $managed_user_group,
  }
  
  file { "/home/${title}":
    ensure => directory,
    owner => $title,
    group => $title,
    mode => '0775',
  }
  
  group { $managed_user_group:
    ensure => present,
  }
    
}
