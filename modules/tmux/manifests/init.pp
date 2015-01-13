class tmux {
  $tmuxconf = "${home}/.tmux.conf"

  package { "tmux": ensure => latest } ->

  file { $tmuxconf:
    ensure => present,
    owner => "alex",
    group => "alex",
    source => "puppet:///modules/tmux/tmux.conf",
  }
}
