#!/bin/bash

printhelp () {
cat >&2 <<EOF
#=============================================================================#
# USAGE : newdoc.sh TYPE DIR TITLE                                            #
#                                                                             #
#   TYPE :                                                                    #
#     - page :                                                                #
#         Creates a blank page with a header in a given PATH.                 #
#     - post :                                                                #
#         Creates a blank post with a header in a given PATH.                 #
#                                                                             #
#   DIR :                                                                     #
#     Destination path of the blank .md file                                  #
#                                                                             #
#   TITLE :                                                                   #
#     Title of the page or post.                                              #
#=============================================================================#
EOF

exit 1;
}

clean(){ trap - EXIT; trap - ERR; }
trap printhelp ERR;
trap clean EXIT;

[ "$1" ] && pageorpost="$1" || printhelp;
[ "$2" ] && basedir="$(cd "$(dirname "$2")" && pwd -P)" || printhelp;
[ "$3" ] && title="$3" || printhelp;

set -eu;

nospacetitle="$(echo $title | sed 's/[[:space:]]\+/-/g')";
filename="$(date '+%Y-%m-%d')-$nospacetitle.md"

if [ $pageorpost = "post" ]; then

cat >"$basedir/$filename" <<EOF 
---
layout: post
title: "$title"
date: $(date '+%Y-%m-%d %H:%M:%S %z')
categories: 
---

EOF

elif [ $pageorpost = "page" ]; then

cat >"$basedir/$filename" <<EOF 
---
layout: page
title: "$title"
permalink: /$nospacetitle/
---

EOF

else printhelp;

fi;

exit 0;
