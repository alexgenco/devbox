class vim {
  include apt
  include git

  $vimrc     = "${home}/.vimrc"
  $viminfo   = "${home}/.viminfo"
  $vimdir    = "${home}/.vim"
  $bundledir = "${vimdir}/bundle"

  package { "vim":
    ensure => latest,
    require => Exec["apt-get update"],
  } ->

  file { $vimrc:
    ensure => present,
    owner => "alex",
    group => "alex",
    source => "puppet:///modules/vim/vimrc",
  } ->

  file { $viminfo:
    ensure => present,
    owner => "alex",
    group => "alex",
  } ->

  file { $vimdir:
    ensure => directory,
    owner => "alex",
    group => "alex",
  } ->

  file { $bundledir:
    ensure => directory,
    owner => "alex",
    group => "alex",
  } ->

  exec { "install vundle":
    path => "/usr/bin",
    user => "alex",
    command => "git clone https://github.com/gmarik/Vundle.vim ${bundledir}/Vundle.vim",
    creates => "${bundledir}/Vundle.vim",
    require => Package["git"],
  } ->

  exec { "install plugins":
    path => "/usr/bin",
    environment => "HOME=${home}",
    user => "alex",
    command => "vim +PluginInstall +qall",
  }
}
