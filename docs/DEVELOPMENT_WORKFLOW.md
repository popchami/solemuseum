# DEVELOPMENT_WORKFLOW.md

## 概要

SoleMuseum開発時の標準フローを定義する。

GitHub Copilot、Codex、ChatGPTを利用する場合も本フローに従う。

---

# Development Cycle

```text
Issue
↓
Specification
↓
Implementation
↓
Review
↓
Test
↓
Merge
```

---

# Step 1

Issue作成

目的を明確にする。

例

```text
Home画面実装
```

---

# Step 2

仕様確認

参照順

```text
DESIGN_SYSTEM.md

↓

該当SPEC

↓

IMPLEMENTATION_RULES.md
```

---

# Step 3

実装

実装ルール

```text
1ファイル1責務
```

守る。

---

# Step 4

レビュー

確認項目

```text
仕様書準拠
命名規則
クラッシュ有無
```

---

# Step 5

テスト

確認

```text
画面表示
CRUD
遷移
```

---

# Branch Strategy

## main

本番相当

---

## feature

機能開発

例

```text
feature/home-screen
feature/database
feature/collection-screen
```

---

# Commit Message

形式

```text
type: description
```

---

例

```text
feat: add home screen
```

```text
fix: resolve shoe detail crash
```

```text
docs: update home screen spec
```

---

# Commit Types

## feat

機能追加

---

## fix

バグ修正

---

## docs

ドキュメント

---

## refactor

リファクタリング

---

## test

テスト

---

# Pull Request Rules

PR作成時

記載

```text
目的
変更内容
確認項目
```

---

# Done Definition

以下を満たした場合のみ完了。

```text
ビルド成功
Analyzer警告なし
仕様書準拠
レビュー完了
```

---

# MVP Priority

優先順位

```text
動く
↓
分かりやすい
↓
綺麗
↓
速い
```

---

# SoleMuseum Principle

開発時に迷った場合は

```text
収蔵
記録
展示
```

の思想を優先する。