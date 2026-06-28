# Kick×Kick Data Master

## Purpose

このディレクトリは、Kick×Kick がアプリ内検索・登録補助で使用する実データを管理する。

`specs/` は人が読む仕様書、`data/` は Flutter が読み込む実データ資産として扱う。

---

## Files

```text
brands.json
models.json
aliases.json
search_keywords.json
```

---

## Current Coverage

```text
Tier S: Nike / Air Jordan / adidas / New Balance / ASICS
Tier A: PUMA / Converse / Vans / Reebok
Tier B: HOKA / Saucony / SALOMON
```

Tier SはMVP基準でPASS。ただしABC-MARTなど国内流通リファレンスとの差分監査は継続する。

Tier Aは代表モデルのみ高確度で追加済み。今後も国内流通モデルを基準に段階拡張する。

Tier BはHOKAに加え、ABC-MART掲載ブランドからSaucony / SALOMONを追加。各ブランドは公式サイト上で確認できる高確度モデルのみ登録済み。2026-06-29時点では `data/*.json` と `app/assets/data/*.json` は同期済み。

Tier Cは未追加。

---

## External Reference Policy

Kick×Kickのモデルデータは、国内ユーザーが実際に探す可能性を重視する。

基本方針:

```text
1. ABC-MARTなど国内大手販売サイトをリファレンスとして見る
2. 国内流通ブランド・モデルを追加候補にする
3. モデル名はブランド公式サイトまたは信頼できる公式情報で確認する
4. 低確度モデル、色名、コラボ名だけのデータは追加しない
5. Alias / searchKeywords は検索品質を壊さない範囲に限定する
```

ABC-MARTを「完成形に近い国内流通リファレンス」として扱う。ただし商品説明文・画像・在庫情報はコピーしない。

---

## File Roles

### brands.json

ブランド実データ。

主な項目:

```text
brandId
brandName
tier
isEnabled
```

---

### models.json

モデル実データ。

主な項目:

```text
id
brandId
modelName
category
source
```

`modelName` は表示・保存に使う正式表記。

---

### aliases.json

Alias実データ。

主な項目:

```text
modelId
alias
```

Aliasは検索専用。

表示・保存には使わない。

---

### search_keywords.json

検索キーワード実データ。

主な項目:

```text
modelId
keyword
```

数字検索、日本語検索、連結表記検索を補助する。

---

## Canonical Name Rule

保存名は必ず `models.json` の `modelName` を使う。

例:

```text
GT2160 -> GT-2160
P6000 -> P-6000
Mexico66 -> Mexico 66
AF1 -> Air Force 1
AJ1 -> Air Jordan 1
OldSkool -> Old Skool
ClubC -> Club C
Bondi9 -> Bondi 9
Clifton10 -> Clifton 10
Speedgoat7 -> Speedgoat 7
Ride19 -> Ride 19
XT6 -> XT-6
```

`aliases.json` や `search_keywords.json` の値を保存名にしてはいけない。

---

## ID Rule

`models.json` の `id` は小文字スネークケースにする。

形式:

```text
{brand_id}_{model_slug}
```

例:

```text
nike_air_max_95
new_balance_990v6
asics_gt_2160
air_jordan_1
adidas_campus_00s
puma_speedcat
vans_old_skool
reebok_club_c
hoka_bondi_9
hoka_clifton_10
saucony_ride_19
salomon_xt_6
```

---

## Alias Rule

Aliasに入れてよいもの:

```text
- よく使われる略称
- ハイフンなし表記
- スペースなし表記
- 型番の省略表記
```

Aliasに入れないもの:

```text
- 保存名として使うべき正式名称の別表記
- 広すぎるシリーズ名だけの値
- 色名だけ
- コラボ名だけ
```

---

## Search Keyword Rule

searchKeywordsに入れてよいもの:

```text
- モデル名の途中にある数字
- 連結表記
- 日本語表記
- Aliasとは別に補助したい検索語
```

searchKeywordsに入れないもの:

```text
- 1文字だけの数字や英字
- Air / Max / GEL / Cloud / XT / Pro など広すぎる単語
- Old / Classic / Star / Club / Ride / Guide など広すぎる単語
- 色名だけ
- コラボ名だけ
```

例外:

```text
Air Jordan の AJ1 / AJ3 のように、ブランド内で明確にモデル指定できる場合は Alias 側で扱う。
```

---

## Brand Consistency Rule

`models.json` の `brandId` は `brands.json` に存在する必要がある。

`aliases.json` と `search_keywords.json` の `modelId` は `models.json` に存在する必要がある。

---

## Duplicate Rule

同じモデルを別IDで重複登録しない。

---

## Free Input Rule

候補にないモデルでも登録できる。

ただし、マスターデータに追加する場合は以下を確認する。

```text
- 正式表記が決まっている
- brandIdが正しい
- Aliasが検索専用になっている
- searchKeywordsが広すぎない
```

---

## Update Flow

データ追加時の基本手順:

```text
1. ABC-MARTなど国内流通リファレンスでブランド・モデル候補を確認
2. ブランド公式サイトまたは信頼できる公式情報で正式表記を確認
3. brands.json にブランドがあるか確認
4. models.json にモデルを追加
5. aliases.json にAliasを追加
6. search_keywords.json に必要な検索語を追加
7. app/assets/data/*.json に同期
8. specs/MODEL_MASTER_COVERAGE.md を更新
9. data/CHANGELOG.md に監査ログを残す
10. specs/KICKXKICK_TASK_BOARD.md を更新
```

---

## Quality Standard

Tier Sでは以下を満たすこと。

```text
Model Coverage: PASS
Alias: PASS
searchKeywords: PASS
Canonical Name: PASS
```

Tier A以降も、追加する場合は同じ基準で育成する。

候補の完全網羅より、ユーザーが登録を完了できることを優先する。