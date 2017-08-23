define users::managed_user (
    $managed_user_group = $title,
) {

  user { $title:
    groups => $managed_user_group,
  }  
    
  file { ["/home/${title}","/home/${title}/.ssh"]:
    ensure  => directory,
    owner   => '${title}',
    group   => $title,
    mode    => '0644',
    }
}
