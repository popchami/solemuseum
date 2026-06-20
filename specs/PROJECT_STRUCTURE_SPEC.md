# PROJECT_STRUCTURE_SPEC.md

## 概要

SoleMuseum MVPにおけるFlutterプロジェクト構成を定義する。

本仕様書は実装時のディレクトリ構成の基準とする。

---

# Root Structure

```text
solemuseum/

├─ docs/
├─ specs/
├─ app/
```

---

# Flutter Structure

```text
app/

├─ lib/
├─ assets/
├─ test/
├─ pubspec.yaml
```

---

# lib Structure

```text
lib/

├─ main.dart
│
├─ core/
│
├─ data/
│
├─ domain/
│
├─ presentation/
│
└─ shared/
```

---

# Core

共通機能

```text
core/

├─ constants/
├─ theme/
├─ routing/
└─ database/
```

---

## constants

アプリ定数

```text
app_constants.dart
```

---

## theme

テーマ設定

```text
app_theme.dart
```

---

## routing

ルーティング

```text
app_router.dart
```

---

## database

SQLite / Drift

```text
app_database.dart
```

---

# Data Layer

データアクセス層

```text
data/

├─ models/
├─ repositories/
└─ providers/
```

---

## models

```text
shoe.dart
statistics.dart
```

---

## repositories

```text
shoe_repository.dart
```

---

## providers

```text
shoe_provider.dart
statistics_provider.dart
```

---

# Domain Layer

MVPでは最小構成

```text
domain/
```

将来拡張用

---

# Presentation Layer

画面UI

```text
presentation/

├─ home/
├─ collection/
├─ shoe_detail/
├─ shoe_form/
└─ settings/
```

---

# Home

```text
home/

home_screen.dart
widgets/
```

---

# Collection

```text
collection/

collection_screen.dart
widgets/
```

---

# Shoe Detail

```text
shoe_detail/

shoe_detail_screen.dart
widgets/
```

---

# Shoe Form

```text
shoe_form/

shoe_form_screen.dart
widgets/
```

---

# Settings

```text
settings/

settings_screen.dart
```

---

# Shared

共通Widget

```text
shared/

├─ widgets/
├─ dialogs/
└─ extensions/
```

---

# Assets

```text
assets/

├─ branding/
├─ images/
└─ icons/
```

---

# Branding

ブランド資産

```text
assets/branding/

app_icon.png
splash_logo.png
```

---

# Images

スニーカー画像

```text
assets/images/
```

---

# Icons

独自アイコン

```text
assets/icons/
```

---

# Test

```text
test/

home/
collection/
repository/
```

---

# Naming Rules

## File

snake_case

例

```text
shoe_detail_screen.dart
shoe_repository.dart
```

---

## Class

PascalCase

例

```dart
ShoeDetailScreen
ShoeRepository
```

---

## Variable

camelCase

例

```dart
shoeList
selectedBrand
```

---

# Forbidden

禁止事項

```text
utils.dart
helper.dart
common.dart
```

用途不明ファイルを作らない

---

# DESIGN PRINCIPLE

フォルダ構成は

```text
迷わない
探しやすい
増やしやすい
```

を優先する。

MVPでは過度なレイヤー分割を行わない。