# Kick×Kick Data Changelog

このファイルは、`data/` 配下の実データ資産の変更履歴を管理する。

Gitのcommit履歴とは別に、データとして何を追加・変更・修正したかを人間が追いやすくするために残す。

---

## 2026-06-29 v0.4.1

### Added

- `data/MARKET_REFERENCE_POLICY.md` を追加
  - 国内大手販売サイトを、完成形に近い国内流通リファレンスとして扱う方針を明文化
  - Tier S / Tier A も完成固定ではなく、差分監査を継続する方針を明記
  - 新作モデルが増えた場合、Kick×Kickでも追加候補として扱う運用を明記

### Audited

- 今回はデータJSON本体の追加・変更はなし
- ブランド・モデル・Alias・searchKeywordsの品質ルールは既存の `data/validation_rules.md` v1.2 を維持
- 商品説明文・画像・在庫情報をコピーしない方針を維持

### Remaining

- Tier S / A / B の国内流通リファレンス差分監査
- Search MVPテストケース実施
- data/*.json と app/assets/data/*.json の同期自動化

---

## 2026-06-29 v0.4.0

### Added

- `data/brands.json` を v0.4.0 に更新
  - Tier Bとして `Saucony` / `SALOMON` を追加

- `data/models.json` を v0.4.0 に更新
  - Saucony: `Ride 19` / `Triumph 24` / `Guide 19` / `Hurricane 25` / `ProGrid Omni 9` / `ProGrid Guide 7`
  - SALOMON: `XT-6` / `XT-WHISPER` / `XA PRO` / `SPEEDCROSS` / `X ULTRA` / `XT-4`

- `data/aliases.json` を v0.4.0 に更新
  - Saucony: `Ride19` / `Triumph24` / `Guide19` / `Hurricane25` / `ProGridOmni9` / `ProGridGuide7`
  - SALOMON: `XT6` / `XTWhisper` / `XAPro` / `Speedcross` / `XUltra` / `XT4`

- `data/search_keywords.json` を v0.4.0 に更新
  - Saucony / SALOMON の連結表記・日本語検索を追加

- `app/assets/data/*.json` を v0.4.0 として同期更新

- `data/README.md` を更新
  - ABC-MARTなど国内大手販売サイトをリファレンスとして扱う運用を明記

- `data/validation_rules.md` を v1.2 に更新
  - Market Reference Rule を追加
  - `Ride` / `Guide` / `XT` / `Pro` など広すぎる検索語をNG例に追加

### Audited

- ABC-MARTブランド一覧に `Saucony` / `SALOMON` が掲載されていることを確認
- Saucony公式サイト上で、追加モデルのうち `Ride 19` / `Triumph 24` / `Guide 19` / `Hurricane 25` / `ProGrid Omni 9` / `ProGrid Guide 7` を確認
- SALOMON公式サイト上で、定番モデルとして `XT-6` / `XT-WHISPER` / `XA PRO` / `SPEEDCROSS` / `X ULTRA` / `XT-4` を確認
- `models.json.brandId -> brands.json.brandId` の参照を確認
- `aliases.json.modelId -> models.json.id` の追加分参照を確認
- `search_keywords.json.modelId -> models.json.id` の追加分参照を確認
- `data/*.json` と `app/assets/data/*.json` の同期を確認
- 1文字数字検索 `4` / `6` / `7` / `9` は追加しない
- `Ride` / `Guide` / `XT` / `Pro` など広すぎる単語単体は追加しない
- 低確度モデル、色名、コラボ名は追加なし

### Remaining

- Search MVPテストケース実施
- data/*.json と app/assets/data/*.json の同期自動化
- Tier S/AのABC-MART差分監査を継続
- Tier B次候補: Mizuno / On / Merrell / Brooks などを国内流通・公式確認ベースで検討

---

## 2026-06-28 v0.3.1

### Added

- `data/aliases.json` を v0.3.1 に更新
  - HOKA: `Bondi9` / `Clifton10` / `Speedgoat7` / `Arahi8` / `Transport2` / `Challenger8`

- `data/search_keywords.json` を v0.3.1 に更新
  - HOKA: 連結表記と日本語検索を追加
  - `Bondi9` / `ボンダイ9`
  - `Clifton10` / `クリフトン10`
  - `Speedgoat7` / `スピードゴート7`
  - `Arahi8` / `アラヒ8`
  - `Transport2` / `トランスポート2`
  - `Challenger8` / `チャレンジャー8`

- `app/assets/data/aliases.json` / `app/assets/data/search_keywords.json` を同期更新

### Audited

- HOKAの既存6モデルに対する検索補助のみ追加
- 参照先 `modelId` は `data/models.json` に存在することを確認
- 1文字数字検索 `9` / `7` / `8` / `2` は追加しない
- `Bondi` / `Clifton` / `Speedgoat` など世代を含まない広いシリーズ名単体は追加しない
- 低確度モデル、色名、コラボ名は追加なし

### Remaining

- Search MVPテストケース実施
- data/*.json と app/assets/data/*.json の同期自動化
- Tier B/Cの次候補追加は別作業で検討

---
