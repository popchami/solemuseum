# SoleMuseum 開発引き継ぎ（2026-06-25）

## プロジェクト概要

### アプリ名

SoleMuseum

### コンセプト

スニーカーを「収蔵・記録・展示」するデジタルミュージアム

### 技術構成

- Flutter
- Material3
- Riverpod
- SQLite
- Repositoryパターン
- ローカル保存

---

## Sprint状況

### Sprint1

実装済み:

- BottomNavigation
- Home
- Collection
- Settings

### Sprint2

実装済み:

- Shoe登録
- Shoe編集
- Shoe詳細
- Brand管理
- Repository
- SQLite
- Riverpod Provider

### Sprint3

実装済み:

- メイン写真
- PhotoRepository
- PhotoStorageService
- PhotoProvider
- 着用履歴（wear_logs）
- MY TOP5（top_order）

---

## DB

最新版:

```text
version = 5
```

追加カラム:

```text
display_title TEXT
sticker_text TEXT
status TEXT NOT NULL DEFAULT 'new'
```

migration:

```text
oldVersion < 5
```

状態:

```text
実装済み
```

---

## Shoeモデル

追加済み:

- displayTitle
- stickerText
- status

追加メソッド:

- statusLabel
- normalizeStatus()

状態:

```text
new
worn
parted
```

---

## ShoeFormScreen

追加済み:

### Display Title

- 最大10文字

### Sticker Text

- 最大15文字

### 状態

- 新品
- 着用済み
- 手放した

保存フロー:

```text
toMap()
↓
Repository
↓
SQLite
```

---

## ShoeDetailScreen

追加済み:

- Display Title
- Sticker Text
- 状態

AppBar表示:

```text
Display Titleがある場合
↓
Display Title表示

無い場合
↓
Model Name表示
```

---

## Repository

構造変更なし。

既存の流れを維持:

```text
toMap()
↓
Repository
↓
SQLite
↓
fromMap()
```

---

## お気に入り機能

Kick×Kick仕様に合わせてUIから削除済み。

削除済み:

- ShoeFormScreen
- ShoeDetailScreen
- Home MuseumSummary

TOP5へ統一済み。

DB互換のため、`isFavorite` カラムは残存。

---

## 実機動作

過去にSoleMuseumとして実機起動実績あり。

ただし今回のversion5対応後は未確認。

未実施:

```text
flutter pub get
flutter analyze
flutter run
```

---

## GitHubコミット

```text
9a735b1c0f3ea8e2e83ccaf2f09c0051ecb51b84
dac2eb917ecb76f75f3d9956c7d5d45b9aecdad3
b331a1ef1ff890bb9bbf1f7f783a7ad08a916780
7266d854402b9ed5eca7cbc3880df99e7d6ac06c
```

---

## 注意事項

ShoeDetailScreen更新時にGitHub側の安全チェックで全文更新が一度ブロックされた。

そのため最終更新は最小差分で通している。

実機確認時に以下が正常に動くか確認すること:

- 写真表示
- 編集
- 削除
- MY TOP5
- 着用履歴

---

## 次にやること

1. `flutter pub get`
2. `flutter analyze`
3. `flutter run`
4. DB migration(version5)確認
5. 新規登録確認
6. 編集確認
7. ShoeDetailScreen確認
8. Collection画面
   - Display Title表示
   - 状態表示
9. Home画面
   - Display Title対応
   - 最近追加対応
10. 検索
    - Display Title追加
    - Sticker Text追加
11. フィルター
    - 状態
12. Sticker機能実装

---

## 開発方針

- Riverpod構成を維持
- Repository構成を維持
- SQLite中心
- 既存構成を壊さない
- 小さな変更単位で実装
- 各変更後に analyze・実機確認を行う
- MVP優先
