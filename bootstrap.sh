#!/usr/bin/env sh

set -e

echo "Initial apt-get update..."
apt-get update >/dev/null

which lsb_release || apt-get install -y lsb-release

DISTRIB_CODENAME=$(lsb_release -c -s)
REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb"

echo
echo "Installing wget..."

apt-get install -y wget >/dev/null

echo
echo "Configuring PuppetLabs repo..."

repo_deb_path=$(mktemp)
wget --output-document="${repo_deb_path}" "${REPO_DEB_URL}" 2>/dev/null
dpkg -i "${repo_deb_path}" >/dev/null
apt-get update >/dev/null

echo
echo "Installing Puppet..."

DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install puppet >/dev/null

echo
echo "Running puppet noop..."

if puppet apply --modulepath=./modules --config=./puppet.conf ./manifests/base.pp --noop; then
  echo
  read -p "Apply changes? (yes/no): " resp

  if [ "$resp" = "yes" ]; then
    puppet apply --modulepath=./modules --config=./puppet.conf ./manifests/base.pp
  else
    echo
    echo "Not applying changes."
    exit 1
  fi
else
  sts=$?
  echo
  echo "Puppet noop failed with status $sts"
  exit $sts
fi
