class profile::base {
  notify { "Hello, my name is ${::hostname}": }
  $hiera_message = hiera('message','NOT FOUND')
  notify { "Hiera message is ${hiera_message}": }
}
