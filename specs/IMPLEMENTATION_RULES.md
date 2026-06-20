# IMPLEMENTATION_RULES.md

## 概要

本仕様書はSoleMuseum MVP実装時の開発ルールを定義する。

Codex、Copilot、ChatGPTを利用する場合も本仕様書を優先する。

---

# 基本方針

## MVP First

最優先

```text
動くこと
```

---

優先しない

```text
過度な最適化
過度な設計
過度な抽象化
```

---

# Technology Stack

## Framework

```text
Flutter
```

---

## Language

```text
Dart
```

---

## State Management

```text
Riverpod
```

---

## Database

```text
SQLite
```

実装

```text
Drift
```

---

# Architecture

採用

```text
UI
↓
Provider
↓
Repository
↓
Database
```

---

禁止

```text
Clean Architecture完全版
過度なUseCase分割
過度なDI
```

---

# File Rules

## 1ファイル1責務

守る

---

許可

```text
shoe_repository.dart
```

---

禁止

```text
shoe_repository_and_provider.dart
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
ShoeRepository
ShoeDetailScreen
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

# UI Rules

## Theme

必ず

```text
AppTheme
```

経由

---

禁止

```dart
Colors.red
Colors.blue
```

直書き

---

許可

```dart
AppColors.galleryGold
```

---

# Color Rules

## Background

```text
#111111
```

---

## Surface

```text
#1E1E1E
```

---

## Accent

```text
#C8A96B
```

---

# Provider Rules

## AsyncValue

使用する

---

禁止

```dart
bool isLoading
```

大量管理

---

推奨

```dart
AsyncValue<List<Shoe>>
```

---

# Database Rules

## Migration

必須

---

Version管理

```text
schemaVersion
```

使用

---

# Error Handling

## Repository

try-catch必須

---

## UI

表示

```text
データの取得に失敗しました
```

---

# Logging

MVP

許可

```dart
debugPrint()
```

---

本番想定

未対応

---

# Image Rules

## 保存

ローカルのみ

---

クラウド保存

禁止

---

# Feature Rules

MVPで実装しない

```text
ログイン
会員機能
クラウド同期
価格取得
AI鑑定
SNS共有
売買
```

---

# Performance Rules

最適化より可読性

---

優先順位

```text
動く
↓
分かりやすい
↓
速い
```

---

# Code Review Rules

レビュー時確認

```text
仕様書準拠か
クラッシュしないか
命名規則違反がないか
不要な抽象化がないか
```

---

# Forbidden

禁止事項

```text
helper.dart
utils.dart
common.dart
```

用途不明ファイル

---

禁止

```text
TODO放置
未使用コード
コメントアウト放置
```

---

# Definition of Done

実装完了条件

```text
ビルド成功
警告なし
画面表示成功
CRUD成功
仕様書準拠
```

---

# SoleMuseum Principle

SoleMuseumは

```text
スニーカー管理アプリ
```

ではない。

```text
スニーカーを収蔵・記録・展示する
デジタルミュージアム
```

である。

すべての実装はこの思想を優先する。