class tmux {
  include apt

  $tmuxconf = "${home}/.tmux.conf"

  package { "tmux":
    ensure => latest,
    require => Exec["apt-get update"],
  } ->

  file { $tmuxconf:
    ensure => present,
    owner => "alex",
    group => "alex",
    source => "puppet:///modules/tmux/tmux.conf",
  }
}
