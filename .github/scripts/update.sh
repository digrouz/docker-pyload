#!/usr/bin/env bash

PYLOAD_URL="https://pypi.org/rss/project/pyload-ng/releases.xml"

FULL_LAST_VERSION=$(curl -SsL ${PYLOAD_URL} | \
                    grep 'title' | \
                    grep -v 'PyPI' | \
                    sed -e 's|^.*<title>||' -e 's|</title>||' | \
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
