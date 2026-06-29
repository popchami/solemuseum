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

### Sprint4〜6（Sticker機能）

実装済み:

- 背景除去（BackgroundRemovalService）
- ステッカーアセット管理（stickers テーブル）
- ステッカーボード（sticker_boards / sticker_board_items テーブル）
- ステッカーデザイン（テキスト・フチ・影・配色）
- 切り抜き再編集（CutoutAdjustmentScreen）
- ボードへの貼り付け・複製・削除・最前面・拡縮
- ボードPNG出力・シェア
- ステッカー検索・フィルター（ブランド・状態・カラー）
- 編集モード / 閲覧モード切替
- ボードアイテムテキストオーバーレイ（ON/OFF・内容・サイズ・色・フォント・ドラッグ位置）
- ボード上限（無料10枚 / Premium30枚）

---

## DB

### 現在のバージョン

```text
version = 13
```

### マイグレーション履歴

| version | 内容 |
|---------|------|
| 1       | 初期スキーマ（brands, shoes） |
| 2       | photos テーブル追加 |
| 3       | wear_logs テーブル追加 |
| 4       | shoes.top_order 追加 |
| 5       | shoes.display_title / sticker_text / status 追加 |
| 6       | wear_logs 重複排除・日付インデックス |
| 7       | photos テーブルマイグレーション（photo_type / display_order） |
| 8       | app_settings / stickers / sticker_boards / sticker_board_items テーブル追加 |
| 9       | photos.cutout_path 追加 |
| 10      | stickers にテキスト・フチ・影カラム追加（sticker_text / text_color / inner_border_color / outer_border_color / shadow_enabled） |
| 11      | stickers に preview_path / text_scale / text_x / text_y 追加 |
| 12      | stickers.text_scale / text_y のデフォルト値を更新 |
| 13      | sticker_board_items にテキストオーバーレイ列追加（text_enabled / text_content / text_color / text_size / text_font / text_x / text_y） |

### テーブル一覧

```text
brands
shoes
photos
wear_logs
app_settings
stickers
sticker_boards
sticker_board_items
```

---

## モデル

### StickerAsset（stickers テーブル対応）

```text
id
shoeId
sourcePath        元写真パス
stickerPath       切り抜き済み画像パス
stickerText       ステッカーテキスト（nullable）
textColor         文字色（ARGB int）
innerBorderColor  内フチ色（ARGB int）
outerBorderColor  外フチ色（ARGB int）
shadowEnabled     影ON/OFF
previewPath       プレビュー画像パス（nullable）
textScale         文字サイズ倍率
textX / textY     テキスト位置（0.0〜1.0）
displayPath       表示用パス（previewPath ?? stickerPath）
```

### StickerBoardItem（sticker_board_items テーブル対応）

```text
id
boardId
stickerId
x / y             ボード上の位置（正規化 0.0〜1.0）
scale             拡縮倍率
rotation          回転角（ラジアン）
zIndex
textEnabled       テキスト表示ON/OFF
textContent       テキスト内容
textColor         テキスト色（hex文字列 例: #FFFFFF）
textSize          フォントサイズ（ボード短辺比率 例: 0.025 = 2.5%）
textFont          フォントファミリー（'' / 'serif' / 'monospace'）
textX / textY     テキスト位置（正規化 0.0〜1.0）
```

---

## StickerRepository API

```text
getStickers()
saveSticker(...)
ensureDefaultBoard()
getBoardItems(boardId)
getBoardItemCount(boardId)
addToBoard(boardId, stickerId)
pasteToBoard(boardId, stickerId, x, y)
updateBoardItem(item)
duplicateBoardItem(source)
bringToFront(item)
deleteBoardItem(id)

定数:
  freeBoardItemLimit    = 10
  premiumBoardItemLimit = 30
```

---

## StickerScreen 実装状況

### 画面構成

```text
AppBar
  - ボード共有ボタン
  - メニュー（編集モード切替 / 切り抜き再編集）
  - ステッカー追加ボタン
Body
  - モデル名検索フィールド
  - フィルター（状態 / ブランド / カラー）
  - StickerBoard（ボード本体）
```

### ボード操作

```text
ドラッグ       : ステッカー移動
ピンチ         : 拡縮（0.75〜1.5）
回転ハンドル   : 回転
長押し         : 貼り付け（editModeのみ）
タップ         : 選択（editModeのみ）
長押し+選択    : デザイン編集
```

### ツールバー（選択中ステッカーに追従）

```text
貼り付け / 複製 / 削除 / 拡大 / 縮小 / 最前面
```

### テキストオーバーレイ（sticker_board_items 単位）

```text
タップ         : テキスト選択（オレンジ枠表示）
ドラッグ       : テキスト移動（ボード内にクランプ）
編集パネル     : ステッカーまたはテキスト選択中に表示
  - ON/OFF スイッチ
  - テキスト入力
  - サイズスライダー（ボード短辺比率 1〜6%）
  - カラーチップ 6色
  - フォント選択（デフォルト / セリフ / 等幅）
```

### ステッカーアートワーク（StickerAsset 単位）

```text
外フチ（多重オフセット合成）
内フチ（多重オフセット合成）
影（ImageFilter.blur）
本体画像
テキスト（ドラッグで位置調整可）
```

---

## Shoeモデル

追加済み:

- displayTitle
- stickerText
- status

ステータス値:

```text
new    -> 新品
worn   -> 着用済み
parted -> 手放した
```

---

## お気に入り機能

Kick×Kick仕様に合わせてUIから削除済み。TOP5へ統一。

DB互換のため `isFavorite` カラムは残存。

---

## Repository

構造変更なし。既存の流れを維持:

```text
toMap() → Repository → SQLite → fromMap()
```

---

## 実機動作

Sticker機能追加以降の実機確認は未実施。

未実施:

```text
flutter pub get
flutter analyze
flutter run
```

---

## 最新コミット

```text
e04dddd Add sticker text overlay to board items
14170eb Merge pull request #27 from popchami/codex/work
7f20c43 Record brand registry expansion
```

---

## 注意事項

- DB version 13 対応後の実機マイグレーション確認が必要
- Premium判定は `app_settings.is_premium = 'true'` で行うが、課金導線は未実装
- ステッカーテキスト（StickerAsset 側）とボードアイテムテキスト（StickerBoardItem 側）の2系統が存在する
  - StickerAsset.stickerText → ステッカーデザイン時に設定、アートワークに組み込まれる
  - StickerBoardItem.textContent → ボード配置後にオーバーレイとして追加・移動できる

---

## 次にやること

優先:

1. `app/` で `flutter pub get` → `flutter analyze` → 実機確認
2. DB version 13 migration の実機確認
3. ステッカー作成・ボード操作の E2E 確認
4. ステッカーテキストオーバーレイの動作確認

その後:

5. Premium課金フロー実装（現在は `is_premium` フラグのみ）
6. MVP Store提出準備

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

## Codex / Claude Codeへの指示

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

DB version 13 migration、ステッカー作成、ボード操作、テキストオーバーレイの順に確認してください。
エラーが出たら、Riverpod / Repository / SQLite構成を壊さず、小さな差分で修正してください。

ブランド・モデルFactory作業には戻らず、Kick×KickのMVPリリースを優先してください。
```
