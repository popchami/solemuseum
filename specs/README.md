# Kick×Kick Specs

## 概要

このディレクトリは、Kick×Kick の仕様書を管理する。

Kick×Kick は、スニーカーを登録し、ステッカー化し、棚やボードに飾って楽しむアプリである。

タグライン:

```text
貼って、飾って、コレクション。
```

---

## 正本ルール

今後の実装判断では、以下のファイルを正本とする。

```text
KICKXKICK_*
```

旧SoleMuseum仕様書が残っていても、実装判断には使わない。

---

## 基本方針

- Flutter / Dart
- Material 3
- Riverpod
- Offline First
- Local DB First
- Collection = 博物館 / 整列展示
- Sticker = スクラップブック / 自由配置

---

## Kick×Kick 仕様書一覧

### Core

```text
KICKXKICK_SPEC.md
KICKXKICK_PRODUCT.md
KICKXKICK_UI_SPEC.md
KICKXKICK_DATA.md
KICKXKICK_DB_SPEC.md
KICKXKICK_ROUTING_SPEC.md
```

### Monetize / Backup

```text
KICKXKICK_MONETIZE.md
KICKXKICK_BACKUP.md
```

### Brand / Design

```text
KICKXKICK_BRAND.md
KICKXKICK_DESIGN_SYSTEM.md
KICKXKICK_ICON_SPEC.md
KICKXKICK_SCREENSHOT_SPEC.md
```

### Sprint

```text
KICKXKICK_SPRINT_PLAN.md
KICKXKICK_SPRINT1_INSTRUCTION.md
KICKXKICK_SPRINT2_INSTRUCTION.md
KICKXKICK_SPRINT3_INSTRUCTION.md
KICKXKICK_SPRINT4_INSTRUCTION.md
```

### Management

```text
KICKXKICK_TASK_BOARD.md
KICKXKICK_MIGRATION_PLAN.md
```

---

## 次に使うファイル

Sprint1実装開始時は以下を使う。

```text
KICKXKICK_SPRINT1_INSTRUCTION.md
```

---

## Legacy Notice

以下のような旧仕様書は、SoleMuseum時代の履歴として残っている場合がある。

```text
MVP_SPEC.md
HOME_SCREEN_SPEC.md
COLLECTION_SCREEN_SPEC.md
SHOE_FORM_SCREEN_SPEC.md
SHOE_DETAIL_SCREEN_SPEC.md
DATABASE_SPEC.md
NAVIGATION_SPEC.md
UI_COMPONENT_SPEC.md
```

これらは参考履歴であり、Kick×Kick実装の正本ではない。
