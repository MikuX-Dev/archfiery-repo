#!/usr/bin/env bash
# shellcheck disable=SC2035

# Script name: update-db.sh
# Description: Script for rebuilding the database for archfiery.
# Contributors: MikuX-Dev

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64
if [ -f "archfiery_repo*" ]; then
  rm archfiery_repo*
fi

# rm archfiery_repo*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
repo-add -s -n -R archfiery_repo.db.tar.gz *.pkg.tar.zst
repo-add -s -n -R archfiery_repo.db.tar.gz *.pkg.tar.gz
repo-add -s -n -R archfiery_repo.db.tar.gz *.pkg.tar.xz
repo-add -s -n -R archfiery_repo.db.tar.gz *.tar.xz

# Removing the symlinks.
echo "###################################"
echo "       Removing the symlinks.      "
echo "###################################"

rm archfiery_repo.db
rm archfiery_repo.db.sig
rm archfiery_repo.files
rm archfiery_repo.files.sig

# Renaming the tar.gz files without the extension.
echo "################################################"
echo "Renaming the tar.gz files without the extension."
echo "################################################"

mv archfiery_repo.db.tar.gz archfiery_repo.db
mv archfiery_repo.db.tar.gz.sig archfiery_repo.db.sig
mv archfiery_repo.files.tar.gz archfiery_repo.files
mv archfiery_repo.files.tar.gz.sig archfiery_repo.files.sig

echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"
