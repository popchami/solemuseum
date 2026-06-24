# Kick×Kick Search MVP Test Spec v1.0

## Purpose

この仕様書は、Kick×Kick の検索MVPが最低限満たすべきテストケースを定義する。

検索品質は、ブランド数・モデル数と同じくらいユーザー満足度に影響する。

候補が存在していても、検索で到達できなければユーザーには「無い」と感じられるため、MVP段階で必ず確認する。

---

## Related Specs

```text
specs/SEARCH_SPEC.md
specs/SEARCH_DATA_SPEC.md
specs/ALIAS_MASTER_SPEC.md
specs/REGISTRATION_FLOW_SPEC.md
specs/BRAND_MASTER.md
specs/MODEL_MASTER/README.md
```

---

## Pass Condition

以下を満たしたらMVP検索は合格とする。

```text
1. 主要ブランドが検索できる
2. 主要モデルが検索できる
3. Aliasで検索できる
4. 日本語Aliasで検索できる
5. 空白・ハイフン・ドット違いを吸収できる
6. 候補が無い場合も自由入力へ進める
```

---

## Brand Search Tests

### BS-001

入力:

```text
Nike
```

期待結果:

```text
Nike
```

### BS-002

入力:

```text
NB
```

期待結果:

```text
New Balance
```

### BS-003

入力:

```text
ニューバランス
```

期待結果:

```text
New Balance
```

### BS-004

入力:

```text
オニツカ
```

期待結果:

```text
Onitsuka Tiger
```

---

## Model Search Tests

### MS-001

入力:

```text
Air Force 1
```

期待結果:

```text
Nike Air Force 1
```

### MS-002

入力:

```text
Air Max 95
```

期待結果:

```text
Nike Air Max 95
```

### MS-003

入力:

```text
990v6
```

期待結果:

```text
New Balance 990v6
```

### MS-004

入力:

```text
GT-2160
```

期待結果:

```text
ASICS GT-2160
```

### MS-005

入力:

```text
XT-6
```

期待結果:

```text
Salomon XT-6
```

---

## Alias Search Tests

### AS-001

入力:

```text
AF1
```

期待結果:

```text
Nike Air Force 1
```

### AS-002

入力:

```text
AJ1
```

期待結果:

```text
Air Jordan 1
```

### AS-003

入力:

```text
AM95
```

期待結果:

```text
Nike Air Max 95
```

### AS-004

入力:

```text
NB550
```

期待結果:

```text
New Balance 550
```

### AS-005

入力:

```text
GT2160
```

期待結果:

```text
ASICS GT-2160
```

### AS-006

入力:

```text
XT6
```

期待結果:

```text
Salomon XT-6
```

### AS-007

入力:

```text
Mexico66
```

期待結果:

```text
Onitsuka Tiger Mexico 66
```

---

## Japanese Alias Tests

### JA-001

入力:

```text
エアフォース
```

期待結果:

```text
Nike Air Force 1
```

### JA-002

入力:

```text
エアマックス
```

期待結果:

```text
Nike Air Max Series
```

### JA-003

入力:

```text
ジョーダン
```

期待結果:

```text
Air Jordan
```

### JA-004

入力:

```text
カヤノ
```

期待結果:

```text
ASICS GEL-Kayano Series
```

### JA-005

入力:

```text
ボメロ
```

期待結果:

```text
Nike Zoom Vomero 5
```

### JA-006

入力:

```text
ダンク
```

期待結果:

```text
Nike Dunk Series
```

---

## Normalization Tests

### NT-001

入力:

```text
AF-1
```

期待結果:

```text
Nike Air Force 1
```

### NT-002

入力:

```text
Airmax95
```

期待結果:

```text
Nike Air Max 95
```

### NT-003

入力:

```text
NB 550
```

期待結果:

```text
New Balance 550
```

### NT-004

入力:

```text
MB01
```

期待結果:

```text
PUMA MB.01
```

### NT-005

入力:

```text
SP110
```

期待結果:

```text
SPINGLE SP-110
```

---

## Series Search Tests

### SS-001

入力:

```text
990
```

期待結果:

```text
New Balance 990v6
New Balance 990v5
New Balance 990v4
New Balance 990v3
New Balance 990v2
New Balance 990v1
```

### SS-002

入力:

```text
Air Max
```

期待結果:

```text
Nike Air Max 1
Nike Air Max 90
Nike Air Max 95
Nike Air Max 97
Nike Air Max Plus
```

### SS-003

入力:

```text
Dunk
```

期待結果:

```text
Nike Dunk Low
Nike Dunk High
Nike SB Dunk Low
```

---

## Brand + Model Tests

### BM-001

入力:

```text
Nike 95
```

期待結果:

```text
Nike Air Max 95
```

### BM-002

入力:

```text
NB 990
```

期待結果:

```text
New Balance 990 Series
```

### BM-003

入力:

```text
ASICS 1130
```

期待結果:

```text
ASICS GEL-1130
```

---

## No Result Tests

### NR-001

入力:

```text
Unknown Brand
```

期待結果:

```text
候補が見つかりません
自由入力で登録できます
```

### NR-002

入力:

```text
Unknown Model
```

期待結果:

```text
候補が見つかりません
自由入力で登録できます
```

---

## Regression Rule

検索仕様を変更した場合、最低限このテストセットを再確認する。

特に以下は必ず落としてはいけない。

```text
AF1
AJ1
AM95
990
NB550
GT2160
XT6
エアマックス
カヤノ
自由入力fallback
```

---

## Notes

MVPでは自動テスト化できなくてもよい。

ただし、実装後に手動確認できるチェックリストとして必ず使う。
