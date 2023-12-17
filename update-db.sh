#!/usr/bin/env bash

# Script name: update-db.sh
# Description: Script for rebuilding the database for archfiery.
# Contributors: MikuX-Dev

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

x86_pkgbuild=$(find ../archfiery-pkgbuild/x86_64 -type f -name "*.pkg.tar.zst*")

for x in ${x86_pkgbuild}; do
  mv "${x}" x86_64/
  echo "Moving ${x}"
done

echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64
cd x86_64
rm -f archfiery*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
repo-add -s -n -R archfiery.db.tar.gz *.pkg.tar.zst

# Removing the symlinks because GitLab can't handle them.
rm archfiery.db
rm archfiery.db.sig
rm archfiery.files
rm archfiery.files.sig

# Renaming the tar.gz files without the extension.
mv archfiery.db.tar.gz archfiery.db
mv archfiery.db.tar.gz.sig archfiery-db.sig
mv archfiery.files.tar.gz archfiery.files
mv archfiery.files.tar.gz.sig archfiery.files.sig

echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"
