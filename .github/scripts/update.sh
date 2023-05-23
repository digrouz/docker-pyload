#!/usr/bin/env bash

PYLOAD_URL="https://pypi.org/project/pyload-ng/\#history"

FULL_LAST_VERSION=$(curl -SsL ${PYLOAD_URL} | \
                    grep -oP "<a class=\"card release__card\" href=\"/project/pyload-ng/\K.*\d" \
                  )
LAST_VERSION="${FULL_LAST_VERSION}"

sed -i -e "s|PYLOAD_VERSION='.*'|PYLOAD_VERSION='${LAST_VERSION}'|" Dockerfile*

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update to version: ${LAST_VERSION}"
  git push
fi
