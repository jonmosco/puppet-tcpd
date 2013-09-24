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
# The format of /etc/{hosts.allow,hosts.deny} should use the following format:
# daemon_list: client_list [ : shell_command ]
#
# == Parameters
#
# $default_policy
#
# Allow
# - Set default policy to allow all hosts
#
# Deny
# - Set default policy to deny all hosts.  WARNING: This will lock everything
#   out of the server and should be used with care.
#
# == Authors
#
# Jon Mosco <jonny.mosco@gmail.com>
#
class tcpd (
  $default_policy  = 'allow',
  $allowed_domains = undef,
  $allowed_hosts   = undef,
  $denied_domains  = undef,
  $denied_hosts    = undef,
  $daemon          = undef,
  $policy          = undef,
) {

  if $default_policy == 'allow' {
    $allow = 'ALL: ALL'
  }
  elsif $default_policy == 'deny' {
    $deny = 'ALL: ALL'
  }

  validate_re($default_policy, '^(allow|deny)$', "Valid values for
  \$default_policy are 'allow', or 'deny'. Received ${default_policy}")
  validate_string($allow)
  validate_string($deny)
  validate_string($allowed_domains)
  validate_string($allowed_hosts)
  validate_string($denied_domains)
  validate_string($denied_hosts)

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
