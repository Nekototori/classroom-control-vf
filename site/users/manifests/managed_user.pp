define users::managed_user (
  $managed_user_group = $title,
  ) {
  user { $title:
    groups => $manager_user_group,
    ensure => present,
    }
    
  file { ["/home/${title}", "/home/${title}/.ssh"]:
      ensure => directory,
      owner => $title,
      group => $managed_user_groupgroup,
      mode => '0755',
     }
     
     group { $managed_user_group:
      ensure => present,
      }
}
