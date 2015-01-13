class git {
  $gitconfig     = "${home}/.gitconfig"
  $gitcompletion = "${home}/.git-completion"

  package { "git":
    ensure => latest,
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
