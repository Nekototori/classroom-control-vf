class profile::base {
  notify { "Hello, here is a message from hiera!": },
  notify { hiera('message'): },
}
