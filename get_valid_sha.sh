#!/bin/bash

set -uo pipefail
set +e # handle errors in caller

repository="$1"
token="$2"
ref="$3"

# branch?
res="$(curl -s \
            -X GET \
            -H "Authorization: token $token" \
            "https://api.github.com/repos/$repository/git/ref/heads/$ref")"
sha="$(echo "$res" | tr -d '[:cntrl:]' | jq -r '.object.sha')"

# tag?
if [[ -z "$sha" || "$sha" == 'null' ]]; then
  res="$(curl -s \
              -X GET \
              -H "Authorization: token $token" \
              "https://api.github.com/repos/$repository/git/ref/tags/$ref")"
  sha="$(echo "$res" | tr -d '[:cntrl:]' | jq -r '.object.sha')"
fi

# valid SHA?
if [[ -z "$sha" || "$sha" == 'null' ]]; then
  res="$(curl -s \
              -X GET \
              -H "Authorization: token $token" \
              "https://api.github.com/repos/$repository/git/commits/$ref")"
  sha="$(echo "$res" | tr -d '[:cntrl:]' | jq -r '.sha')"
fi

if [[ -z "$sha" || "$sha" == 'null' ]]; then
  exit 0 # errors are handled by the return value at the caller
fi

echo "$sha"
