#!/usr/bin/env sh

RECLAIMED=$(find ssb-pub-data/blobs -atime +120 -printf "%k\n" | awk 'BEGIN{total=0} {total=total+$1} END{print total}')
find ssb-pub-data/blobs -atime +120 -exec rm {} \;
echo $(date -I) $RECLAIMED"MiB reclaimed"
