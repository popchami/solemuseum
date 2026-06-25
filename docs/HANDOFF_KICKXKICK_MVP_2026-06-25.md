# Kick×Kick MVP開発引き継ぎ（2026-06-25）

## 方針

Kick×Kickとして進める。

旧プロジェクト名の表記は使わず、内容だけをKick×Kickへ引き継ぐ。

```text
SoleMuseum表記は使わない。
Kick×KickとしてMVPリリースを優先する。
```

---

## プロジェクト概要

### アプリ名

Kick×Kick

### コンセプト

貼って、飾って、コレクション。

スニーカーをコレクションし、ステッカー化し、展示できるアプリ。

### 技術構成

- Flutter
- Material3
- Riverpod
- SQLite
- Repositoryパターン
- ローカル保存

---

## ブランド・モデル・検索の状態

ブランド・モデル・検索作業はいったん終了。

検索はMVPリリース可能ライン。

対応済み:

- ブランド候補
- モデル候補
- Alias検索
- searchKeywords検索
- 数字検索
- 自由入力
- 自由入力ブランドのローカルDB追加
- 自由入力モデルの靴1件 `modelName` 保存

方針:

- ユーザーの自由入力はマスターJSONへ自動追加しない
- 誤入力は 靴詳細 → 編集 で修正する
- ブランド・モデルFactory作業へ戻らず、MVP本体開発を優先する

関連:

- `docs/HANDOFF_BRAND_MODEL_SEARCH.md`

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
実装済み。ただしversion5対応後の実機確認は未実施。
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

表示ラベル:

```text
new    -> 新品
worn   -> 着用済み
parted -> 手放した
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

確認対象:

- 写真表示
- 編集
- 削除
- MY TOP5
- 着用履歴

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

過去に旧名時代として実機起動実績あり。

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

今後も小さな差分で進める。

---

## 次にやること

最優先:

1. `app/` で `flutter pub get`
2. `flutter analyze`
3. `flutter run`

その後の確認順:

1. DB migration(version5)確認
2. 新規登録確認
3. 編集確認
4. ShoeDetailScreen確認
5. 写真確認
6. MY TOP5確認
7. 着用履歴確認
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

---

## Codex / Copilotへの指示

```text
Kick×Kickとして進めます。
旧プロジェクト名の表記は使わず、内容だけ引き継いでください。

関連引き継ぎ:
- docs/HANDOFF_KICKXKICK_MVP_2026-06-25.md
- docs/HANDOFF_BRAND_MODEL_SEARCH.md

まず app/ で以下を実行してください。

1. flutter pub get
2. flutter analyze
3. flutter run

その後、version5 migration、新規登録、編集、詳細画面、写真、TOP5、着用履歴の順に確認してください。
エラーが出たら、Riverpod / Repository / SQLite構成を壊さず、小さな差分で修正してください。

ブランド・モデルFactory作業には戻らず、Kick×KickのMVPリリースを優先してください。
```
