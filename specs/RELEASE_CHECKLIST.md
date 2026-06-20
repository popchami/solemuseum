# RELEASE_CHECKLIST.md

## 概要

SoleMuseum MVPリリース前に確認する項目を定義する。

本チェックリストをすべて満たした場合のみ
v1.0.0としてリリース可能とする。

---

# Build

## Android

- [ ] Release Build成功
- [ ] クラッシュしない
- [ ] アイコン表示正常
- [ ] Splash表示正常

---

# Navigation

## Home

- [ ] 表示成功

## Collection

- [ ] 表示成功

## Detail

- [ ] 表示成功

## Form

- [ ] 表示成功

## Settings

- [ ] 表示成功

---

# CRUD

## Create

- [ ] スニーカー登録成功

## Read

- [ ] 一覧表示成功
- [ ] 詳細表示成功

## Update

- [ ] 編集成功

## Delete

- [ ] 削除成功

---

# Database

- [ ] SQLite作成成功
- [ ] Migration正常
- [ ] 再起動後もデータ保持

---

# Home Screen

- [ ] 注目の展示表示
- [ ] 統計表示
- [ ] 最近のコレクション表示

---

# Collection Screen

- [ ] 一覧表示
- [ ] 検索動作
- [ ] ブランドフィルタ動作

---

# Detail Screen

- [ ] Hero画像表示
- [ ] 基本情報表示
- [ ] メモ表示

---

# Form Screen

- [ ] 写真登録
- [ ] ブランド入力
- [ ] モデル名入力
- [ ] サイズ入力
- [ ] 購入日入力
- [ ] メモ入力

---

# Settings Screen

- [ ] バージョン表示
- [ ] ライセンス表示

---

# Theme

- [ ] Museum Black適用
- [ ] Gallery Gold適用
- [ ] ダークテーマ統一

---

# Error Handling

- [ ] エラー表示確認
- [ ] クラッシュしない

---

# Performance

- [ ] 一覧表示3秒以内
- [ ] 詳細表示1秒以内

---

# Assets

- [ ] App Icon登録
- [ ] Splash登録

---

# Code Quality

- [ ] Analyzer警告ゼロ
- [ ] Debugコード削除
- [ ] 未使用コード削除

---

# MVP Scope Check

実装済み

- [ ] 登録
- [ ] 一覧
- [ ] 詳細
- [ ] 編集
- [ ] 削除

未実装

- [ ] ログイン
- [ ] クラウド同期
- [ ] AI鑑定
- [ ] 相場取得
- [ ] SNS共有

---

# Release Decision

以下を満たすこと

- [ ] Build成功
- [ ] CRUD成功
- [ ] クラッシュなし
- [ ] 仕様書準拠

---

# Release Version

```text
v1.0.0
```

---

# SoleMuseum Release Definition

ユーザーが

```text
スニーカーを収蔵する
記録する
展示する
```

を問題なく実行できる状態を
MVP完成とする。