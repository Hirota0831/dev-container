#!/bin/bash
set -e

BASE_DIR=/root/.cucumber/implementation
mkdir -p "$BASE_DIR"
cd "$BASE_DIR"

repos=(
  "tree-sitter-java"
  "tree-sitter-javascript"
  "tree-sitter-python"
  "tree-sitter-ruby"
  "tree-sitter-c-sharp"
  "tree-sitter-php"
  "tree-sitter-tsx"
)

for repo in "${repos[@]}"; do
  echo "Cloning $repo..."
  rm -rf "$repo"
  git clone --depth 1 https://github.com/tree-sitter/${repo}.git "$repo"

  cd "$repo"

  echo "Installing dependencies..."
  rm -rf node_modules
  npm install || true

  echo "Generating grammar..."
  npx tree-sitter generate || true

  echo "Rebuilding native module..."
  npm rebuild || node-gyp rebuild || true

  # 不要な prebuilds を削除（誤ロード防止）
  find node_modules/tree-sitter -type d -name "prebuilds" -exec rm -rf {} + || true

  cd "$BASE_DIR"
done
