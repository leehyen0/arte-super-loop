#!/bin/bash
while true; do
  git fetch origin
  LOCAL=$(git rev-parse @)
  REMOTE=$(git rev-parse @{u})
  if [ $LOCAL != $REMOTE ]; then
    git pull
    bash scripts/deploy_vps.sh
    systemctl restart arte.service
  fi
  sleep 300
done
