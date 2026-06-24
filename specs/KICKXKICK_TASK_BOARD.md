# Kick×Kick Task Board v1.1

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
- [x] SEARCH_SPEC.md 作成
- [x] SEARCH_DATA_SPEC.md 作成
- [x] ALIAS_MASTER_SPEC.md 作成
- [x] REGISTRATION_FLOW_SPEC.md 作成
- [ ] 検索用データ生成仕様の実装指示作成
- [ ] Alias横断監査
- [ ] Search MVPテストケース作成
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

- [ ] Brand search model
- [ ] Model search model
- [ ] Alias search model
- [ ] Search normalization
- [ ] Search ranking
- [ ] Brand candidate UI
- [ ] Model candidate UI
- [ ] Free input fallback
- [ ] Registration flow integration
- [ ] Search MVP test cases

参照仕様:

```text
SEARCH_SPEC.md
SEARCH_DATA_SPEC.md
ALIAS_MASTER_SPEC.md
REGISTRATION_FLOW_SPEC.md
BRAND_MASTER.md
MODEL_MASTER/README.md
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

---

# Current Focus

現在やること:

```text
Search / Registration 実装準備
```

次:

```text
Sprint1実装
```

その次:

```text
Sprint2 Collection
```

最重要ルール:

Kick×Kickは管理アプリではない。

Collect.
Create.
Exhibit.

この体験を完成させる。
