class profile::base (
  $message = 'This is my profile message',
) {
  notify { $message: }
  
  class { 'nginx':
    docroot => '/var/abc',
  }
}
