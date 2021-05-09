#!/bin/bash -x

printhelp () {
cat >&2 <<EOF
#=============================================================================#
# USAGE : nohist DIR                                                          #
#                                                                             #
#   DIR :                                                                     #
#     Root directory of the git repository.                                   #
#=============================================================================#
EOF

exit 1;
}

mypath="$(pwd -P)";
clean(){ cd "$mypath"; trap - EXIT; trap - ERR; }
trap printhelp ERR;
trap clean EXIT;

[ "$1" ] && basedir="$(cd "$(dirname "$2")" && pwd -P)" || printhelp;

set -eu;

cd $basedir;
#repo="$(grep "https://github.com/" .git/config | cut -d= -f2)"
#rm -rf .git;
#git init
#git add .
#git commit -m 'Initial commit'
#git remote rm origin
#git remote add origin $repo
#git push --mirror --force

git checkout --orphan new-gh-pages
git config user.email "xullil@gmx.com"
git config user.name "Lillux XULLIL"
git add -A
git commit -m "Initial commit"
git branch -D gh-pages
git branch -m gh-pages
git push --mirror -f #origin gh-pages
git gc --aggressive --prune=all

exit 0;
