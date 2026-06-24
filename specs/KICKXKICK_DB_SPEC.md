# Kick×Kick Database Specification v1.1

## 1. 目的

この仕様書は、Kick×Kick のローカルDB設計方針を定義する。

Kick×Kickはサーバー前提ではなく、端末内保存を基本とする。

対象:

- スニーカー情報
- ブランドマスター
- モデルマスター
- 写真
- Collection
- Sticker Board
- ステッカー
- TOP5
- 着用履歴
- ゴミ箱
- 設定
- バックアップ対象データ

## 2. 基本方針

- ローカルDBを主とする
- 画像本体はファイル保存を基本とする
- DBには画像パスとメタ情報を保存する
- 論理削除を使う
- ゴミ箱保持期間は30日
- Free制限判定ではゴミ箱内データをカウントしない
- ブランド・モデルはマスター候補を持つ
- 候補にないブランド・モデルは自由入力として保存できる

参照仕様:

- `specs/KICKXKICK_BRAND_MODEL_CATALOG.md`

## 3. 想定テーブル一覧

```text
brands
brand_aliases
sneaker_models
model_aliases
sneakers
sneaker_photos
box_photos
wear_histories
collections
collection_items
sticker_boards
stickers
sticker_board_items
top5_items
app_settings
trash_records
```

## 4. brands

ブランドマスター。

### 主な項目

```text
id
display_name
display_name_ja
category
is_default
sort_order
created_at
updated_at
```

### 例

```text
Nike / ナイキ
Air Jordan / エアジョーダン
adidas / アディダス
New Balance / ニューバランス
ASICS / アシックス
Other / その他
```

### ルール

- アプリ初期データとして主要ブランドを持つ
- ブランドロゴは持たない
- 表示はテキストのみ
- Otherを必ず持つ
- ユーザー追加ブランドは将来的に `is_default = false` として扱う

## 5. brand_aliases

ブランド表記ゆれ吸収用。

### 主な項目

```text
id
brand_id
alias
created_at
```

### 例

```text
Nike
NIKE
nike
ナイキ
```

### ルール

- 検索・候補表示・将来の重複統合に使う
- MVPでは未実装でもよい
- データ品質改善用の将来テーブルとして定義する

## 6. sneaker_models

モデルマスター。

### 主な項目

```text
id
brand_id
series_name
display_name
display_name_ja
is_default
sort_order
created_at
updated_at
```

### 例

```text
Nike / Dunk / Dunk Low
Nike / Air Max / Air Max 95
Air Jordan / Air Jordan / Air Jordan 1 High
New Balance / 990 Series / 990v6
ASICS / GEL / GEL-Kayano 14
```

### ルール

- ブランドに紐づく
- シリーズ名は任意
- モデルロゴは持たない
- MVPではモデルマスター未実装でもよい
- 将来的にはブランド選択後にモデル候補を表示する

## 7. model_aliases

モデル表記ゆれ吸収用。

### 主な項目

```text
id
model_id
alias
created_at
```

### 例

```text
Air Force 1
AF1
エアフォース1
エアフォースワン
```

### ルール

- 検索・候補表示・将来の重複統合に使う
- MVPでは未実装でもよい
- データ品質改善用の将来テーブルとして定義する

## 8. sneakers

スニーカー本体情報。

### 主な項目

```text
id
brand_id
model_id
custom_brand_name
custom_model_name
size
size_unit
colors
purchase_date_value
purchase_date_precision
purchase_price
purchase_source
display_title
sticker_text
status
memo
created_at
updated_at
deleted_at
```

### 必須

- id
- brand_id または custom_brand_name
- model_id または custom_model_name
- created_at
- updated_at

### ブランド・モデル保存ルール

候補から選んだ場合:

```text
brand_id = brands.id
model_id = sneaker_models.id
custom_brand_name = null
custom_model_name = null
```

候補にないブランドの場合:

```text
brand_id = Other または null
custom_brand_name = ユーザー入力値
```

候補にないモデルの場合:

```text
model_id = null
custom_model_name = ユーザー入力値
```

MVP実装では、既存実装に合わせて以下でも可。

```text
brand_id
model_name
```

ただし将来的には `model_id` と `custom_model_name` に分離する。

### status

```text
new
worn
parted
```

初回着用登録で `new` から `worn` へ自動変更する。

### purchase_date_precision

```text
full_date
year_month
year_only
unknown
```

正確な購入日を覚えていなくても登録可能にする。

### colors

複数色を保持する。

MVPでは文字列配列または区切り文字保存でも可。
将来的には正規化を検討する。

## 9. sneaker_photos

靴写真。

### 主な項目

```text
id
sneaker_id
category
file_path
created_at
updated_at
```

### category

```text
side
front
back
top
sole
worn
```

### ルール

- 各カテゴリ1枚
- 同カテゴリ登録時は置換確認
- 最初の写真は `side` 扱い

### ステッカー生成優先順

