# Kick×Kick Registration Flow Spec v1.0

## Purpose

この仕様書は、Kick×Kick のスニーカー登録フローを定義する。

目的は、ブランド・モデル検索の仕様を実際の登録体験へ落とし込み、ユーザーが迷わず登録できる状態を作ることである。

---

## User Goal

ユーザーは以下を素早く登録したい。

```text
ブランド
モデル
サイズ
購入日
メモ
写真
```

MVPでは、候補にないブランド・モデルでも自由入力で登録できることを必須とする。

---

## Basic Flow

登録フローは以下。

```text
1. 登録開始
2. ブランド入力
3. ブランド候補選択または自由入力
4. モデル入力
5. モデル候補選択または自由入力
6. サイズ入力
7. 購入日入力
8. メモ入力
9. 写真追加
10. 確認
11. 保存
```

MVPでは確認画面は省略してもよいが、保存前の入力内容は画面上で確認できること。

---

## Brand Input

ブランド入力では `BRAND_MASTER.md` と検索仕様を使う。

検索対象:

```text
brandName
brand alias
```

例:

```text
入力: NB
候補: New Balance

入力: ニューバランス
候補: New Balance
```

---

## Brand Candidate Selection

ブランド候補を選択した場合、保存値は正式ブランド名にする。

例:

```text
入力: NB
選択: New Balance
保存: New Balance
```

---

## Brand Free Input

ブランドが見つからない場合、自由入力を許可する。

表示例:

```text
候補が見つかりません
このブランド名で登録できます
```

保存時は source を `user_input` とする。

---

## Model Input

モデル入力では、選択済みブランドを優先して検索する。

例:

```text
ブランド: Nike
入力: 95
候補: Air Max 95
```

```text
ブランド: New Balance
入力: 990
候補: 990v6 / 990v5 / 990v4 / 990v3 / 990v2 / 990v1
```

---

## Model Candidate Selection

モデル候補を選択した場合、保存値は正式モデル名にする。

例:

```text
入力: AJ1
選択: Air Jordan 1 High OG
保存: Air Jordan 1 High OG
```

Aliasは保存しない。

---

## Model Free Input

モデル候補が見つからない場合も、自由入力を許可する。

表示例:

```text
候補が見つかりません
このモデル名で登録できます
```

保存時は source を `user_input` とする。

---

## Brand and Model Dependency

モデル検索は、ブランド選択済みの場合はそのブランド内を優先する。

例:

```text
ブランド: ASICS
入力: 1130
候補: GEL-1130
```

ブランド未選択の場合は、全ブランド横断で検索する。

---

## Suggested Order

入力順は以下を推奨する。

```text
ブランド
モデル
写真
サイズ
購入日
メモ
```

理由:

- ブランドとモデルが登録体験の中心
- 写真追加はユーザーの満足度が高い
- サイズ・購入日・メモは後から編集できる

---

## Required Fields

MVP必須項目:

```text
ブランド
モデル
```

任意項目:

```text
サイズ
購入日
メモ
写真
```

ただし、UX上は写真追加を強く促してよい。

---

## Save Data

保存時の最小データ構造:

```json
{
  "brandName": "New Balance",
  "modelName": "990v6",
  "brandSource": "master",
  "modelSource": "master",
  "size": "27.5",
  "purchaseDate": "2026-06-25",
  "memo": "初回登録メモ"
}
```

自由入力の場合:

```json
{
  "brandName": "User Brand",
  "modelName": "User Model",
  "brandSource": "user_input",
  "modelSource": "user_input"
}
```

---

## Search Result UX

検索候補には以下を表示する。

```text
ブランド名
モデル名
カテゴリ
```

例:

```text
Nike Air Max 95
Lifestyle / Air Max
```

MVPではカテゴリ表示は省略してもよい。

---

## No Result UX

候補がない場合は、エラーにしない。

悪い例:

```text
該当なし
登録できません
```

良い例:

```text
候補が見つかりません
自由入力で登録できます
```

---

## Edit Flow

登録後は以下を編集できること。

```text
ブランド
モデル
サイズ
購入日
メモ
写真
```

ブランド・モデルを変更しても、既存の写真やメモは消さない。

---

## User Satisfaction Rule

ユーザー満足度の基準は以下。

```text
1. 主要ブランドが候補に出る
2. 略称や日本語でも検索できる
3. 候補がなくても自由入力できる
4. 登録後に編集できる
5. 写真を残せる
```

候補の完全網羅より、登録を止めないことを優先する。

---

## MVP Test Cases

最低限、以下を確認する。

```text
NB -> New Balance
AJ1 -> Air Jordan 1
AF1 -> Nike Air Force 1
AM95 -> Nike Air Max 95
GT2160 -> ASICS GT-2160
XT6 -> Salomon XT-6
エアマックス -> Nike Air Max Series
カヤノ -> ASICS GEL-Kayano Series
候補なし -> 自由入力登録
```

---

## Related Specs

```text
specs/BRAND_MASTER.md
specs/MODEL_MASTER/README.md
specs/SEARCH_SPEC.md
specs/SEARCH_DATA_SPEC.md
specs/ALIAS_MASTER_SPEC.md
```
