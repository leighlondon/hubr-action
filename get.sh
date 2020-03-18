#!/usr/bin/env bash
die() { echo "$1" >&2; exit 1; }
hash curl 2>/dev/null || die "missing: curl"

org=${1:?missing org}
repo=${2:?missing repo}
asset=${3:?missing asset}
tag=${4:?missing tag}

data=$(curl --fail -s --show-error -S "https://api.github.com/repos/$org/$repo/releases/tags/$tag")
query="
    .assets[]
    | select(.name == \"$asset\")
    | .url
"
url=$(<<<"$data" jq -r "$query") || die "can't get the id"

curl --fail -s --show-error -S -L \
    -H 'Accept: application/octet-stream' \
    "$url" > "$asset" || die "cant fetch"

trap 'rm -f $asset' EXIT
unzip "$asset" || die "cant unzip"