1. side
2. front
3. top
4. first photo

## 10. box_photos

箱写真。

### 主な項目

```text
id
sneaker_id
category
file_path
created_at
updated_at
```

### category

```text
angle_front
front
label
top
```

### ルール

- 各カテゴリ1枚
- 同カテゴリ登録時は置換確認
- 箱は靴の補助演出

### 箱ステッカー生成優先順

1. angle_front
2. front
3. first photo

## 11. wear_histories

着用履歴。

### 主な項目

```text
id
sneaker_id
worn_date
created_at
```

### ルール

- 日付のみ保存
- 写真、コメント、天気、場所は持たない
- 着用回数は履歴数から計算する
- 履歴削除で回数減算する

## 12. collections

Collection棚。

### 主な項目

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

### ルール

- Freeは1棚
- Premiumは無制限
- 空棚は自動削除しない
- 最後に見ていた棚IDを settings に保持する

### zoom_level

```text
2
3
4
5
```

2〜5足表示。

## 13. collection_items

棚に配置されたスニーカー。

### 主な項目

```text
id
collection_id
sneaker_id
slot_index
created_at
updated_at
```

### ルール

- 同一スニーカーを複数棚へ配置可能
- Collection内は自由配置ではなくスロット吸着
- 箱はスロットを消費しない
- 箱表示は collection.show_boxes で制御する

## 14. sticker_boards

Sticker Board本体。

### 主な項目

```text
id
name
canvas_type
created_at
updated_at
deleted_at
```

### ルール

- Freeは1枚
- Premiumは無制限
- 最後に見ていたSticker Board IDを settings に保持する

### canvas_type

MVPでは未確定。
候補:

```text
square
portrait
landscape
```

## 15. stickers

生成済みステッカー素材。

### 主な項目

```text
id
sneaker_id
source_type
style
file_path
text
created_at
updated_at
deleted_at
```

### source_type

```text
shoe
box
text
default
```

### style

MVP:

```text
normal
```

将来候補:

```text
chibi
cartoon
pixel
outline
hologram
```

### ルール

- Freeは1足につき1ステッカー
- Premiumは複数ステッカー可

## 16. sticker_board_items

Sticker Board上に配置されたステッカー。

### 主な項目

```text
id
board_id
sticker_id
x
y
scale
rotation
z_index
is_locked
created_at
updated_at
```

### ルール

- 自由配置
- 回転可能
- 拡大縮小可能
- 重なり順変更可能
- 固定 / 固定解除可能

### scale制限

Free:

```text
0.75 - 1.50
```

Premium:

```text
0.50 - 2.50
```

## 17. top5_items

TOP5登録情報。

### 主な項目

```text
id
sneaker_id
rank
created_at
updated_at
```

### ルール

- 最大5足
- お気に入り機能は廃止してTOP5へ統一
- 6足目選択時は入れ替え対象を選ぶ
- rankは1〜5

## 18. app_settings

アプリ設定。

### 主な項目

```text
id
last_collection_id
last_sticker_board_id
show_parted_in_collection
has_seen_collection_zoom_guide
has_completed_onboarding
is_premium
created_at
updated_at
```

### ルール

- 最後に見ていた棚を保持
- 最後に見ていたSticker Boardを保持
- 初回案内表示状態を保持
- オンボーディング完了状態を保持

## 19. trash_records

ゴミ箱管理。

### 主な項目

```text
id
target_type
target_id
deleted_at
expire_at
```

### target_type

```text
sneaker
collection
sticker_board
sticker
```

### ルール

- 削除後30日保持
- 30日後に完全削除
- スニーカー削除時は関連データも復元対象として扱う
- ゴミ箱内はFree制限にカウントしない

## 20. バックアップ対象

バックアップ対象:

- brands
- brand_aliases
- sneaker_models
- model_aliases
- sneakers
- sneaker_photos
- box_photos
- wear_histories
- collections
- collection_items
- sticker_boards
- stickers
- sticker_board_items
- top5_items
- app_settings
- trash_records
- 画像ファイル

## 21. MVP実装優先順位

### Sprint1

- sneakers
- brands
- sneaker_photos
- wear_histories
- top5_items
- app_settings

### Sprint2

- collections
- collection_items
- box_photos

### Sprint3

- stickers
- sticker_boards
- sticker_board_items

### Sprint4

- trash_records
- backup / restore

### Sprint5以降

- sneaker_models
- brand_aliases
- model_aliases

## 22. 未確定事項

以下は実装前に再確認する。

- Sticker Board のキャンバスサイズ
- Collection の最大スロット数
- 画像圧縮方針
- 復元時の重複データ処理
- colors の保存形式
- sneaker_models の初期投入件数
- alias統合UIの有無

## 23. 最重要ルール

Collectionは整列展示。
Stickerは自由配置。

靴が主役。
箱は補助演出。

ブランド・モデルは体験を支えるデータ資産。

データ構造もこの思想を崩さない。
