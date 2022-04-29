#!/bin/sh

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu

DIRNAME=$(dirname "$0")

# Import helpers
. "$DIRNAME/../../../../scripts/helpers/utilities.sh"

assert_is_installed "mint"

echo "--- NablaMessagingUI - Build ---"

GENERATED_FOLDER="$DIRNAME"/Generated
echo "Create Generated folder in $GENERATED_FOLDER if not existing"
mkdir -p "$GENERATED_FOLDER"

echo "Execute swiftgen"
mint run -m ../../Mintfile swiftgen config run --config "$DIRNAME"/swiftgen.yml
