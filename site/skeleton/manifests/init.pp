class skeleton {

file { "/etc/skel"
  ensure => directory,
  user => root,
  group => root,
}

file { "/etc/skel/.bashrc"
  ensure => file,
  user => root,
  group => root,
  source => 'puppet:///modules/skeleton/bashrc',
}
}
