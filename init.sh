#!/bin/bash

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
PARENT="$(cd $CWD/.. >/dev/null 2>&1 && pwd)"

DEFAULT_PROJECT_ROOT="/home/$(whoami)/dev/momentshare"

REPO_ROOT="git@github.com:momentshare"

usage() {
  echo "usage: ./init.sh ~/dev/momentshare"
}

PROJECT_ROOT=$1
if [ -z "$PROJECT_ROOT" ]; then
  PROJECT_ROOT=$DEFAULT_PROJECT_ROOT
  echo "No install path was passed in, using default $PROJECT_ROOT"
  usage
fi

echo "Using $PROJECT_ROOT"
if [ -d "$PROJECT_ROOT" ]; then
  echo "Path $PROJECT_ROOT already exists, specify a different one"
  usage
  exit 1
fi

# $1 -> Display name
# $2 -> Project
clone() {
  echo "Cloning $1 repo"
  git clone "$REPO_ROOT/$2" "$PROJECT_ROOT/$2" >/dev/null
  ret=$?
  if [ ! $ret -eq 0 ]; then
    echo "Failed to download project $1 from $REPO_ROOT/$2"
    exit 1
  fi
  echo
}

echo "Cloning all repos"
echo

clone "Development" "development"
clone "Website" "website"
clone "API Server" "backend"
clone "Mobile App" "momentshare"

echo "All done!"
