# Kick×Kick Documentation

## 目的

この `docs/` は、Kick×Kickの開発方針・MVP範囲・リリース条件・リリース後の予定をまとめる場所。

旧プロジェクト名の表記ではなく、Kick×Kickとして読むこと。

---

## 最初に読む文書

Codex / Copilot / ChatGPTで作業を始める場合は、以下の順で読む。

1. `docs/HANDOFF_KICKXKICK_MVP_2026-06-25.md`
2. `docs/HANDOFF_BRAND_MODEL_SEARCH.md`
3. `docs/MVP_RELEASE_CHECKLIST.md`
4. `docs/RELEASE_PLAN.md`
5. `docs/POST_RELEASE.md`

---

## 今やること

MVPリリース前は、以下を優先する。

1. `app/` で `flutter pub get`
2. `flutter analyze`
3. `flutter run`
4. DB migration version5確認
5. 新規登録確認
6. 編集確認
7. 詳細画面確認
8. 写真確認
9. MY TOP5確認
10. 着用履歴確認
11. Collection確認
12. Home確認
13. Sticker最小実装確認

---

## MVP関連文書

| Document | Purpose |
|---|---|
| `HANDOFF_KICKXKICK_MVP_2026-06-25.md` | Kick×Kick本体MVP開発の最新引き継ぎ |
| `HANDOFF_BRAND_MODEL_SEARCH.md` | ブランド・モデル・検索作業の完了引き継ぎ |
| `MVP_RELEASE_CHECKLIST.md` | MVPリリース前の確認チェックリスト |
| `RELEASE_PLAN.md` | Release 1.0の範囲・条件・不可条件 |
| `POST_RELEASE.md` | MVP後に回す機能・ロードマップ |

---

## 開発方針

- Kick×Kickとして進める
- ブランド・モデルFactory作業には戻らない
- MVPリリースを優先する
- Riverpod構成を維持する
- Repository構成を維持する
- SQLite中心で進める
- 小さな差分で修正する
- 各変更後に `flutter analyze` を確認する
- 新機能は `POST_RELEASE.md` に退避する

---

## Release 1.0 に含める主な機能

- スニーカー登録
- スニーカー編集
- スニーカー詳細
- ブランド・モデル検索
- 自由入力ブランド
- 自由入力モデル
- メイン写真
- MY TOP5
- 着用履歴
- Collection
- Home
- Sticker最小実装

---

## Release 1.0 に含めない主な機能

- Premium課金
- Google Driveバックアップ
- クラウド同期
- ログイン
- SNS共有
- AI機能
- 複数写真ギャラリー
- 箱管理
- 高度な統計
- Sticker自由配置
- ブランド・モデルFactory拡張

これらは `docs/POST_RELEASE.md` に回す。

---

## 現在の状態

ブランド・モデル・検索作業はいったん終了。

Kick×Kick本体MVP開発は、実機確認・`flutter analyze`・DB migration確認・主要導線確認のフェーズ。

---

## GitHub Issue

MVP確認の中心Issue:

- Issue #23: Kick×Kick MVP本体開発

---

## 最終判断

リリース判断は以下を見る。

- `docs/MVP_RELEASE_CHECKLIST.md`
- `docs/RELEASE_PLAN.md`

迷った場合は、新機能追加ではなく、起動・analyze・登録導線・実機確認を優先する。
