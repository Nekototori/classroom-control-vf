class users::admins {

users::managed_user { 'jose': }

users::managed_user { 'alice':
  groups => 'admins',
}

users::managed_user { 'chen':
  groups => 'admins',
}

group { 'admins':
  ensure => present,
}

}
