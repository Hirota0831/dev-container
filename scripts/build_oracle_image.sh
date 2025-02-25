#!/bin/bash

# スクリプトのエラー発生時に停止
set -e

ORACLE_ZIP_FILE="D:\LINUX.X64_193000_db_home.zip"

# 必須変数の確認
if [ ! -f "$ORACLE_ZIP_FILE" ]; then
  echo "Error: ORACLE_ZIP_FILE is not set or the directory does not exist."
  echo "Set ORACLE_ZIP_FILE to the directory containing LINUX.X64_193000_db_home.zip or edit the script."
  echo "Current value: $ORACLE_ZIP_FILE"
  exit 1
fi

# Oracle Docker GitHub リポジトリをクローン
if [ ! -d "docker-images" ]; then
  echo "Cloning Oracle Docker images repository..."
  git clone https://github.com/oracle/docker-images.git
fi

# 必要なディレクトリに移動
cd docker-images/OracleDatabase/SingleInstance/dockerfiles

# ZIP ファイルの存在確認とコピー
if [ -f "$ORACLE_ZIP_FILE" ]; then
  echo "Copying Oracle Database installation file..."
  cp "$ORACLE_ZIP_FILE" 19.3.0/
else
  echo "Error: LINUX.X64_193000_db_home.zip not found in $ORACLE_ZIP_FILE."
  exit 1
fi

# Docker イメージをビルド
echo "Building Oracle Database 19c Docker image..."
./buildContainerImage.sh -v 19.3.0 -e

# イメージをエクスポート
echo "Exporting Docker image to $ORACLE_IMAGE_FILE..."
docker save -o "$ORACLE_IMAGE_FILE" oracle/database:19.3.0-ee

# エクスポートしたイメージをプロジェクトルートに移動
echo "Moving $ORACLE_IMAGE_FILE to project root..."
mv "$ORACLE_IMAGE_FILE" ../../../..

# 使用したリポジトリを削除
cd ../../../..
rm -rf docker-images

echo "Oracle Database 19c Docker image build and export completed!"
