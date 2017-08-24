class site::snmpserver {
include snmp
class { 'snmp::server':
ro_community => 'notpublic',
ro_network => '10.20.30.40/32',
contact => 'root@yourdomain.org',
location => 'Phoenix, AZ',
}
snmp::snmpv3_user { 'myuser':
authpass => '1234auth',
privpass => '5678priv',
}


stahnma/epel
