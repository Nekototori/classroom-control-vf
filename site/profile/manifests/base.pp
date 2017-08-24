class profile::base (
  $message = 'This is my profile message',
) {
  notify { $message: }
  
  
  include ::redis
  include epel
  limits::fragment { "*/soft/nofile":
   value => "1024";
 "*/hard/nofile":
   value => "8192";
  }
}
