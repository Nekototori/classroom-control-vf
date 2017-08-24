class profile::base (
  $my_message_param = "default param message",
  ){
  notify { "Hello, my name is ${::hostname}": }
  $hiera_message = hiera('message','NOT FOUND')
  notify { "Hiera message is ${hiera_message}": }
  notify { "Hiera message is ${my_message_param}": }
}
#profile::base::my_message_param
