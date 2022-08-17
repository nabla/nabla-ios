#!/bin/bash

# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu

DIRNAME=$(pwd)

# Import helpers
. "$DIRNAME/../../../../scripts/helpers/utilities.sh"

assert_is_installed "mint"

echo "--- NablaCore - Build ---"

# -- Apollo --
# This should be kept in sync with the files in ApolloCodegen/Sources/ApolloCodegen/main.swift
input_output_files=(
  "$DIRNAME/Data/GQL/Schema"
  "$DIRNAME/../../../../graphql/sdk"
)

cd ../../ApolloCodegen
run_cached apollo-codegen "${input_output_files[*]}" \
  /usr/bin/xcrun --sdk macosx swift run ApolloCodegen generate NablaCore
cd "$DIRNAME"
sed -i "" "s/public//" Data/GQL/Generated/*.swift
