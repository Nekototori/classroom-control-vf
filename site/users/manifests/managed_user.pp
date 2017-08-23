define users::managed_user (
  $user = $title,
  $home_dir,
  $group,
) {

  file { $home_dir :
    ensure => directory,
    owner => $user,
    group => $group,
    mode => '0755'
  }
  user { $user :
    ensure => present,
    groups => [$group]
  }
}
