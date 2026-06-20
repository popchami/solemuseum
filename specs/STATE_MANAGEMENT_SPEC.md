# STATE_MANAGEMENT_SPEC.md

## 概要

SoleMuseum MVPにおける状態管理仕様。

Riverpodを採用する。

状態管理はシンプルさを優先し、
過度な抽象化を避ける。

---

# Architecture

```text
UI
↓
Provider
↓
Repository
↓
Database
```

---

# State Management

## Framework

```text
flutter_riverpod
```

---

# Providers

## shoeRepositoryProvider

役割

```text
ShoeRepository提供
```

---

## shoeListProvider

役割

```text
スニーカー一覧取得
```

戻り値

```dart
List<Shoe>
```

---

## shoeDetailProvider

役割

```text
スニーカー詳細取得
```

引数

```dart
shoeId
```

戻り値

```dart
Shoe
```

---

## statisticsProvider

役割

```text
ホーム画面統計取得
```

戻り値

```dart
Statistics
```

内容

```dart
totalShoes
totalBrands
monthlyAdded
```

---

# State Rules

## Home Screen

取得

```text
statisticsProvider
```

取得

```text
recentShoesProvider
```

---

## Collection Screen

取得

```text
shoeListProvider
```

---

## Shoe Detail Screen

取得

```text
shoeDetailProvider
```

---

## Shoe Form Screen

保存後

```text
invalidate
```

対象

```dart
shoeListProvider
statisticsProvider
```

---

# Async Handling

使用

```dart
AsyncValue
```

---

## Loading

表示

```text
CircularProgressIndicator
```

---

## Error

表示

```text
データの取得に失敗しました
```

---

## Success

通常描画

---

# Search State

Collection画面のみ

保持

```dart
StateProvider<String>
```

名前

```dart
searchQueryProvider
```

---

# Filter State

Collection画面のみ

保持

```dart
StateProvider<String?>
```

名前

```dart
brandFilterProvider
```

---

# Form State

MVP

```text
TextEditingController
```

使用

FormProvider作成不要

---

# Repository Layer

## ShoeRepository

責務

```text
CRUD処理
```

---

# Methods

## getAllShoes()

```dart
Future<List<Shoe>>
```

---

## getShoeById()

```dart
Future<Shoe?>
```

---

## insertShoe()

```dart
Future<int>
```

---

## updateShoe()

```dart
Future<void>
```

---

## deleteShoe()

```dart
Future<void>
```

---

# Performance Rules

MVPでは

```text
Providerの細分化を行わない
```

---

許可

```text
shoeListProvider
shoeDetailProvider
statisticsProvider
```

---

禁止

```text
過度なProvider分割
```

---

# DESIGN PRINCIPLE

状態管理は理解しやすさを優先する。

MVPでは

```text
シンプル
```

を最優先とする。

Providerの増殖を避ける。