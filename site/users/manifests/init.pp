class users {
  user { 'fundamentals':
    ensure => present,
    'puppet8#labs', # Windows requires a plain text password
    groups => ['Users'], # Display in Windows Control Panel
    }
  }
