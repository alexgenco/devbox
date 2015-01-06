class git {
  include apt

  $gitconfig     = "${home}/.gitconfig"
  $gitcompletion = "${home}/.git-completion"

  package { "git":
    ensure => latest,
    require => Exec["apt-get update"],
  }

  file { $gitconfig:
    ensure => present,
    owner => "alex",
    group => "alex",
    source => "puppet:///modules/git/gitconfig",
  }

  file { $gitcompletion:
    ensure => present,
    owner => "alex",
    group => "alex",
    source => "puppet:///modules/git/git-completion",
  }
}
