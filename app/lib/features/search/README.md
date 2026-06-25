# Search Feature

Kick×Kick のブランド・モデル登録補助用検索エンジン。

## Purpose

ユーザーがスニーカー登録時に、ブランド・モデルを簡単に選べるようにする。

```text
ブランド選択
↓
モデル候補表示
↓
Alias / searchKeywords / modelName で検索
↓
候補がなければ自由入力
↓
保存時は canonical modelName
```

---

## Files

```text
search_models.dart
search_normalizer.dart
search_index.dart
search_service.dart
search.dart
```

---

## Usage Image

```dart
final index = SearchIndex.fromJsonStrings(
  brandsJson: brandsJson,
  modelsJson: modelsJson,
  aliasesJson: aliasesJson,
  searchKeywordsJson: searchKeywordsJson,
);

final service = SearchService(index);

final suggestions = service.suggestModels(
  brandId: 'nike',
  query: '95',
);

final canonicalName = suggestions.first.canonicalName; // Air Max 95
```

---

## MVP Search Requirements

```text
A -> Air Force 1 / Air Max 1 / Air Max 90 / Air Max 95 / Air Max 97
95 -> Air Max 95
P6000 -> P-6000
AJ1 -> Air Jordan 1
550 -> 550
990 -> 990v1〜990v6
2160 -> GT-2160
```

---

## Next Work

```text
1. Bundle data/*.json as Flutter assets
2. Add repository/provider to load SearchIndex
3. Connect to registration screen
4. Add Search MVP test cases
```
