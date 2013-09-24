# == class: tcpd
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
