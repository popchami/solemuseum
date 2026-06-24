# Kick×Kick Design System v1.0

## 1. 目的

この仕様書は、Kick×Kick のデザイン基準を定義する。

対象:

- Canva
- Figma
- Flutter実装
- Codex / Copilot実装指示
- ストア画像

すべての見た目を同じ基準で揃える。

## 2. デザインコンセプト

Kick×Kickは、スニーカーをデジタルステッカー化して飾るアプリ。

デザインの主役は靴とステッカー。
UIはそれを邪魔しない。

基本思想:

- Collection = 博物館
- Sticker = スクラップブック
- 靴が主役
- 箱は補助演出
- Orangeはアクセント

## 3. カラー

### 基本比率

- 90% モノクロ
- 10% オレンジ

### Primary Colors

```text
Black  : #111111
White  : #FFFFFF
Gray   : #F3F3F3
Orange : #FF7A1A
```

### Neutral Colors

```text
Dark Gray   : #2A2A2A
Medium Gray : #8A8A8A
Light Gray  : #EAEAEA
Off White   : #FAFAFA
```

### 注意

- 背景全面オレンジは使わない
- オレンジはボタン、強調、ステッカーフチに使う
- 情報量が多い画面ではモノクロを優先する

## 4. タイポグラフィ

### UI Font

- Plus Jakarta Sans
- 日本語は Noto Sans JP

### Sticker Font Free

- Zen Maru Gothic
- M PLUS Rounded 1c
- Fredoka

### Sticker Font Premium

- Marker
- Street
- Comic
- Retro
- Pixel

### 文字サイズ目安

```text
Display : 28-32
Title   : 22-24
Section : 18-20
Body    : 14-16
Caption : 11-13
```

### 方針

- UI文字は読みやすさ優先
- ステッカー文字は遊び心優先
- Collectionでは落ち着いた文字
- Stickerではカジュアルな文字

## 5. 余白ルール

基本単位は8px。

```text
XS : 4
S  : 8
M  : 16
L  : 24
XL : 32
```

画面左右余白:

```text
16px
```

カード内余白:

```text
12px - 16px
```

## 6. 角丸

```text
Small Card : 12
Main Card  : 16
Large Card : 24
Button     : 999 / pill
Sticker    : content dependent
```

## 7. カードデザイン

### 通常カード

- 背景: White または Off White
- 角丸: 16
- 枠線: Light Gray
- 影: 弱め

### 強調カード

- 背景: Black
- 文字: White
- アクセント: Orange

### Sneaker Card

表示要素:

- メイン写真
- ブランド
- モデル
- Display Title
- 着用回数
- 状態

写真が主役。
文字は控えめ。

## 8. ボタン

### Primary Button

- 背景: Orange
- 文字: White
- 角丸: Pill

### Secondary Button

- 背景: White
- 枠線: Light Gray
- 文字: Black

### Danger Button

- 背景: White
- 文字: Red系
- 枠線: Light Gray

## 9. FAB

中央FABはスニーカー追加。

- 背景: Orange
- アイコン: Plus
- 形状: Circle
- 目立つが画面を支配しない

## 10. Bottom Navigation

項目:

- Home
- Collection
- ＋
- Sticker
- Settings

選択中:

- Icon / Label をOrange

未選択:

- Medium Gray

## 11. Homeデザイン

構成:

1. TOP5
2. Collection
3. Sticker
4. 最近追加したスニーカー
5. Statistics

### TOP5

Home上部の約1/3を使う。

- 1位を大きく表示
- 2〜5位を小さく表示
- 👑アイコン
- 黒背景＋オレンジアクセントも候補

Kick×Kickの顔になるエリア。

## 12. Collectionデザイン

Collection = 博物館。

方針:

- 整列
- 余白あり
- 靴が美しく見える
- 背景テーマは展示棚として機能する

### 棚UI

- 靴はスロットに吸着
- 箱は装飾
- Display Titleは小さく表示
- 乱雑にしない

### 背景テーマ

Free:

- Classic Wood
- Dark Wood

Premium:

- Concrete
- Graffiti
- Gallery
- Sneaker Shop
- Industrial
- Luxury Closet
- Neon

## 13. Stickerデザイン

Sticker = 机 / スクラップブック。

方針:

- 自由
- 乱雑
- 遊び
- 重ね貼り
- ステッカー感

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

## 14. Empty State

空状態は冷たくしない。

例:

```text
まだスニーカーがありません
最初の一足を登録しましょう
```

```text
まだステッカーがありません
写真からステッカーを作ってみましょう
```

Primary Buttonを1つだけ置く。

## 15. Premium表示

Premium誘導は強くしすぎない。

### 強い誘導

- 6足目登録
- 2枚目ステッカー作成

### 軽い案内

- Premiumテーマ
- Premiumフォント
- PNG出力
- バックアップ

表示方針:

- 圧迫しない
- 煽らない
- 機能拡張として見せる

## 16. アイコン方針

- 線は太すぎない
- モノクロ基調
- 重要操作のみOrange
- ブランドロゴは使わない
- 特定スニーカーブランドに見える形を避ける

## 17. アニメーション

控えめに使う。

推奨:

- カード遷移
- ステッカー配置
- TOP5表示
- FABタップ

避ける:

- 派手すぎる演出
- 操作を邪魔する演出

## 18. ダークモード

基本は黒・白・グレー設計のため対応しやすくする。

初期MVPではライト基調を優先してよい。

## 19. アプリアイコン方向性

- 靴箱
- オリジナルスニーカー
- K×Kロゴ
- 白フチ
- 太いオレンジ外フチ
- 特定ブランドに見えない靴

## 20. 最重要ルール

UIは靴とステッカーを邪魔しない。

Collectionは整列展示。
Stickerは自由配置。

Orangeは主役ではなくアクセント。