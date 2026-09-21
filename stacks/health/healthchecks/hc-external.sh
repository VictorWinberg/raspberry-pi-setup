#!/bin/bash
set -euo pipefail

curl --fail --silent --show-error --retry 3 -o /dev/null https://hc-ping.com/20fcbef4-bf04-4574-86f7-37b5811479be
