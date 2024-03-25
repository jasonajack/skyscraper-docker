#!/usr/bin/env bash
set -xeuo pipefail

REPORT_TYPES="title,platform,description,rating,cover,screenshot,marquee,video"

cd "${ROMS_PATH}"

# Use passed in platforms (e.g. gb, snes, psx, ...) or use all directories in the base path
if [[ "${#@}" -gt 0 ]]; then
  rom_paths="${@}"
else
  rom_paths=( $(basename -a $(ls -d */)) )
fi

for dir in "${rom_paths[@]}"; do
  platform="${dir%%/}"

  # Scrape for new or missing content
  if [ ${RUN_SCREENSCRAPER} -eq 1 ]; then
    echo Skyscraper -c "${CONFIG_FILE}" -s screenscraper -p "${platform}"
  fi

  # Regenerate gamelist.xml
  echo Skyscraper -c "${CONFIG_FILE}" -p "${platform}" -o "/roms/${platform}"

  # Generate reports
  echo Skyscraper -c "${CONFIG_FILE}" -p "${platform}" --cache "report:missing=${REPORT_TYPES}"
done
