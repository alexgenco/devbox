class ruby {
  include git
  include apt

  $rbenvdir = "${home}/.rbenv"
  $repobase = "https://github.com/sstephenson"

  exec { "install ruby deps":
    path => ["/bin", "/usr/bin", "/sbin", "/usr/sbin", "/usr/local/sbin"],
    command => "apt-get -y install build-essential libffi-dev libssl-dev zlib1g-dev libreadline-dev",
    require => Exec["apt-get update"],
    refreshonly => true,
  } ->

  exec { "install rbenv":
    path => "/usr/bin",
    user => "alex",
    command => "git clone ${repobase}/rbenv.git ${rbenvdir}",
    creates => $rbenvdir,
    require => Package["git"],
  } ->

  exec { "install ruby-build":
    path => "/usr/bin",
    user => "alex",
    command => "git clone ${repobase}/ruby-build.git ${rbenvdir}/plugins/ruby-build",
    creates => "${rbenvdir}/plugins/ruby-build",
    require => Package["git"],
  } ->

  exec { "install ruby":
    path => ["/bin", "/usr/bin", "${rbenvdir}/plugins/ruby-build/bin", "${rbenvdir}/libexec"],
    environment => "RBENV_ROOT=${rbenvdir}",
    user => "alex",
    command => "rbenv-install 2.2.0",
    timeout => 0,
    creates => "${rbenvdir}/versions/2.2.0/bin/ruby",
  }
}
