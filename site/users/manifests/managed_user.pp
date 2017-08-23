define users::managed_user (
  $user = $title,
  $home_dir = "/home/${user}",
  $group = $title,
) {

  file { [$home_dir, "${home_dir}/.ssh"] :
    ensure => directory,
    owner => $user,
    group => $group,
    mode => '0755'
  }
  user { $user :
    ensure => present,
  }
  group { $group :
    ensure => present
  }
}
