define users::managed_user (
  $managed_user_group = $title,
) {

  user { $title:
    groups  => $managed_user_group,
    ensure => present,
  }
  
  file { ["/home/${title}", "/home/${title}/.ssh"]:
    ensure => directory,
    owner  => $title,
    group  => $managed_user_group,
    mode   => '0755',
  }
  
  group { $managed_user_group:
    ensure => present,
  }
  
}
