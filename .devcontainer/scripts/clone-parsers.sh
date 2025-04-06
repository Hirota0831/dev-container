#!/bin/bash
set -e

BASE_DIR=/root/.cucumber/implementation
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

# 使用する tree-sitter のバージョン
TREE_SITTER_VERSION="0.22.5"

repos=(
  "tree-sitter-java"
  "tree-sitter-javascript"
  "tree-sitter-python"
  "tree-sitter-ruby"
  "tree-sitter-c-sharp"
)

for repo in "${repos[@]}"; do
  echo "== Cloning $repo =="
  rm -rf "$repo"
  git clone --depth 1 https://github.com/tree-sitter/${repo}.git "$repo"
  cd "$repo"

  echo "-- Installing dependencies --"
  rm -rf node_modules
  npm install tree-sitter@"^${TREE_SITTER_VERSION}"

  echo "-- Generating grammar --"
  npx tree-sitter generate || true

  echo "-- Rebuilding native module --"
  npm rebuild || node-gyp rebuild || true

  cd "$BASE_DIR"
done
