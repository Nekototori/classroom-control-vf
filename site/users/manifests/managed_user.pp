define users::managed_user (
  $user = $title,
  $home_dir = "/home/${user}",
  $managed_user_group = $title,
) {

  file { [$home_dir, "${home_dir}/.ssh"] :
    ensure => directory,
    owner => $user,
    group => $managed_user_group,
    mode => '0755'
  }
  user { $user :
    ensure => present,
  }
  group { $managed_user_group :
    ensure => present
  }
}
