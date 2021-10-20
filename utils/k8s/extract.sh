#!/bin/bash
cd "$(dirname "$0")"

for ctx in $(kubectl config get-contexts -o name); do
  FILE="$ctx.yaml"
  # if we have exactly 4 parts, it's probably a GKE cluster. Use the shortname and hope there aren't collisions.
  SHORTNAME=$(echo $ctx | cut -d'_' -f4)
  if [ -n $SHORTNAME ]; then
    FILE=$SHORTNAME.yaml
  fi
  kubectl config view --minify --flatten --context=$ctx > $FILE
done
~/g/s/i/