class ruby {
  require git

  $rbenvdir = "${home}/.rbenv"
  $repobase = "https://github.com/sstephenson"

  package { "build-essential": ensure => latest } ->
  package { "libreadline-dev": ensure => latest } ->
  package { "libffi-dev":      ensure => latest } ->
  package { "libssl-dev":      ensure => latest } ->
  package { "zlib1g-dev":      ensure => latest } ->

  exec { "install rbenv":
    path => "/usr/bin",
    user => $username,
    cwd => $home,
    command => "git clone ${repobase}/rbenv.git ${rbenvdir}",
    creates => $rbenvdir,
  } ->

  exec { "install ruby-build":
    path => "/usr/bin",
    user => $username,
    cwd => $home,
    command => "git clone ${repobase}/ruby-build.git ${rbenvdir}/plugins/ruby-build",
    creates => "${rbenvdir}/plugins/ruby-build",
  } ->

  exec { "install bundler":
    path => "/usr/bin",
    user => "root",
    cwd => $home,
    command => "gem install bundler",
  }
}
