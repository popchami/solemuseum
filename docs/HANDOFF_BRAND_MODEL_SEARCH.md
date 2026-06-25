# Kick×Kick Brand / Model / Search Handoff v1.0

## Status

```text
ブランド・モデル・検索基盤はいったん終了。
MVPリリースに進める状態。
```

この作業は、Kick×Kick本体開発を止めないために、ここで一度区切る。

---

## Goal Reminder

Kick×Kickの目的は、ブランド・モデルFactoryを完成させることではない。

目的は、Kick×Kickをリリースまで持っていくこと。

```text
Factory is support.
Kick×Kick release is the goal.
```

---

## Current Search / Registration State

現在の検索・登録はMVPリリース可能ライン。

できること:

```text
- ブランド候補を表示できる
- モデル候補を表示できる
- Alias検索できる
- searchKeywords検索できる
- 数字検索できる
- 候補がない場合は自由入力できる
- 自由入力ブランドをローカルbrandsへ保存できる
- 自由入力モデルは靴1件のmodelNameとして保存できる
- 登録済みの靴を編集してブランド・モデルを修正できる
```

---

## Important UX Decisions

### Brand

ブランドは候補選択を基本とする。

候補にない場合は自由入力できる。

自由入力ブランドは、保存時にローカルDBの `brands` に追加され、その靴に紐づく。

ただし、マスターJSONには自動追加しない。

---

### Model

モデルはブランド選択後に、そのブランド内の候補を表示する。

候補にない場合は自由入力できる。

自由入力モデルは、その靴1件の `modelName` として保存する。

ユーザー辞書・モデルマスターには自動追加しない。

---

### User Mistake Handling

ユーザーが自由入力で誤字を入れた場合:

```text
靴詳細
↓
編集
↓
ブランド / モデル名を修正
↓
保存
```

MVPでは「自由入力モデル管理画面」は作らない。

理由:

```text
自由入力モデルは全体辞書ではなく、その靴1件の値として扱うため。
```

---

## Search Behavior

### Brand Search

ブランド名で候補を表示する。

例:

```text
N -> Nike / New Balance
ad -> adidas
```

---

### Model Search

ブランド選択後、そのブランド内だけを検索する。

検索対象:

```text
modelName
aliases
searchKeywords
```

候補は最大5件。

入力なしの場合は、そのブランド内のモデルをアルファベット順で最大5件表示する。

---

## MVP Test Examples

リリース前に最低限確認すること。

```text
Nike + A     -> Air Force 1 / Air Max 1 / Air Max 90 / Air Max 95 / Air Max 97
Nike + 95    -> Air Max 95
Nike + P6000 -> P-6000
Air Jordan + AJ1 -> Air Jordan 1
New Balance + 550 -> 550
New Balance + 990 -> 990v1〜990v6
ASICS + 2160 -> GT-2160
候補なしブランド -> 自由入力 -> 保存
候補なしモデル -> 自由入力 -> 保存
編集画面 -> 誤字修正 -> 保存
```

---

## Implemented Files

### App Search Engine

```text
app/lib/features/search/search.dart
app/lib/features/search/search_models.dart
app/lib/features/search/search_normalizer.dart
app/lib/features/search/search_index.dart
app/lib/features/search/search_service.dart
app/lib/features/search/search_repository.dart
app/lib/features/search/search_providers.dart
```

### Search Widgets

```text
app/lib/features/search/widgets/brand_search_field.dart
app/lib/features/search/widgets/model_search_field.dart
app/lib/features/search/widgets/sneaker_master_picker.dart
```

### Search Demo

```text
app/lib/features/search/screens/search_demo_screen.dart
```

Settingsから確認可能:

```text
設定
↓
開発
↓
検索デモ
```

### App Assets

```text
app/assets/data/brands.json
app/assets/data/models.json
app/assets/data/aliases.json
app/assets/data/search_keywords.json
```

### Flutter Asset Registration

```text
app/pubspec.yaml
```

---

## Registration Integration

登録画面に検索部品を接続済み。

```text
app/lib/screens/shoe_form_screen.dart
```

基本情報ステップで以下を扱う。

```text
ブランド検索
モデル検索
保存するブランド
保存するモデル名
```

自由入力ブランドは保存時にローカルDBへ追加する。

---

## Brand Repository Update

自由入力ブランド保存用に以下を追加済み。

```text
app/lib/repositories/brand_repository.dart
```

追加メソッド:

```text
findByName
findOrCreateByName
```

---

## Data Factory / Master Data State

ブランド・モデルの継続追加は将来作業として残す。

ただし、MVPリリースを止めない。

現時点の扱い:

```text
- data/*.json は検索エンジン用の初期データ
- app/assets/data/*.json はFlutterアプリ用の同期データ
- マスター追加はAI提案 + Validation + 承認で進める
- ユーザーの自由入力を自動でマスターへ入れない
```

---

## Important Rule for Future Work

次にブランド・モデル作業を再開する場合は、以下から始める。

```text
1. data/*.json と app/assets/data/*.json の同期方法を自動化する
2. Tier S / Tier A のモデル追加を再開する
3. Alias / searchKeywords の品質監査を行う
4. Search MVPテストを実施する
5. Factory提案JSONからPR作成の流れを整える
```

ただし、Kick×Kick本体のMVP開発を優先すること。

---

## Next Recommended Work

ブランド・モデル作業はいったん終了。

次に進むべき作業:

```text
1. 登録画面の実機確認
2. flutter analyze
3. 登録済み靴の詳細画面確認
4. 写真登録の動作確認
5. TOP5
6. 着用履歴
7. Collection
8. Sticker
9. Premium / Backup / Release
```

---

## Paste for Next Chat

次チャットに貼る場合は、以下を使う。

```text
Kick×Kickのブランド・モデル・検索作業はいったん終了。
検索はMVPリリース可能ライン。
ブランド候補・モデル候補・Alias・searchKeywords・数字検索・自由入力に対応済み。
自由入力ブランドは保存時にローカルDBへ追加。
自由入力モデルは靴1件のmodelNameとして保存。
ユーザーの自由入力はマスターJSONへ自動追加しない。
誤入力は靴詳細→編集で修正する。
次はKick×Kick本体のMVP開発を進める。
優先は登録画面の実機確認、flutter analyze、詳細画面、写真、TOP5、着用履歴、Collection、Sticker。
関連引き継ぎ: docs/HANDOFF_BRAND_MODEL_SEARCH.md
```
