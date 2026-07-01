# Kick×Kick User Stories

## Purpose

This document defines how collectors interact with Kick×Kick.

Features should be implemented only when they support a user story.

---

## User Profile

Primary User

スニーカーコレクター

Characteristics:

- 複数のスニーカーを所有している
- コレクションを美しく飾りたい
- スニーカーをステッカー化して自由に遊びたい
- 作ったステッカーをLINEスタンプや壁紙など、アプリ外でも使いたい

---

## Story 001

Register New Sneakers

As a collector,

I want to register a newly acquired sneaker,

so that I can manage its information.

Success

- ブランド保存
- モデル保存
- 購入情報保存
- メモ保存

---

## Story 002

Create a Sticker

As a collector,

I want to turn my sneaker photo into a digital sticker,

so that I can decorate it and play with it freely.

Success

- 自動背景削除
- プレビュー確認・簡易修正（消しゴム/復元/ズーム）
- 透過PNGとして保存

---

## Story 003

Arrange Collection Shelf

As a collector,

I want to browse my sneaker collection on an organized shelf,

so that I can enjoy viewing it like a museum display.

Success

- スロットに靴が吸着配置される
- 棚のテーマ（背景）を変更できる
- 同じスニーカーを複数の棚に配置できる

---

## Story 004

Play with Sticker Board

As a collector,

I want to freely place, rotate, and scale my stickers on a board,

so that my collection feels playful and personal.

Success

- ドラッグ移動・長押し回転・ピンチ拡大縮小
- 固定/解除、重なり順変更、複製、削除
- Undo/Redo（30回）

---

## Story 005

Export PNG for External Use (Premium)

As a collector,

I want to export my sticker as a transparent PNG,

so that I can use it as a LINE sticker, wallpaper, or in other apps like Canva or Notion.

Success

- 512 / 1024 / 2048 サイズで書き出せる
- 透過PNGとして保存される
- アプリ内に自動投稿・SNS連携機能は存在しない（書き出し後の使い方はユーザーに委ねる）

---

## Story 006

Feature Favorite Sneakers (TOP5)

As a collector,

I want to feature my top 5 favorite sneakers,

so that my collection feels curated and personal.

Success

- 最大5足まで登録
- Home上部に大きく表示

---

## Story 007

Track Wear History

As a collector,

I want to record when I wear a sneaker,

so that I can track how often I use it.

Success

- 着用日を記録
- 着用回数が自動計算される

---

## Story 008

View Statistics

As a collector,

I want to see stats about my collection,

so that I understand my collecting habits.

Success

- 登録足数・着用済み数・総購入額などを確認できる
- ブランド別・カラー別の集計が見られる

---

## Story 009

Backup and Restore (Premium)

As a collector,

I want backup and restore functionality,

so that I never lose my collection.

Success

- .kkb形式でエクスポートできる
- インポートで復元できる

---

## Story 010

Use Without Internet

As a collector,

I want Kick×Kick to work offline,

so that my collection is always accessible.

Success

- アカウント登録不要
- インターネット接続不要

---

## Non-Goals

The following are not user stories for v1.0:

- スニーカーの売買
- オークション
- アプリ内SNS投稿・自動シェア機能
- インフルエンサー向け機能
- マーケットプレイス機能

---

## Product Definition

Kick×Kick is successful when a collector can:

1. Collect（集める）
2. Create（ステッカー化する）
3. Exhibit（飾る）

their sneaker collection in a playful, personal way.

Every feature should support one or more of these goals.
