class users:admin {
  users::managed_user { "Jose": }
  
  users::managed_user { "Alice": }
    managed_user_group => 'Admins',
  
  users::managed_user { "Chen": }

}
