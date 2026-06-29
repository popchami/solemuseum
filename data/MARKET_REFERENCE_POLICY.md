# Kick×Kick Market Reference Policy

## Purpose

Kick×Kickのモデルデータは、日本ユーザーが実際に探すモデルを登録できることを重視する。

国内大手販売サイトを、完成形に近い国内流通リファレンスとして扱い、Kick×Kickのデータベースを継続的に育成する。

---

## Core Rule

国内大手販売サイトに掲載されているモデルは、Kick×Kickの登録候補にする。

新作モデルが増えた場合は、Kick×Kickでも追加候補として扱う。

---

## Update Flow

```text
1. 国内流通リファレンスでブランド・モデル候補を確認
2. 既存 data/*.json と比較
3. 未登録モデルを抽出
4. ブランド公式サイトまたは信頼できる公式情報で正式名称を確認
5. models.json に追加
6. aliases.json に検索用Aliasを追加
7. search_keywords.json に必要な検索語を追加
8. app/assets/data/*.json に同期
9. data/CHANGELOG.md に監査ログを残す
10. specs/MODEL_MASTER_COVERAGE.md / specs/KICKXKICK_TASK_BOARD.md を更新
```

---

## Tier Policy

```text
Tier S: MVP PASS後も差分監査を継続
Tier A: MVP PASS後も差分監査を継続
Tier B: 国内流通ブランドを中心に拡張
Tier C: 国内流通が確認できるブランド・モデルを段階追加
```

---

## Quality Gate

以下は追加しない。

```text
- 色名だけ
- コラボ名だけ
- 商品説明文
- 商品画像
- 在庫情報
- 公式表記が確認できない低確度モデル
- 広すぎるAlias/searchKeywords
```

---

## Final Principle

Kick×Kickのデータ資産は、一度作って終わりではない。

国内流通を基準として見続け、モデルが増えたらKick×Kickにも追従する。
