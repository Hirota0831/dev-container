# Brand System Dev Container

このプロジェクトは、Dockerを使用してJava 17、Maven、およびOracle 19cをサポートする開発環境を構築するための設定を含んでいます。

## ディレクトリ構成

```text
/java-maven-oracle-container        <-- プロジェクトのルートフォルダ
│
├── .devcontainer/                 <-- Dev Containers設定フォルダ
│   ├── devcontainer.json          <-- VSCode用設定ファイル
│   ├── Dockerfile                 <-- コンテナの構築設定ファイル
│
└── github-repository/             <-- GitHubからクローンしたリポジトリを格納するフォルダ
```

## 使用方法

1. リポジトリをクローン:
   ```bash
   git clone <リポジトリURL>
   ```

2. `github-repository`フォルダにGitHubリポジトリをクローン:
   ```bash
   git clone <リポジトリURL> github-repository
   ```

3. VSCodeでプロジェクトフォルダを開きます。

4. 左下の「><」アイコンをクリックし、「**Reopen in Container**」を選択してコンテナを起動します。

5. 起動後、以下のコマンドを使用してツールの動作を確認します:
   ```bash
   java -version
   mvn -version
   ```

## 必要な環境

- Docker Desktop（最新バージョン）
- Visual Studio Code（最新バージョン）
- 必要な拡張機能:
  - Dev Containers
  - Docker
  - Java Extension Pack

