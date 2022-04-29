#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu

DIRNAME=$(pwd)

# Import helpers
. "$DIRNAME/../../../../scripts/helpers/utilities.sh"

assert_is_installed "mint"

echo "--- NablaMessagingCore - Build ---"


# This should be kept in sync with the files in ApolloCodegen/Sources/ApolloCodegen/main.swift
input_output_files=(
  "$DIRNAME/Data/GQL/Schema"
)

cd ../../ApolloCodegen

run_cached apollo-codegen "${input_output_files[*]}" \
  /usr/bin/xcrun --sdk macosx swift run ApolloCodegen generate

cd $DIRNAME

# SwiftGen
GENERATED_FOLDER="$DIRNAME"/Generated
echo "Create Generated folder in $GENERATED_FOLDER if not existing"
mkdir -p "$GENERATED_FOLDER"

echo "Execute swiftgen"
mint run -m ../../Mintfile swiftgen config run --config "$DIRNAME"/swiftgen.yml
