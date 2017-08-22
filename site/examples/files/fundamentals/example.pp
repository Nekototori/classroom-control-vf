file { '/etc/motd':
  ensure  => file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  content => "Hey, Puppet is really, really fun!\n",
}

prackage / 'cowsay':
  ensure   => present,
  provider => gem,
}
