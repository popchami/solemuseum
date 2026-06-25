# Kick×Kick Task Board v1.4

## 目的

Kick×Kick開発の現在地を管理する。

スマホのみ開発でも、次に何をやるべきか迷わない状態を維持する。

---

# Backlog

未着手

## Product

- [ ] 利用規約
- [ ] プライバシーポリシー
- [ ] ストア説明文
- [ ] ストアキーワード
- [ ] FAQ

## Design

- [ ] アプリアイコン作成
- [ ] Splash作成
- [ ] Homeモック
- [ ] Collectionモック
- [ ] Stickerモック

## Development

- [ ] Sprint1実装
- [ ] Sprint2実装
- [ ] Sprint3実装
- [ ] Sprint4実装

## Master Data / Search

- [x] BRAND_MASTER.md 作成
- [x] MODEL_MASTER 運用ルール作成
- [x] MODEL_MASTER_DATA_SPEC.md 作成
- [x] SEARCH_SPEC.md 作成
- [x] SEARCH_DATA_SPEC.md 作成
- [x] ALIAS_MASTER_SPEC.md 作成
- [x] ALIAS_MASTER.md 作成
- [x] REGISTRATION_FLOW_SPEC.md 作成
- [x] REGISTRATION_VALIDATION_SPEC.md 作成
- [x] SEARCH_MVP_TEST_SPEC.md 作成
- [x] data/brands.json 作成
- [x] data/models.json 作成
- [x] data/aliases.json 作成
- [x] data/search_keywords.json 作成
- [x] data validation script 作成
- [x] data quality GitHub Actions 作成
- [ ] Tier S data JSON監査
- [ ] Canonical Name監査
- [ ] searchKeywords監査
- [ ] Alias横断監査
- [ ] Search MVPテストケース実施
- [ ] Plannedブランド追加

---

# Sprint1

状態:

```text
NEXT
```

目的:

スニーカー登録・詳細・TOP5・着用履歴

## Sprint1 Tasks

### Foundation

- [ ] Flutter起動確認
- [ ] Material3適用
- [ ] Riverpod適用
- [ ] Bottom Navigation
- [ ] FAB

### Sneaker

- [ ] Sneaker Model
- [ ] Sneaker Repository
- [ ] Sneaker Provider
- [ ] Sneaker Form
- [ ] Sneaker Detail

### Search / Registration

- [ ] Load data/brands.json
- [ ] Load data/models.json
- [ ] Load data/aliases.json
- [ ] Load data/search_keywords.json
- [ ] Brand search model
- [ ] Model search model
- [ ] Alias search model
- [ ] Search normalization
- [ ] Brand-first model suggestion
- [ ] Alphabetical suggestion limit 5
- [ ] Number search via searchKeywords
- [ ] Canonical modelName save
- [ ] Brand candidate UI
- [ ] Model candidate UI
- [ ] Brand change resets model
- [ ] Save validation for brand/model consistency
- [ ] Free input fallback
- [ ] Registration flow integration
- [ ] Search MVP test cases

参照仕様:

```text
SEARCH_SPEC.md
SEARCH_DATA_SPEC.md
ALIAS_MASTER_SPEC.md
ALIAS_MASTER.md
MODEL_MASTER_DATA_SPEC.md
REGISTRATION_FLOW_SPEC.md
REGISTRATION_VALIDATION_SPEC.md
SEARCH_MVP_TEST_SPEC.md
BRAND_MASTER.md
MODEL_MASTER/README.md
../data/brands.json
../data/models.json
../data/aliases.json
../data/search_keywords.json
../docs/KICKXKICK_RELEASE_PRIORITY.md
```

### Photo

- [ ] 写真登録
- [ ] 写真表示

### TOP5

- [ ] TOP5 Provider
- [ ] TOP5 UI
- [ ] TOP5登録
- [ ] TOP5入替

### Wear History

- [ ] 今日履いた
- [ ] 過去日追加
- [ ] 回数集計

### Home

- [ ] TOP5表示
- [ ] 最近追加したスニーカー
- [ ] Statistics簡易版

---

# Sprint2

状態:

```text
WAITING
```

目的:

Collection

## Sprint2 Tasks

- [ ] Collection Model
- [ ] Collection Repository
- [ ] Collection Provider
- [ ] Shelf List
- [ ] Shelf Create
- [ ] Shelf Delete
- [ ] Theme Select
- [ ] Slot Layout
- [ ] Zoom 2-5
- [ ] Box Display

---

# Sprint3

状態:

```text
WAITING
```

目的:

Sticker

## Sprint3 Tasks

- [ ] Sticker Model
- [ ] Sticker Repository
- [ ] Sticker Provider
- [ ] Sticker Board
- [ ] Sticker Generate
- [ ] Background Remove
- [ ] Move
- [ ] Rotate
- [ ] Scale
- [ ] Duplicate
- [ ] Undo
- [ ] Redo

---

# Sprint4

状態:

```text
WAITING
```

目的:

Premium / Backup / Export

## Sprint4 Tasks

- [ ] Free制限
- [ ] Premium判定
- [ ] PNG出力
- [ ] ゴミ箱
- [ ] 復元
- [ ] Backup
- [ ] Restore
- [ ] .kkb対応

---

# Release Checklist

## Before Release

- [ ] flutter analyze
- [ ] 実機確認
- [ ] クラッシュ確認
- [ ] アイコン完成
- [ ] スクリーンショット完成
- [ ] 利用規約
- [ ] プライバシーポリシー
- [ ] ストア文言
- [ ] Search MVPテスト通過
- [ ] 自由入力fallback確認
- [ ] ブランド変更時モデルリセット確認
- [ ] 正式modelName保存確認
- [ ] data JSON読み込み確認

---

# Current Focus

現在やること:

```text
Kick×Kick MVP実装準備
```

次:

```text
Search / Registration 実装
```

その次:

```text
Sprint1実装
```

最重要ルール:

Kick×Kickの目的は、Factoryではなくアプリをリリースすること。

Factory is support.
Kick×Kick release is the goal.

Collect.
Create.
Exhibit.

この体験を完成させる。
