# Kick×Kick Sprint2 Implementation Instruction

## 1. 目的

この指示書は、Codex / Copilot に渡して Kick×Kick Sprint2 を実装するためのものです。

Sprint2では、Kick×KickのCollection機能を実装します。

Collectionは「博物館 / 展示棚」です。
Stickerのような自由配置ではなく、整列展示を行います。

最優先は、

- 棚を作れる
- 棚を一覧できる
- スニーカーを棚に配置できる
- スロットに整列表示できる
- 背景テーマを選べる
- 箱表示ON/OFFを切り替えられる
- 最後に見ていた棚を復元できる

ことです。

## 2. 前提

Sprint1が完了している前提です。

既存機能:

- Bottom Navigation
- Home
- Sneaker Form
- Sneaker Detail
- TOP5
- Wear History
- App Settings

採用方針:

- Flutter
- Dart
- Material 3
- Riverpod
- ローカル保存優先

## 3. 参照する仕様書

```text
specs/KICKXKICK_PRODUCT.md
specs/KICKXKICK_UI_SPEC.md
specs/KICKXKICK_DATA.md
specs/KICKXKICK_DB_SPEC.md
specs/KICKXKICK_ROUTING_SPEC.md
specs/KICKXKICK_SPRINT_PLAN.md
```

## 4. Sprint2で作る画面

### 4.1 Collection Screen

Collectionタブで表示するメイン画面。

起動時:

- 最後に見ていた棚を表示する
- 棚一覧からではなく、前回の棚を直接開く

通常UI:

- 左上: 棚一覧
- 中央: 棚名
- 右上: 編集

### 4.2 Shelf List

棚一覧画面。

表示項目:

- サムネイル
- 棚名
- 足数
- テーマ

操作:

- 棚選択
- 棚追加
- 棚削除
- 棚名編集

### 4.3 Collection Edit Mode

編集モードでは下部ツールバーを表示する。

下部ツールバー:

- スニーカー追加
- 背景変更
- 箱表示
- 並び替え
- 保存

### 4.4 Sneaker Select for Collection

棚に追加するスニーカーを選ぶ画面。

- 登録済みスニーカー一覧を表示
- 同じスニーカーを複数棚へ配置可能
- 同じ棚内での重複配置はMVPでは避ける

### 4.5 Theme Select

背景テーマ選択画面。

Freeテーマ:

- Classic Wood
- Dark Wood

Premium候補:

- Concrete
- Graffiti
- Gallery
- Sneaker Shop
- Industrial
- Luxury Closet
- Neon

Sprint2ではPremium購入処理は未実装でもよい。
Premiumテーマ選択時はPremium案内画面または未解放表示にする。

## 5. Sprint2で作るデータモデル

DB仕様は `specs/KICKXKICK_DB_SPEC.md` を参照。

Sprint2対象:

```text
collections
collection_items
box_photos
app_settings
```

### 5.1 Collection

必要項目:

```text
id
name
theme_id
zoom_level
show_boxes
sort_order
created_at
updated_at
deleted_at
```

### 5.2 CollectionItem

必要項目:

```text
id
collection_id
sneaker_id
slot_index
created_at
updated_at
```

### 5.3 BoxPhoto

必要項目:

```text
id
sneaker_id
category
file_path
created_at
updated_at
```

category:

```text
angle_front
front
label
top
```

### 5.4 AppSettings 追加項目

```text
last_collection_id
has_seen_collection_zoom_guide
```

## 6. Collection表示ルール

Collectionは整列展示。

- 自由配置ではない
- 靴はスロットに吸着
- ドラッグで近いスロットへ吸着
- 保存後は配置固定
- 箱はスロットを消費しない

## 7. Collection倍率

ピンチで調整する。

倍率:

```text
2
3
4
5
```

意味:

- 2足表示
- 3足表示
- 4足表示
- 5足表示

仕様:

- 前回倍率を記憶する
- 初回だけ案内表示する
- 倍率変更時は靴・箱・Display Title・名札が同時に拡縮する
- 内部配置データは変えない

初回案内:

```text
ピンチで表示倍率を変更できます
```

## 8. 箱表示

箱は靴の補助演出。

重要ルール:

- 箱はスロットを消費しない
- 箱写真がある場合のみ表示可能
- 棚ごとに表示ON/OFF
- デフォルトOFF
- 靴と箱を別々に探させない
- 必ずスニーカーに紐づけて扱う

箱写真がない場合は、箱表示ONでも何も表示しない。

## 9. 棚追加 / 削除ルール

### 棚追加

- 編集モードまたは棚一覧から追加
- 自動追加はしない

### 空棚

- 自動削除しない
- ユーザーが削除する

### Free制限

Freeは1棚まで。

2棚目作成時はPremium案内を表示する。
Sprint2では購入処理は不要。

## 10. 画面遷移

```text
Collection Tab
↓
Last Viewed Collection
```

```text
Collection View
├─ Shelf List
├─ Edit Mode
└─ Sneaker Item → Sneaker Detail
```

```text
Shelf List
├─ Select Shelf → Collection View
├─ Create Shelf → Collection Edit
└─ Delete Shelf → Delete Confirm
```

```text
Collection View
↓
Edit
↓
Collection Edit Mode
├─ Add Sneaker
├─ Change Background
├─ Toggle Box Display
├─ Reorder
└─ Save
```

## 11. Provider / Repository

追加推奨Provider:

```text
collectionProvider
collectionListProvider
collectionItemProvider
collectionEditProvider
boxPhotoProvider
```

追加推奨Repository:

```text
collectionRepository
collectionItemRepository
boxPhotoRepository
```

既存の `sneakerRepository` と連携する。

## 12. Sprint2で実装しないこと

以下は実装しない。

- Sticker Board自由配置
- ステッカー生成
- 自動背景削除
- PNG出力
- バックアップ
- 復元
- 本番Premium購入処理
- 高度な棚レイアウト編集
- 箱を独立スロットとして扱う仕様

## 13. 完了条件

Sprint2完了条件:

- Collectionタブで棚を表示できる
- 最後に見ていた棚を復元できる
- 棚一覧を開ける
- 棚を追加できる
- 棚名を編集できる
- 棚を削除できる
- スニーカーを棚に追加できる
- 同じスニーカーを複数棚に配置できる
- スロットに整列表示される
- 並び替えできる
- 背景テーマを選べる
- 2〜5足表示倍率を切り替えられる
- 前回倍率を記憶する
- 初回倍率案内が出る
- 箱写真がある場合のみ箱表示ON/OFFできる

## 14. 実装後に報告すること

作業後、以下を報告してください。

- 作成 / 更新したファイル一覧
- 実装した画面
- 実装したProvider
- 実装したRepository
- DB変更内容
- まだ未実装の項目
- `flutter analyze` の結果
- 実機 / エミュレータ確認結果

## 15. 注意

Collectionは博物館です。

Stickerのように自由に散らす場所ではありません。

Collectionでは、靴を整列展示し、箱は補助演出として扱ってください。