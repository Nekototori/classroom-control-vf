class profile::base {
  notify { hiera('message', 'default message'): }
}
