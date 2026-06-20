# UI_COMPONENT_SPEC.md

## 概要

SoleMuseum MVPで使用する共通UIコンポーネント仕様。

全画面で統一されたデザインを維持するための基準とする。

---

# Design Philosophy

SoleMuseumは

```text
Museum
Collection
Exhibit
```

をテーマとする。

UIは派手さではなく

```text
高級感
静寂感
展示感
```

を重視する。

---

# Color System

## Museum Black

背景色

```text
#111111
```

---

## Surface

カード背景

```text
#1E1E1E
```

---

## Gallery Gold

アクセントカラー

```text
#C8A96B
```

---

## Primary Text

```text
#FFFFFF
```

---

## Secondary Text

```text
#B0B0B0
```

---

# Border Radius

## Small

```text
8dp
```

---

## Medium

```text
12dp
```

---

## Large

```text
24dp
```

---

# Elevation

MVPでは最小限。

## Card

```text
Elevation 0〜2
```

---

# Typography

## App Title

使用箇所

```text
SoleMuseum
```

サイズ

```text
28sp
```

Weight

```text
Bold
```

---

## Section Title

使用箇所

```text
注目の展示
コレクション統計
最近のコレクション
```

サイズ

```text
20sp
```

Weight

```text
SemiBold
```

---

## Card Title

使用箇所

```text
Air Jordan 1
```

サイズ

```text
16sp
```

Weight

```text
Medium
```

---

## Body

サイズ

```text
14sp
```

Weight

```text
Regular
```

---

## Caption

サイズ

```text
12sp
```

Weight

```text
Regular
```

---

# Spacing

## Screen Padding

左右

```text
16dp
```

---

## Section Gap

上下

```text
24dp
```

---

## Component Gap

```text
12dp
```

---

# Common Components

# Primary Button

使用例

```text
保存
追加
```

---

## Height

```text
56dp
```

---

## Radius

```text
16dp
```

---

## Color

```text
Gallery Gold
```

---

# Secondary Button

使用例

```text
キャンセル
```

---

## Style

Outline

---

# Shoe Card

## 用途

Collection一覧

---

## 構成

```text
画像

モデル名

ブランド名

収蔵番号
```

---

## Radius

```text
16dp
```

---

# Statistics Card

## 用途

Home画面

---

## 構成

```text
数値

ラベル
```

---

## 例

```text
128

収蔵数
```

---

# Section Header

## 構成

```text
タイトル

すべて見る
```

---

## 例

```text
最近のコレクション
        すべて見る
```

---

# Empty State

## アイコン

シンプルな展示ケース

---

## タイトル

```text
あなたのミュージアムは空です
```

---

## サブタイトル

```text
最初の1足を登録しましょう
```

---

# Loading

## Widget

```text
CircularProgressIndicator
```

---

## Color

```text
Gallery Gold
```

---

# Error State

## Message

```text
データの取得に失敗しました
```

---

# Image Rules

## Card

```text
1:1
```

---

## Hero

```text
4:3
```

---

## Fit

```text
BoxFit.cover
```

---

# Animation

MVPでは最小限。

許可

```text
Fade
Slide
```

---

禁止

```text
過度なアニメーション
派手なエフェクト
```

---

# DESIGN PRINCIPLE

すべてのUIは

```text
静か
高級
展示的
```

であること。

ECサイトではなく

ミュージアムであることを優先する。