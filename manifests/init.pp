# == class: tcpd
#
# == Description
#
# Access will be granted when a (daemon,client) pair matches an entry in
# the /etc/hosts.allow file.
#
# Otherwise, access will be denied when a (daemon,client) pair matches an
# entry in the /etc/hosts.deny file.
#
# Otherwise, access will be granted.
#
# == Parameters
#
# == Authors
#
# Jon Mosco <jonny.mosco@gmail.com>
#
class tcpd (
  $default_allow = 'ALL: ALL',
  $default_deny  = undef,
) {

  file { 'hosts.allow':
    ensure  => file,
    path    => '/etc/hosts.allow',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tcpd/hosts.allow.erb'),
  }

  file { 'hosts.deny':
    ensure  => file,
    path    => '/etc/hosts.deny',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('tcpd/hosts.deny.erb'),
  }

}
