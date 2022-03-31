#!/bin/sh

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu

DIRNAME=$(dirname "$0")

# Import helpers
. "$DIRNAME/../../../../scripts/helpers/utilities.sh"

echo "--- Bootstrap Mint ---"
assert_is_installed "mint"
mint bootstrap
echo ''

echo "--- Build dependencies ---"
echo "Searching for build.sh files inside every directory"

# Find files named ./build.sh in every directory contained
# within the Packages directory. Doesn't go deeper than depth 2,
# and doesn't consider depth 0 or 1 either.
build_files=$(find ../../packages -type f -maxdepth 2 -name "build.sh" | sort)
echo "Found the following files:"
echo "$build_files" | tr " " "\n"
echo ''

echo "Running independent build files"
for build_file in $build_files
do
  cd "$(dirname "$build_file")"
  build_file_basename=$(basename "$build_file")
  # shellcheck source=./build.sh
  . "$build_file_basename"
  echo ''
  cd ../../
done
