class bash {
  $bash_profile = "${home}/.bash_profile"
  $bash_aliases = "${home}/.bash_aliases"

  file { $bash_profile:
    ensure => present,
    owner => $username,
    group => $username,
    source => "puppet:///modules/bash/bash_profile",
  } ->

  file { $bash_aliases:
    ensure => present,
    owner => $username,
    group => $username,
    source => "puppet:///modules/bash/bash_aliases",
  }
}
