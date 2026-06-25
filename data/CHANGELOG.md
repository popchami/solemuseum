# Kick×Kick Data Changelog

このファイルは、`data/` 配下の実データ資産の変更履歴を管理する。

Gitのcommit履歴とは別に、データとして何を追加・変更・修正したかを人間が追いやすくするために残す。

---

## 2026-06-25

### Added

- `data/brands.json` を追加
  - Tier S ブランドを初期登録
  - Nike
  - Air Jordan
  - adidas
  - New Balance
  - ASICS

- `data/models.json` を追加
  - Tier S ブランドのMVP向け代表モデルを登録
  - Nike主要モデル
  - Air Jordan主要モデル
  - adidas主要モデル
  - New Balance主要モデル
  - ASICS主要モデル

- `data/aliases.json` を追加
  - AF1 / AJ1 / AM95 / P6000 / GT2160 / NB550 などの検索Aliasを登録

- `data/search_keywords.json` を追加
  - 95 / 990 / 2160 / 1130 / AirMax95 / エアマックス95 などを登録

- `data/README.md` を追加
  - dataディレクトリの役割
  - Canonical Nameルール
  - Aliasルール
  - searchKeywordsルール
  - 更新手順

- `data/validation_rules.md` を追加
  - JSONデータの品質ルール
  - 重複禁止
  - Cross File Referenceルール
  - Quality Gate

- `data/schema/` を追加
  - `brand.schema.json`
  - `model.schema.json`
  - `alias.schema.json`
  - `search_keyword.schema.json`

### Changed

- `specs/README.md` に `../data/*.json` を正本として追加
- `specs/KICKXKICK_TASK_BOARD.md` のCurrent Focusを `data JSON監査・Tier S補強` に変更

### Fixed

- データ運用方針を `specs/` 中心から `data/` 実データ資産中心へ移行

### Notes

- 2026-06-25時点では `data/*.json` は v0.1.0 として扱う
- 今後は `data/CHANGELOG.md` に実データ変更の意味を記録する
- Tier S完成後、Tier Aブランドを同じ形式で拡張する
