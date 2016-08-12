class vim {
  include dotfiles

  package { "vim": ensure => latest } ->

  exec { "install plugins":
    path => "/usr/bin",
    environment => "HOME=${home}",
    user => $username,
    command => "vim +PlugInstall +qall",
  }
}
