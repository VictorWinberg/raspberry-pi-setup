#!/bin/bash
set -euo pipefail

if [ -n "$(ls -A /mnt/storage 2>/dev/null)" ]; then
  curl --fail --silent --show-error --retry 3 -o /dev/null https://hc-ping.com/1cd9faae-de3e-4172-a6f3-ffa56a63e707
else
  sudo mount -a
fi
