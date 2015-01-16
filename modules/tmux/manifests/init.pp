class tmux {
  $tmuxconf = "${home}/.tmux.conf"

  package { "tmux": ensure => latest } ->

  file { $tmuxconf:
    ensure => present,
    owner => $username,
    group => $username,
    source => "puppet:///modules/tmux/tmux.conf",
  }
}
