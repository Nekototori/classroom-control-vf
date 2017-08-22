class skeleton {
  file{ '/etc/skel':
    ensure => directory,
  }
  files { '/etc/skel/.bashrc':
    ensure => file,
    owner => 'root',
    group => 'root',
    source => 'puppet:///modules/skeleton/bashrc',
  }
}
