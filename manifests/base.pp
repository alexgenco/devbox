if $username == undef { fail("Must set FACTER_username") }
if $userpass == undef { fail("Must set FACTER_userpass") }
$home = "/home/$username"

include user
include ssh
include git
include ruby
include tmux
include vim
include dotfiles
