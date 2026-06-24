# Kick×Kick Registration Validation Spec v1.0

## Purpose

この仕様書は、Kick×Kick のスニーカー登録時の整合性チェックを定義する。

目的は、ブランドとモデルの不正な組み合わせを防ぎつつ、候補にないモデルも自由入力で登録できる状態を維持することである。

---

## Related Specs

```text
specs/REGISTRATION_FLOW_SPEC.md
specs/SEARCH_SPEC.md
specs/MODEL_MASTER_DATA_SPEC.md
specs/BRAND_MASTER.md
specs/MODEL_MASTER/README.md
```

---

## Basic Rule

ブランドとモデルはセットで扱う。

マスター候補から選択されたモデルは、必ず選択中ブランドに属している必要がある。

例:

```text
Brand: Nike
Model: Air Max 95
Result: OK
```

```text
Brand: ASICS
Model: Air Max 95
Result: NG
```

---

## Brand Change Rule

登録フォームでブランドを変更した場合、モデル関連の入力状態をリセットする。

リセット対象:

```text
selectedModelId
modelName
modelSource
modelAliases
modelSearchText
modelSuggestions
```

表示状態:

```text
モデル未選択
```

---

## Brand Change Example

変更前:

```text
Brand: Nike
Model: Air Max 95
```

ユーザーがブランドを変更:

```text
Brand: ASICS
```

変更後:

```text
Brand: ASICS
Model: 未選択
```

Air Max 95 を残してはいけない。

---

## Save Validation Rule

保存前に以下を確認する。

```text
1. brandName が空ではない
2. modelName が空ではない
3. modelSource が master の場合、model が brand に属している
4. modelSource が user_input の場合、brand との整合性チェックは通す
```

---

## Master Model Validation

マスター候補から選択したモデルは、以下を持つ。

```text
brandId
modelName
source: master
```

保存時に、選択中ブランドの brandId と model の brandId が一致すること。

一致する例:

```text
brandId: nike
model.brandId: nike
modelName: Air Max 95
Result: OK
```

一致しない例:

```text
brandId: asics
model.brandId: nike
modelName: Air Max 95
Result: NG
```

---

## Free Input Exception

自由入力モデルは例外として保存できる。

例:

```text
Brand: ASICS
Model: My Sample Shoe
modelSource: user_input
Result: OK
```

理由:

```text
Kick×Kick は候補の完全網羅を目的にしないため。
```

ただし、自由入力時は modelSource を必ず `user_input` にする。

---

## Canonical Name Save Rule

マスター候補を選択した場合、保存するモデル名は必ず正式表記 `modelName` にする。

例:

```text
Input: GT2160
Display: GT-2160
Save: GT-2160
```

```text
Input: Mexico66
Display: Mexico 66
Save: Mexico 66
```

Aliasを保存名にしてはいけない。

---

## Error Display

保存時に不整合が見つかった場合は、強いエラー文ではなく、再選択を促す。

表示例:

```text
ブランドが変更されたため、モデルをもう一度選択してください。
```

避ける表示:

```text
不正なモデルです
登録できません
```

---

## No Result Rule

候補が見つからない場合は、自由入力で登録できる。

表示:

```text
候補が見つかりません
このモデル名で登録できます
```

---

## Edit Flow Rule

登録済みスニーカーを編集する場合も、ブランド変更時はモデルをリセットする。

ただし、既存の写真・メモ・サイズ・購入日・着用履歴は消さない。

リセット対象:

```text
modelName
modelSource
selectedModelId
```

保持対象:

```text
photos
memo
size
purchaseDate
wearHistory
collectionPlacement
stickerPlacement
```

---

## Quality Standard

以下を満たすこと。

```text
1. ブランド変更時に古いモデルが残らない
2. マスター候補は正しいブランドに属している
3. 自由入力は妨げない
4. 保存名は正式表記に統一される
5. ユーザーに分かりやすく再選択を促す
```
