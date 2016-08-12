class dotfiles {
  require git
  require ruby

  exec { "clone dotfiles":
    path => "/usr/bin",
    user => $username,
    cwd => $home,
    command => "git clone https://github.com/alexgenco/dotfiles .dotfiles",
    creates => "${home}/.dotfiles",
    require => Package["git"],
  } ->

  exec { "install dotfiles":
    path => "/usr/bin",
    user => $username,
    cwd => "${home}/.dotfiles",
    command => "bundle exec rake symlink",
  }
}
