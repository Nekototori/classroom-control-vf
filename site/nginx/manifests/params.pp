class nginx::params {

case $facts['os']['family'] {

'RedHat','debian' : {
$package = 'nginx'
$owner = 'root'
$group = 'root'
#$docroot = '/var/www'
$confdir = '/etc/nginx'
$logdir = '/var/log/nginx'
$run_pid_path = '/var/run'
# this will be used if we don't pass in a value
$default_docroot = '/var/www'
}

'windows' : {
$package = 'nginx-service'
$owner = 'Administrator'
$group = 'Administrators'
#$docroot = 'C:/ProgramData/nginx/html'
$confdir = 'C:/ProgramData/nginx'
$logdir = 'C:/ProgramData/nginx/logs'
$run_pid_path = 'C:/ProgramData/nginx/run'
# this will be used if we don't pass in a value
$default_docroot = 'C:/ProgramData/nginx/html'
}

default : {
  fail("Module ${module_name} is not supported on ${facts['os']['family']}")
}

}

#user the service will run as. Used in the nginx.conf.epp template
$user = $facts['os']['family'] ? {
'RedHat' => 'nginx',
'debian' => 'www-data',
'windows' => 'nobody',
} 

# if $root isn't set, then fall back to the platform default
$docroot = $root ? {
undef => $default_docroot,
default => $root,
}

}
