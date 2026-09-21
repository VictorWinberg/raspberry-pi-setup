#!/bin/bash
set -euo pipefail

curl --fail --include -s https://home.codies.se/

curl --fail --silent --show-error --retry 3 -o /dev/null https://hc-ping.com/eed15406-81a8-414c-b18c-b4798c6a2935
