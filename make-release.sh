#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Author: William Desportes <williamdes@wdes.fr>

ENV=""
TAG_NAME=""
PUSH_TAG=0
SHOW_HELP=0
OFFLINE=0
VERSION_SEPARATOR='-'

# Source: https://stackoverflow.com/a/46793269/5155484 and https://stackoverflow.com/a/28466267/5155484
optspec="hpo-:e:n:"
while getopts "$optspec" OPTCHAR; do

    if [ "$OPTCHAR" = "-" ]; then   # long option: reformulate OPT and OPTARG
        OPTCHAR="${OPTARG%%=*}"       # extract long option name
        OPTARG="${OPTARG#$OPT}"   # extract long option argument (may be empty)
        OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
    fi
    OPTARG=${OPTARG#*=}

    # echo "OPTARG:  ${OPTARG[*]}"
    # echo "OPTIND:  ${OPTIND[*]}"
    # echo "OPTCHAR:  ${OPTCHAR}"
    case "${OPTCHAR}" in
        h|help)
            SHOW_HELP=1
            ;;
        o|offline)
            OFFLINE=1
            ;;
        p|push-tag)
            PUSH_TAG=1
            ;;
        n|tag-name)
            TAG_NAME="${OPTARG}"
            ;;
        e|env)
            ENV="${OPTARG}"
            ;;
        *)
            if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
                echo "Non-option argument: '-${OPTARG}'" >&2
            fi
            ;;
    esac
done

shift $((OPTIND-1)) # remove parsed options and args from $@ list

if [ ${SHOW_HELP} -gt 0 ]; then
    echo 'Usage:'
    echo './make-release.sh --env=5.2 -p'
    echo './make-release.sh --env=5.3 -p'
    echo 'POSIX options:		long options:'
    echo '  -h                      --help          To have some help'
    echo '  -e                      --env=          To specify the env (5.2/5.3)'
    echo '  -n                      --tag-name=     To specify the tag name'
    echo '  -p                      --push-tag      To push the tag'
    echo '  -o                      --offline       Do not fetch tags'
    exit 0;
fi

if [ -z $ENV ]; then
    echo "please enter a --env"
    exit 1
fi

if [ ${OFFLINE} -eq 0 ]; then
    echo "Fetching latest tags..."
    git fetch --prune origin "+refs/tags/*:refs/tags/*"
fi

echo "Get last release"
TODAY_TAG="$ENV/$(date +'%Y-%m-%d')"
# Last tag at the end sorted by the format of the tag
DAY_TAGS=$(git tag -l HEAD "$TODAY_TAG*" | sort -t / -k 2,2 -n)

# No tag name defined so use the latest tag
if [ -z "${TAG_NAME}" ]; then
        # The tag name is not defined
    LAST_RELEASE=$(echo -e "${DAY_TAGS}" | tail -n1)
else
    # Tag name defined so use the last tag before last one (pick two, use the first one)
    LAST_RELEASE=$(echo -e "${DAY_TAGS}" | grep -v -F "${TAG_NAME}" | tail -n1)
fi

if [ -z "$LAST_RELEASE" ]; then
    echo "None today, creating first one"
    LAST_RELEASE=$(echo "$TODAY_TAG-0");# will be +1 below
    # Last found release for ENV
    # No tag name defined so use the latest tag
    # Last tag at the end sorted by the format of the tag
    TWO_LAST_TAGS=$(git tag -l HEAD "$ENV/*" | sort -t / -k 2,2 -n | tail -n2)
    if [ -z "${TAG_NAME}" ]; then
        # The tag name is not defined
        PREVIOUS_RELEASE=$(echo -e "${TWO_LAST_TAGS}" | tail -n1)
    else
        # If the tag name is already defined then strip it off from the list and then use what will be the last tag
        PREVIOUS_RELEASE=$(echo -e "${TWO_LAST_TAGS}" | grep -v -F "${TAG_NAME}" | tail -n1)
    fi
    echo "Found previous release: $PREVIOUS_RELEASE"
else
    PREVIOUS_RELEASE="$LAST_RELEASE"
    echo "Found previous release: $PREVIOUS_RELEASE"
fi

echo "Version bump..."
if [ -z "${TAG_NAME}" ]; then
    # Cut on last - and bump last number
    VERSION_NAME=$(echo "${LAST_RELEASE}" | awk -F"${VERSION_SEPARATOR}" '{print substr($0, 0, length($0) - length($NF)) $NF + 1 }')
else
    VERSION_NAME="$TAG_NAME"
fi

echo "New version: $VERSION_NAME"
if [ -z "${TAG_NAME}" ]; then
    echo "TAG_NAME=${TAG_NAME}" >> $GITHUB_OUTPUT
    git tag --sign --message="release: $VERSION_NAME
user: $USER" $VERSION_NAME
    if [ ${PUSH_TAG} -eq 1 ]; then
        git push origin $VERSION_NAME
    fi
else
    echo "Using tag: ${TAG_NAME}"
fi

TAG_WORKS=$?

exit $TAG_WORKS
