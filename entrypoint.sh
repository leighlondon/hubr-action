#!/usr/bin/env bash
die() { echo "::error file=entrypoint.sh::$1" >&2; exit "${2:-1}"; }
hash hubr 2>/dev/null || die "missing hubr"
export HUBR_DEFAULT_ORG=""
hubr tags "$1"
