# SoleMuseum Specs

## 概要

このディレクトリは、SoleMuseum MVPの仕様書を管理する。

SoleMuseumは、スニーカーを収蔵・記録・展示するデジタルミュージアムである。

---

# 基本方針

- MVP First
- Flutter / Dart
- Material 3
- Riverpod
- SQLite / Drift
- Offline First
- Dark Theme First

---

# 仕様書一覧

## MVP

```text
MVP_SPEC.md
```

MVPで実装する機能範囲を定義する。

---

## Screens

```text
HOME_SCREEN_SPEC.md
COLLECTION_SCREEN_SPEC.md
SHOE_DETAIL_SCREEN_SPEC.md
SHOE_FORM_SCREEN_SPEC.md
SETTINGS_SCREEN_SPEC.md
```

各画面の構成、表示項目、操作を定義する。

---

## Data

```text
DATABASE_SPEC.md
```

ローカルデータベース仕様を定義する。

---

## Navigation

```text
NAVIGATION_SPEC.md
```

画面遷移とルーティングを定義する。

---

## State Management

```text
STATE_MANAGEMENT_SPEC.md
```

Riverpodによる状態管理方針を定義する。

---

## Project Structure

```text
PROJECT_STRUCTURE_SPEC.md
```

Flutterプロジェクトのフォルダ構成を定義する。

---

## UI

```text
UI_COMPONENT_SPEC.md
```

共通UIコンポーネント、色、余白、タイポグラフィを定義する。

---

## Implementation

```text
IMPLEMENTATION_RULES.md
```

実装時に守るルールを定義する。

---

## Roadmap

```text
ROADMAP.md
```

開発スプリントと今後の拡張予定を定義する。

---

## Release

```text
RELEASE_CHECKLIST.md
```

v1.0.0リリース前の確認項目を定義する。

---

# 優先順位

実装時は以下の順に参照する。

```text
1. docs/DESIGN_SYSTEM.md
2. specs/MVP_SPEC.md
3. specs/IMPLEMENTATION_RULES.md
4. specs/PROJECT_STRUCTURE_SPEC.md
5. 各画面仕様書
```

---

# 禁止事項

MVPでは以下を実装しない。

- ログイン
- クラウド同期
- Firebase
- AI鑑定
- 相場取得
- SNS共有
- 売買機能

---

# Definition of Done

MVP完成条件

- スニーカー登録
- 一覧表示
- 詳細表示
- 編集
- 削除
- ローカル保存
- 仕様書準拠
- クラッシュなし

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