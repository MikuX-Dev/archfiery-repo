#!/usr/bin/env bash
#
# Script name: pushit.sh
# Description: Script for pushing changes to dtos-core-repo to GitLab.
# GitLab: https://www.gitlab.com/dwt1/dtos-core-repo
# Contributors: Derek Taylor

# Set with the flags "-e", "-u","-o pipefail" cause the script to fail
# if certain things happen, which is a good thing.  Otherwise, we can
# get hidden bugs that are hard to discover.
set -euo pipefail

git status
git add -u && echo "Git add updated files in this directory."
git add * && echo "Git add all files in this directory."
git commit -m "Updating database." && echo "Commit Message: Updating database."
git push && echo "Git push completed."
