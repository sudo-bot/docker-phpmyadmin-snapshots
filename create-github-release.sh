#!/bin/bash
##
# @license http://unlicense.org/UNLICENSE The UNLICENSE
# @author William Desportes <williamdes@wdes.fr>
##

set -eu

function generate_post_data {
  cat <<EOF
{
  "name": "${NAME}",
  "tag_name": "${TAG_NAME}",
  "body": "${BODY}",
  "draft": false,
  "make_latest": "${MAKE_LATEST}",
  "prerelease": ${PRE_RELEASE}
}
EOF
}

curl \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github+json" \
    --data "$(generate_post_data)" "https://api.github.com/repos/${REPO_OWNER}/${REPO_NAME}/releases"
