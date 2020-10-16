#!/usr/bin/env bash
die() { echo "::error file=entrypoint.sh:: $1" >&2; exit "${2:-1}"; }
hash hubr 2>/dev/null || die "missing hubr"
export HUBR_DEFAULT_ORG=""

# github repo name needs to be provided, e.g. "org/repo"
repo=${GITHUB_REPOSITORY:?missing repository from environment}
# hubr will read the version from the "VERSION" file by default.
file=${INPUT_FROM:-VERSION}

# set the draft flag by default.
opts="-d"
hubr now && opts=""

version=$(head -n1 "$file") || die "unable to read version file"
hubr push "$opts" "$repo"   || die "unable to push release"

echo "::set-output name=version:: $version"
echo "released $repo@$version"
