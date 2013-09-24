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
  $default_allow = undef,
  $default_deny  = undef,
  $allowed_hosts = undef,
  $denied_hosts  = undef,
) {

  if $default_allow == true {
    $default_allow = 'ALL: ALL'
  }
  if $default_deny == true {
    $default_deny = 'ALL: ALL'
  }

  validate_string($default_allow)
  validate_string($default_deny)

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
