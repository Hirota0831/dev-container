# Java 17 ベースの Dev Container イメージ
FROM mcr.microsoft.com/devcontainers/java:1-17-bookworm

# # 必要なツール群をインストール
# RUN apt-get update && apt-get install -y \
#   curl \
#   gnupg \
#   git \
#   make \
#   g++ \
#   python3 \
#   python3-dev \
#   cmake \
#   unzip \
#   mono-complete

# Node.js 18.x をインストール
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Python（node-gypが内部で使うこともあるため）
RUN apt-get install -y python3 python3-dev make g++


# # 正しいバージョンの tree-sitter-cli をグローバルインストール
# RUN npm install -g tree-sitter-cli@0.22.6

# # スクリプトをコピーして実行できるようにする
# COPY scripts/build-tree-sitter-parsers.sh /usr/local/bin/
# RUN chmod +x /usr/local/bin/build-tree-sitter-parsers.sh

# # Dev Container ビルド時にパーサをすべてビルド（不要な prebuilds を削除しておく）
# RUN /usr/local/bin/build-tree-sitter-parsers.sh && \
#     find /root/.cucumber/implementation -type d -name "prebuilds" -exec rm -rf {} +
