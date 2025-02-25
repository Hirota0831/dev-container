#!/bin/bash
set -e  # エラー時にスクリプトを終了

LOG_FILE="/workspace/.devcontainer/init-db.log"

echo "🔍 Checking Oracle DB Container..." | tee -a $LOG_FILE

# `.env` を読み込む
if [ -f /workspace/.devcontainer/.env ]; then
  export $(grep -v '^#' /workspace/.devcontainer/.env | xargs)
fi

# Oracle コンテナの存在チェック
if docker ps --filter "name=oracle-db" | grep -q "oracle-db"; then
  echo "✅ Oracle DB コンテナはすでに存在します。DDL の実行のみを行います。" | tee -a $LOG_FILE
else
  echo "🛠 Oracle DB コンテナが見つかりません。新しく作成します。" | tee -a $LOG_FILE

  # Oracle DB コンテナの起動
  docker compose -f /workspace/.devcontainer/docker-compose.yml up -d oracle-db

  # DBの起動を待機
  echo "⏳ Waiting for Oracle DB to start..." | tee -a $LOG_FILE
  sleep 60  # 必要に応じて変更（DBの起動時間）

  echo "✅ Oracle DB が起動しました。" | tee -a $LOG_FILE
fi

# DDL の適用
echo "🛠 Applying DDL scripts..." | tee -a $LOG_FILE
docker exec -i oracle-db sqlplus -s "system/${ORACLE_PWD}@//localhost:1521/${ORACLE_PDB}" <<EOF
  @/workspace/.devcontainer/init.sql
  EXIT;
EOF

echo "✅ DDL Execution Completed" | tee -a $LOG_FILE
