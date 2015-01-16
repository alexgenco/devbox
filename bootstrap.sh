#!/bin/sh
set -e

echo "Initial apt-get update..."
apt-get update >/dev/null

echo "Installing wget..."
apt-get install -y wget >/dev/null

echo "Configuring PuppetLabs repo..."
which lsb_release || apt-get install -y lsb-release
DISTRIB_CODENAME=$(lsb_release -c -s)
REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb"
REPO_DEB_PATH=$(mktemp)
wget --output-document="${REPO_DEB_PATH}" "${REPO_DEB_URL}" 2>/dev/null
dpkg -i "${REPO_DEB_PATH}" >/dev/null
apt-get update >/dev/null

echo "Installing Puppet..."
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install puppet >/dev/null

read -p "User: " FACTER_username
export FACTER_username
export FACTER_userpass=$(mkpasswd -m sha-512)

echo "Running puppet noop..."
APPLY_CMD="puppet apply --verbose --modulepath=./modules --config=./puppet.conf ./manifests/base.pp"

if $APPLY_CMD --noop; then
  read -p "
Apply changes? (yes/no): " resp

  if [ "$resp" = "yes" ]; then
    $APPLY_CMD
  else
    echo "Not applying changes."
    exit 1
  fi
else
  sts=$?
  echo "Puppet noop failed with status $sts"
  exit $sts
fi
