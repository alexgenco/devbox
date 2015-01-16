class vim {
  include git

  $vimrc     = "${home}/.vimrc"
  $viminfo   = "${home}/.viminfo"
  $vimdir    = "${home}/.vim"
  $bundledir = "${vimdir}/bundle"

  package { "vim": ensure => latest } ->

  file { $vimrc:
    ensure => present,
    owner => $username,
    group => $username,
    source => "puppet:///modules/vim/vimrc",
  } ->

  file { $viminfo:
    ensure => present,
    owner => $username,
    group => $username,
  } ->

  file { $vimdir:
    ensure => directory,
    owner => $username,
    group => $username,
  } ->

  file { $bundledir:
    ensure => directory,
    owner => $username,
    group => $username,
  } ->

  exec { "install vundle":
    path => "/usr/bin",
    user => $username,
    cwd => $home,
    command => "git clone https://github.com/gmarik/Vundle.vim ${bundledir}/Vundle.vim",
    creates => "${bundledir}/Vundle.vim",
    require => Package["git"],
  } ->

  exec { "install plugins":
    path => "/usr/bin",
    environment => "HOME=${home}",
    user => $username,
    command => "vim +PluginInstall +qall",
  }
}
