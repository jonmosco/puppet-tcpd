# == class: tcpd
#
# == Description
#
# TCP Wrappers, tcpd
# Access control for internet services
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
# $default_allow
# - Set default policy to allow all hosts
#
# $default_deny
# - Set default policy to deny all hosts.  WARNING: This will lock everything
#   out of the server and should be used with care.
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

  if $default_allow {
    $allow = 'ALL: ALL'
  }
  if $default_deny {
    $deny = 'ALL: ALL'
  }

  validate_string($allow)
  validate_string($deny)

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
