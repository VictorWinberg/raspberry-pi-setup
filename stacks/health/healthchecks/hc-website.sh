#!/bin/bash
set -euo pipefail

curl --fail --include -s https://www.codies.se/

curl --fail --silent --show-error --retry 3 -o /dev/null https://hc-ping.com/39c9e8a2-2a65-4a7a-a0ac-9efb25abf881
