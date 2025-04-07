Feature: ユーザーログイン機能

  Scenario: 正しいユーザー名とパスワードでログインに成功する
    Given ユーザーがログインページを開いている
    When ユーザーがユーザー名 "testuser" とパスワード "password123" を入力する
    And ログインボタンをクリックする
    Then ホームページが表示される