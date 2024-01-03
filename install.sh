#!/bin/sh

set -e

_green() {
  printf '\033[1;31;32m%b\033[0m\n' "$1"
}

_red() {
  printf '\033[1;31;40m%b\033[0m\n' "$1"
}

_exists() {
  cmd="$1"
  if [ -z "$cmd" ]; then
    _red "Usage: _exists cmd"
    return 1
  fi

  if eval type type >/dev/null 2>&1; then
    eval type "$cmd" >/dev/null 2>&1
  elif command >/dev/null 2>&1; then
    command -v "$cmd" >/dev/null 2>&1
  else
    which "$cmd" >/dev/null 2>&1
  fi
  return "$?"
}

main() {
  if [ "$(uname -s)" != "Darwin" ]; then
    _red "Unsupported operating system, Darwin?";
    return 1;
  fi

  if [ ! -d ".git" ]; then 
    _red "Dir .git not find, Please git init first?";
    return 1;
  fi

  if [ -f .git/hooks/commit-msg ]; then
    mv .git/hooks/commit-msg .git/hooks/commit-msg.bak;
  fi
  curl https://raw.githubusercontent.com/lixw1994/git-hook/master/git-commit-msg.sh -o .git/hooks/commit-msg
  chmod +x .git/hooks/commit-msg 
  _green "commit-msg hook Install Success!"

#   if [ -f .git/hooks/pre-commit ]; then
#     mv .git/hooks/pre-commit .git/hooks/pre-commit.bak;
#   fi
#   curl https://raw.githubusercontent.com/lixw1994/git-hook/master/golang-pre-commit.sh -o .git/hooks/pre-commit
#   chmod +x .git/hooks/pre-commit
#   _green "pre-commit hook Install Success!"
}

main "$@"
