# Kick×Kick Search Spec v2.0

## Purpose

この仕様書は、Kick×Kick の検索・サジェスト挙動を定義する。

v2.0 では、登録体験をシンプルにするため、以下を採用する。

```text
ブランドを選ぶ
↓
そのブランド内のモデルをサジェストする
```

検索ボタンで探す体験ではなく、入力中に候補が自動で出るサジェスト体験を基本とする。

---

## Core UX

ユーザーは検索したいのではなく、登録したい。

そのため、モデル選択では以下を重視する。

```text
1. ブランドを先に選ぶ
2. モデル候補はブランド内に限定する
3. 入力なしでも候補を表示する
4. 1文字入力したら、その文字から始まる候補を出す
5. 候補はアルファベット順でよい
6. 候補がなければ自由入力できる
```

---

## Registration Search Flow

```text
1. ブランド選択
2. モデル入力欄を表示
3. 入力なしなら、そのブランドのモデルを先頭から最大5件表示
4. 1文字以上入力されたら、前方一致で候補を最大5件表示
5. Alias一致があれば正式モデル名として候補に出す
6. 候補がなければ自由入力fallbackを表示
```

---

## Brand Search

ブランド検索はブランド名・ブランドAliasで行う。

例:

```text
NB -> New Balance
ニューバランス -> New Balance
オニツカ -> Onitsuka Tiger
```

ブランド選択後、モデル検索はそのブランド内に限定する。

---

## Model Suggestion: Empty Input

ブランド選択直後、モデル入力が空の場合は、そのブランドのモデル候補をアルファベット順で最大5件表示する。

例:

```text
ブランド: Nike
入力: 空
候補:
- Air Force 1
- Air Max 1
- Air Max 90
- Air Max 95
- Air Max 97
```

人気順やpriority順はMVPでは使わない。

---

## Model Suggestion: Prefix Input

ユーザーが1文字以上入力したら、モデル名またはAliasの前方一致で候補を表示する。

候補は最大5件。

例:

```text
ブランド: Nike
入力: A
候補:
- Air Force 1
- Air Max 1
- Air Max 90
- Air Max 95
- Air Max 97
```

例:

```text
ブランド: Nike
入力: D
候補:
- Dunk High
- Dunk Low
- Dunk Low Retro
- Dunk Low Twist
- Dunk Mid
```

例:

```text
ブランド: New Balance
入力: 9
候補:
- 990v1
- 990v2
- 990v3
- 990v4
- 990v5
```

---

## Alias Suggestion

Aliasは補助として使う。

入力されたAliasが一致した場合、表示は正式モデル名にする。

例:

```text
ブランド: Nike
入力: AF1
表示: Air Force 1
```

例:

```text
ブランド: Air Jordan
入力: AJ1
表示: Air Jordan 1
```

例:

```text
ブランド: ASICS
入力: GT2160
表示: GT-2160
```

---

## Sorting Rule

MVPではシンプルにする。

モデル候補の基本並び順:

```text
1. モデル名のアルファベット順
2. 同名・同系統は自然順
3. Alias一致は正式モデル名として同じリストに混ぜる
```

priority / popular / featured はMVPでは使わない。

---

## Natural Sort Rule

数字を含むモデルは自然順にする。

例:

```text
Air Max 1
Air Max 90
Air Max 95
Air Max 97
```

例:

```text
990v1
990v2
990v3
990v4
990v5
990v6
```

---

## Result Limit

MVPでは候補表示は以下にする。

```text
ブランド候補: 最大5件
モデル候補: 最大5件
```

候補が多い場合は、ユーザーが1文字ずつ入力することで絞り込む。

---

## Normalization

検索前に、入力値と検索対象を正規化する。

正規化ルール:

```text
- 大文字小文字を無視
- 半角全角を可能な範囲で同一扱い
- 空白を無視
- ハイフンを無視
- ドットを無視
- アポストロフィを無視
- 日本語表記はAliasで補完
```

例:

```text
AF-1 -> AF1
GT2160 -> GT-2160
NB 550 -> NB550
Cloud5 -> Cloud 5
MB.01 -> MB01
SP110 -> SP-110
```

---

## No Result Behavior

候補が見つからない場合、登録を止めない。

表示:

```text
候補が見つかりません
このモデル名で登録できます
```

保存時の source:

```text
user_input
```

---

## Out of Scope for MVP

MVPでは以下は対象外。

```text
- 人気順ランキング
- market price
- release year
- colorway search
- collaboration search
- style code search
- AI auto detection
```

---

## MVP Test Queries

最低限以下を通過すること。

```text
ブランド Nike / 入力 空 -> Air Force 1, Air Max 1, Air Max 90, Air Max 95, Air Max 97
ブランド Nike / 入力 A -> Air Force 1, Air Max 1, Air Max 90, Air Max 95, Air Max 97
ブランド Nike / 入力 D -> Dunk 系候補
ブランド Nike / 入力 AF1 -> Air Force 1
ブランド Air Jordan / 入力 AJ1 -> Air Jordan 1
ブランド New Balance / 入力 9 -> 990系候補
ブランド New Balance / 入力 NB550 -> 550
ブランド ASICS / 入力 GT2160 -> GT-2160
ブランド Salomon / 入力 XT6 -> XT-6
候補なし -> 自由入力fallback
```

---

## Quality Standard

検索品質の合格基準:

```text
ブランドを選んだ後、1文字ずつ入力するだけで目的モデルが自然に候補へ出ること。
```

候補数が多くても、ユーザーが1文字ずつ入力すれば絞り込めることを重視する。
