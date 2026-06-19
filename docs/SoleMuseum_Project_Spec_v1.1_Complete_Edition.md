# SoleMuseum Project Spec v1.1 Complete Edition

## 概要
本仕様書は SoleMuseum の単一親仕様書である。
開発、設計、Copilot、Codexへの指示は本仕様書を最優先とする。

---

# 1. ブランド

アプリ名: SoleMuseum
ストア名: SoleMuseum - スニーカーコレクション
コピー: Collect. Preserve. Showcase.

コンセプト:
自分だけのスニーカー博物館

禁止ワード:
- Vault
- SoleVault
- Vault Door
- 金庫感

---

# 2. 技術スタック

- Flutter
- Dart
- Material 3
- Riverpod
- SQLite
- SharedPreferences
- image_picker
- share_plus
- archive
- path_provider
- in_app_purchase

---

# 3. データモデル

## Shoe

- id
- brandId
- modelName
- size
- color
- purchaseDate
- purchasePrice
- purchaseStore
- memo
- favorite
- createdAt
- updatedAt

## Brand

- id
- name
- sortOrder

## Photo

- id
- shoeId
- category
- filePath
- displayOrder
- createdAt

category:
- main
- gallery
- box
- wear

## WearLog

- id
- shoeId
- wornDate

同一 shoeId + wornDate は重複禁止

## Top5Item

- rank
- shoeId

rank:
1〜5

## AppSettings

- themeMode
- proUnlocked
- onboardingCompleted

---

# 4. SQLiteテーブル

## shoes

主キー:
id

## brands

主キー:
id

## photos

主キー:
id

インデックス:
shoeId

## wear_logs

主キー:
id

ユニーク:
shoeId + wornDate

## top5_items

主キー:
rank

## app_settings

主キー:
key

---

# 5. 写真仕様

対応:

- JPEG
- PNG
- HEIC

非対応:

- GIF
- Video
- Live Photo

保存:

- アプリ専用フォルダへコピー
- 長辺2048px
- JPEG品質85%

---

# 6. 無料版

登録上限:
20足

21足目:
保存不可

許可:
- 閲覧
- 編集
- 削除

Pro購入画面へ誘導

---

# 7. Pro版

価格:
980円買い切り

機能:

- 無制限登録
- TOP5編集
- SNS共有
- ZIPバックアップ
- ZIP復元
- 統計
- Luxuryテーマ

購入復元対応:

- Android
- iOS

---

# 8. ZIPバックアップ

ファイル名:

solemuseum_backup_yyyyMMdd.zip

内容:

- SQLite
- photos
- wear_logs
- top5
- settings

---

# 9. 検索仕様

対象:

- ブランド名
- モデル名
- カラー
- 購入店
- メモ

部分一致検索

---

# 10. SNS共有

サイズ:

1080x1350

共有種別:

- MY COLLECTION
- MY TOP 5
- Shoe Card

---

# 11. テーマ

無料:

- Light
- Dark
- System

Pro:

- Luxury

---

# 12. Sprint運用

Sprint1:
土台のみ

Sprint2:
SQLite
Shoe CRUD

Sprint3:
写真管理

Sprint4:
着用記録

Sprint5:
Pro課金

Sprint6:
バックアップ

---

# 13. Copilot/Codexルール

- 仕様外機能禁止
- Sprint外機能禁止
- Riverpod使用
- Vault系名称禁止

---

# 14. 成功条件

ユーザーがアプリを開いた瞬間に

「自分のコレクションかっこいい」

と思えること。
