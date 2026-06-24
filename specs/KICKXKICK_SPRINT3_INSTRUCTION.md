# Kick×Kick Sprint3 Implementation Instruction

## 1. 目的

この指示書は、Codex / Copilot に渡して Kick×Kick Sprint3 を実装するためのものです。

Sprint3では、Kick×Kickの中心価値であるSticker機能を実装します。

Stickerは「机 / スクラップブック」です。
Collectionのような整列展示ではなく、自由に貼って遊ぶ場所です。

最優先は、

- Sticker Boardを作れる
- 最後に見ていたSticker Boardを開ける
- スニーカー写真からNormalステッカーを作れる
- ステッカーをBoardに配置できる
- 移動・回転・拡大縮小・重ね順変更ができる
- 固定 / 解除できる
- 複製できる
- 削除できる
- Undo / Redoできる

ことです。

## 2. 前提

Sprint1とSprint2が完了している前提です。

既存機能:

- スニーカー登録
- スニーカー詳細
- TOP5
- 着用履歴
- Collection棚
- Collectionスロット表示
- 箱表示ON/OFF

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

## 4. Sprint3で作る画面

### 4.1 Sticker Screen

Stickerタブで表示するメイン画面。

起動時:

- 最後に見ていたSticker Boardを表示する
- Board一覧からではなく、前回のBoardを直接開く

### 4.2 Sticker Board

自由配置キャンバス。

できること:

- ドラッグ移動
- 長押し回転
- ピンチ拡大縮小
- 固定 / 解除
- 重なり順変更
- 最前面
- 複製
- 削除
- Undo
- Redo

### 4.3 Board List

Sticker Board一覧画面。

操作:

- Board選択
- Board追加
- Board削除
- Board名編集

### 4.4 Add Sticker

所有ステッカー一覧からBoardへ追加する。

流れ:

```text
Add Sticker
↓
Owned Sticker List
↓
Select Sticker
↓
Place on Board
```

### 4.5 Sticker Generate

スニーカー詳細またはStickerタブから開始できる。

生成フロー:

```text
写真
↓
自動背景削除
↓
プレビュー
↓
必要なら修正
↓
保存
↓
透過PNG化
```

Sprint3ではNormalのみ実装する。

## 5. Sprint3で作るデータモデル

DB仕様は `specs/KICKXKICK_DB_SPEC.md` を参照。

Sprint3対象:

```text
stickers
sticker_boards
sticker_board_items
app_settings
```

### 5.1 Sticker

必要項目:

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

source_type:

```text
shoe
box
text
default
```

style:

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

### 5.2 StickerBoard

必要項目:

```text
id
name
canvas_type
created_at
updated_at
deleted_at
```

canvas_type候補:

```text
square
portrait
landscape
```

MVPでは `square` を標準にしてよい。

### 5.3 StickerBoardItem

必要項目:

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

### 5.4 AppSettings 追加項目

```text
last_sticker_board_id
```

## 6. ステッカー操作仕様

### 短押し

固定 / 固定解除

### 長押し

指を動かさず自動回転

### ピンチ

拡大縮小

### ドラッグ

移動

### 複製

同じステッカーを少しずらして配置する。

### 削除

- ゴミ箱へドラッグ
- 編集メニューから削除

### Undo / Redo

30回。

## 7. ステッカーサイズ制限

Free:

```text
75%〜150%
```

Premium:

```text
50%〜250%
```

Sprint3ではPremium購入処理は未実装でもよい。
Free上限を基本として実装し、Premium判定の差し替え余地を残す。

## 8. ステッカーデザイン

### 靴ステッカー

```text
靴切り抜き
↓
白フチ
↓
太めのオレンジ外フチ
```

### テキストステッカー

```text
オレンジ文字
↓
白フチ
↓
太めのオレンジ外フチ
```

Sprint3では見た目の完全再現より、Normalステッカー生成とBoard配置を優先する。

## 9. 簡易修正

背景削除後の修正機能:

- 消しゴム
- 復元
- ズーム
- Undo
- Redo

Photoshop的な高度編集はしない。

## 10. Free制限

Free:

- Sticker Board 1枚
- 1足につき1ステッカー

2枚目のBoard作成時:

```text
Premium Prompt
```

同じスニーカーで2つ目のステッカーを作る時:

```text
Premium Prompt
```

Sprint3では購入処理は不要。
案内表示まででよい。

## 11. 画面遷移

```text
Sticker Tab
↓
Last Viewed Sticker Board
```

```text
Sticker Board
├─ Board List
├─ Add Sticker
├─ Edit Item
├─ Undo
├─ Redo
└─ Export PNG（Sprint4）
```

```text
Sneaker Detail
↓
Generate Sticker
↓
Source Photo Select
↓
Auto Background Remove
↓
Preview
├─ Save
└─ Edit Mask
```

```text
Save
↓
Sticker Board Select
↓
Place on Board
```

## 12. Provider / Repository

追加推奨Provider:

```text
stickerProvider
stickerListProvider
stickerBoardProvider
stickerBoardItemProvider
stickerEditProvider
stickerHistoryProvider
```

追加推奨Repository:

```text
stickerRepository
stickerBoardRepository
stickerBoardItemRepository
```

背景削除処理はServiceとして分離する。

推奨Service:

```text
backgroundRemovalService
stickerRenderService
```

## 13. Sprint3で実装しないこと

以下は実装しない。

- Chibi
- Cartoon
- Pixel
- Hologram
- 高度な画像編集
- LINEスタンプ正式連携
- 本番Premium購入処理
- バックアップ
- 復元
- ストア提出素材

## 14. 完了条件

Sprint3完了条件:

- StickerタブでBoardを表示できる
- 最後に見ていたBoardを復元できる
- Board一覧を開ける
- Boardを追加できる
- Boardを削除できる
- 写真からNormalステッカーを生成できる
- 生成したステッカーをBoardに配置できる
- ステッカーをドラッグ移動できる
- 長押しで回転できる
- ピンチで拡大縮小できる
- 固定 / 解除できる
- 重なり順を変更できる
- 複製できる
- 削除できる
- Undo / Redoが30回まで使える
- Free制限の案内が出る

## 15. 実装後に報告すること

作業後、以下を報告してください。

- 作成 / 更新したファイル一覧
- 実装した画面
- 実装したProvider
- 実装したRepository
- 実装したService
- DB変更内容
- まだ未実装の項目
- `flutter analyze` の結果
- 実機 / エミュレータ確認結果

## 16. 注意

Stickerはスクラップブックです。

Collectionのように整列させないでください。

Sticker Boardでは、ステッカーを自由に散らして遊べる体験を優先してください。