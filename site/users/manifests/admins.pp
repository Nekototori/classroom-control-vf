class users::admins {
  users::managed_user { 'jose': }
  users::managed_user { 'alice':
    managed_user_group => 'admins'
  }
  users::managed_user { 'chen': }
}
