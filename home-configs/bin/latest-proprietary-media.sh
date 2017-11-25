#!/bin/sh

# Discourage Ubuntu users from using this script, since they can (and should) install oxideqt-codecs-extra directly
if [ -r /etc/os-release ] && grep -qx 'ID=ubuntu' /etc/os-release; then
  echo "You should not use this script on Ubuntu, install oxideqt-codecs-extra via apt instead." >&2
  read -p "Do you wish to continue anyway? [y/N]: " YN
  case "$YN" in
    [Yy]*) : ;;
    [Nn]*) echo "Exiting." ; exit ;;
        *) echo 'Answer not recognised, assuming "No". Exiting.'; exit ;;
  esac
fi

# Make sure the user is not runing as superuser
if [ "$UID" = "0" ]; then
  echo 'Do not run this script as root or via sudo. Run it as your normal user.' >&2
  exit 1
fi

available () {
  command -v $1 >/dev/null 2>&1
}

# Make sure we have wget or curl
if available wget; then
  SILENT_DL="wget -qO-"
  LOUD_DL="wget"
elif available curl; then
  SILENT_DL="curl -sL"
  LOUD_DL="curl -O"
else
  echo "Install Wget or cURL" >&2
  exit 1
fi

# Set temp dir
TMP=${TMP:-/tmp}

# Set staging dir
STAGINGDIR=$TMP/oxideqt-codecs-extra-staging

# Setup Arch
case $(uname -m) in
  x86_64) ARCH=x86_64; DEB_ARCH=amd64 ;;
    i?86) ARCH=i386; DEB_ARCH=i386 ;;
esac

# Work out the VERSION
UBUNTU_PACKAGE=$(${SILENT_DL} http://security.ubuntu.com/ubuntu/pool/main/o/oxide-qt/ | sed -rn "s/.*(oxideqt-codecs-extra_([0-9]+\.){2}[0-9]+-[0-9]ubuntu[0-9]\.([0-9]{2}\.){2}[0-9\.]*_$DEB_ARCH.deb).*/\1/p" | sort | tail -n 1)
VERSION=$(echo "${UBUNTU_PACKAGE}" | sed -rn "s/.*_(([0-9]+\.){2}[0-9]+)-.*/\1/p")

# Error out if $VERISON is unset, e.g. because previous command failed
if [ -z "$VERSION" ]; then
  echo "Could not work out the latest version; exiting" >&2
  exit 1
fi

# Don't start repackaging if the same version is already installed
if [ -r "$HOME/.local/lib/vivaldi/oxideqt-codecs-extra-version.txt" ]; then
  . "$HOME/.local/lib/vivaldi/oxideqt-codecs-extra-version.txt"
  if [ "$INSTALLED_VERSION" = "$VERSION" ]; then
    echo "The latest oxideqt-codecs-extra ($VERSION) is already installed"
    exit 0
  fi
fi

# Now we could screw things up so exit on first error
set -e

# If the staging directory is already present from the past, clear it down
# and re-create it.
if [ -d "$STAGINGDIR" ]; then
  rm -fr "$STAGINGDIR"
fi

mkdir "$STAGINGDIR"
cd "$STAGINGDIR"

# Now get the deb package
$LOUD_DL "http://security.ubuntu.com/ubuntu/pool/main/o/oxide-qt/${UBUNTU_PACKAGE}"

# Extract the contents of the oxideqt-codecs-extra package
if available bsdtar; then
  DEB_EXTRACT_COMMAND='bsdtar xOf'
elif available ar; then
  DEB_EXTRACT_COMMAND='ar p'
else
  echo 'You must install BSD tar or GNU binutils to use this script.' >&2
  exit 1
fi
$DEB_EXTRACT_COMMAND ${UBUNTU_PACKAGE} data.tar.xz | tar xJf - ./usr/lib/$ARCH-linux-gnu/oxide-qt/libffmpeg.so --strip 5
echo "INSTALLED_VERSION=$VERSION" > oxideqt-codecs-extra-version.txt

# Install the files
install -Dm644 libffmpeg.so "$HOME/.local/lib/vivaldi/libffmpeg.so"
install -Dm644 oxideqt-codecs-extra-version.txt "$HOME/.local/lib/vivaldi/oxideqt-codecs-extra-version.txt"

# Tell the user we are done
cat <<EOF
The following files were installed onto your system:
  $HOME/.local/lib/vivaldi/libffmpeg.so
  $HOME/.local/lib/vivaldi/oxideqt-codecs-extra-version.txt
Restart Vivaldi and test H.264/MP4 support via this page:
  http://www.quirksmode.org/html5/tests/video.html
EOF
