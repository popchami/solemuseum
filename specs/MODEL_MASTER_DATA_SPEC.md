# Kick×Kick Model Master Data Spec v1.0

## Purpose

この仕様書は、Kick×Kick のモデルマスターを検索・サジェストで使うためのデータ構造を定義する。

検索UX v2.0 では、ブランド選択後にモデル候補をアルファベット順でサジェストする。

そのため、モデルデータはシンプルに保つ。

---

## Related Specs

```text
specs/SEARCH_SPEC.md
specs/SEARCH_DATA_SPEC.md
specs/ALIAS_MASTER_SPEC.md
specs/ALIAS_MASTER.md
specs/REGISTRATION_FLOW_SPEC.md
specs/SEARCH_MVP_TEST_SPEC.md
```

---

## Core Policy

MVPでは以下を採用する。

```text
ブランド選択
↓
モデル入力
↓
モデル名・Alias・searchKeywords の前方一致
↓
アルファベット順で最大5件表示
```

MVPでは以下は使わない。

```text
priority
popular
featured
ranking
market trend
```

理由:

```text
Kick×Kick は売るアプリではなく、登録するアプリだから。
```

ユーザーが1文字ずつ入力して自然に絞り込めることを優先する。

---

## Required Fields

モデルデータに必要な最小項目は以下。

```text
id
brandId
brandName
modelName
aliases
searchKeywords
category
source
```

---

## Field Definition

### id

モデルの一意ID。

形式:

```text
{brand_id}_{model_slug}
```

例:

```text
nike_air_force_1
nike_air_max_95
new_balance_990v6
asics_gt_2160
```

---

### brandId

ブランドID。

小文字スネークケース。

例:

```text
nike
air_jordan
new_balance
asics
onitsuka_tiger
```

---

### brandName

表示用ブランド名。

例:

```text
Nike
Air Jordan
New Balance
ASICS
Onitsuka Tiger
```

---

### modelName

正式モデル名。

検索結果・保存値に使う。

例:

```text
Air Force 1
Air Max 95
990v6
GT-2160
XT-6
Mexico 66
```

---

### aliases

略称・表記ゆれ。

検索補助に使う。

表示・保存には使わない。

例:

```text
AF1
AF-1
AM95
NB550
GT2160
XT6
Mexico66
```

---

### searchKeywords

数字検索や単語検索を補助するキーワード。

モデル名の先頭ではない語でも検索対象にするために使う。

例:

```text
Air Max 95
searchKeywords:
- 95
- Air
- Max
- AirMax95
- エアマックス95
```

```text
GT-2160
searchKeywords:
- 2160
- GT
- GT2160
```

```text
GEL-1130
searchKeywords:
- 1130
- GEL
```

---

### category

大まかなカテゴリ。

MVPでは厳密にしすぎない。

候補:

```text
lifestyle
running
basketball
trail
skateboarding
outdoor
tennis
training
boot
sandal
other
```

---

### source

データの出どころ。

候補:

```text
master
user_input
```

---

## Example: Nike Air Max 95

```json
{
  "id": "nike_air_max_95",
  "brandId": "nike",
  "brandName": "Nike",
  "modelName": "Air Max 95",
  "aliases": [
    "AM95",
    "Airmax95"
  ],
  "searchKeywords": [
    "95",
    "Air",
    "Max",
    "AirMax95",
    "エアマックス95"
  ],
  "category": "lifestyle",
  "source": "master"
}
```

---

## Example: New Balance 990v6

```json
{
  "id": "new_balance_990v6",
  "brandId": "new_balance",
  "brandName": "New Balance",
  "modelName": "990v6",
  "aliases": [
    "NB990",
    "990v6"
  ],
  "searchKeywords": [
    "9",
    "99",
    "990",
    "v6"
  ],
  "category": "lifestyle",
  "source": "master"
}
```

---

## Example: ASICS GT-2160

```json
{
  "id": "asics_gt_2160",
  "brandId": "asics",
  "brandName": "ASICS",
  "modelName": "GT-2160",
  "aliases": [
    "GT2160"
  ],
  "searchKeywords": [
    "2160",
    "GT",
    "GT2160"
  ],
  "category": "lifestyle",
  "source": "master"
}
```

---

## Suggestion Rule

ブランド選択後のモデルサジェストは以下。

```text
1. 選択ブランド内のモデルだけを見る
2. 入力が空なら modelName アルファベット順で最大5件
3. 入力があるなら modelName / aliases / searchKeywords の前方一致を見る
4. 表示は正式 modelName
5. 候補は最大5件
6. 候補がなければ自由入力fallback
```

---

## Number Search Rule

数字入力も文字入力と同じく前方一致で扱う。

検索対象:

```text
modelName
aliases
searchKeywords
```

例:

```text
Nike / 95 -> Air Max 95
New Balance / 990 -> 990v1〜990v6
ASICS / 2160 -> GT-2160
ASICS / 1130 -> GEL-1130
New Balance / 550 -> 550
```

数字だけで見つけたいモデルは必ず searchKeywords に数字を入れる。

---

## Sorting Rule

MVPの並び順は以下。

```text
1. アルファベット順
2. 数字は自然順
3. Alias一致でも表示は正式modelName
```

priority / popular / featured は使わない。

---

## Natural Sort Examples

```text
Air Max 1
Air Max 90
Air Max 95
Air Max 97
```

```text
990v1
990v2
990v3
990v4
990v5
990v6
```

---

## Free Input Rule

候補が見つからない場合も登録を止めない。

自由入力時のデータ:

```json
{
  "brandName": "User Brand",
  "modelName": "User Model",
  "source": "user_input"
}
```

---

## Do Not Add for MVP

MVPでは以下を追加しない。

```text
priority
popular
featured
releaseYear
marketPrice
colorway
collaboration
styleCode
```

これらは将来必要になったら別仕様で扱う。

---

## Quality Standard

以下を満たすこと。

```text
ブランド選択後、1文字ずつ入力するだけで目的モデルが自然に候補へ出る。
```

例:

```text
Nike / A -> Air 系モデル
Nike / 95 -> Air Max 95
New Balance / 9 -> 990系など
ASICS / 2160 -> GT-2160
Onitsuka Tiger / Mexico66 -> Mexico 66
```
