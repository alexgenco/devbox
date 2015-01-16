class user {
  user { $username:
    ensure => "present",
    password => $userpass,
    groups => ["sudo"],
    shell => "/bin/bash",
    home => $home,
    managehome => true,
  }
}
