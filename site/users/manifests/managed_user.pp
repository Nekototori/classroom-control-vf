define users::managed_user (
$managed_user_group = $title,
) {

user { $title:
  ensure => present,
}

file { ["/home/${title}", "/home/${title}/.ssh"] :
  ensure => directory,
  owner => $title,
  group => $managed_user_group,
  mode  => '775',
}

group { $managed_user_group:
  ensure => present,
{

}
