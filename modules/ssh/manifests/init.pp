class ssh {
  $sshd_config = "/etc/ssh/sshd_config"

  file { $sshd_config:
    owner => "root",
    group => "root",
    mode => 644,
    source => "puppet:///modules/ssh/sshd_config",
  } ->

  service { "ssh":
    ensure => running,
    subscribe => File[$sshd_config],
  }
}
