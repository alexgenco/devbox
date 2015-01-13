class ssh {
  $sshd_config = "/etc/ssh/sshd_config"

  file { $sshd_config:
    owner => "root",
    group => "root",
    mode => 644,
    source => "puppet:///modules/ssh/sshd_config",
  } ->

  exec { "restart ssh":
    path => ["/usr/bin", "/usr/sbin"],
    user => "root",
    command => "service ssh restart",
  }
}
