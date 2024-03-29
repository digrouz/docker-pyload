#!/usr/bin/env bash

PYLOAD_URL="https://pypi.org/project/pyload-ng/#history"

FULL_LAST_VERSION=$(curl -SsL ${PYLOAD_URL} | \
                    egrep 'release__card' | \
                    sed -e 's|^.*pyload-ng/||' -e 's|/">||' | \
                    head -1
                  )
LAST_VERSION="${FULL_LAST_VERSION}"


if [ "${LAST_VERSION}" ]; then
  sed -i -e "s|PYLOAD_VERSION='.*'|PYLOAD_VERSION='${LAST_VERSION}'|" Dockerfile*
fi

if output=$(git status --porcelain) && [ -z "$output" ]; then
  # Working directory clean
  echo "No new version available!"
else 
  # Uncommitted changes
  git commit -a -m "update to version: ${LAST_VERSION}"
  git push
fi
