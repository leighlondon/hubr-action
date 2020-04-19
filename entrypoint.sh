#!/usr/bin/env bash
die() { echo "$1" >&2; exit "${2:-1}"; }
hash hubr 2>/dev/null || die "missing hubr"

hubr tags hubr
