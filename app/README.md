# Kick×Kick App

Flutter で開発するスニーカーステッカーコレクションアプリ。

Kick×Kick は、スニーカーを登録し、ステッカー化し、棚やボードに飾って楽しむアプリです。

## 技術スタック

- **Framework**: Flutter
- **Language**: Dart
- **UI**: Material 3
- **状態管理**: Riverpod
- **データベース**: SQLite
- **アーキテクチャ**: オフライン完結（サーバー不要、ログイン不要）

## セットアップ

### 前提条件

- Flutter 3.0 以上
- Dart 3.0 以上
- Android Studio または Xcode

### インストール

```bash
cd app
flutter pub get
```

### 開発実行

```bash
flutter run
```

### ビルド

```bash
# iOS
flutter build ios

# Android
flutter build apk
flutter build appbundle
```

## プロジェクト構成

```text
app/
├── lib/
│   ├── screens/           # 画面ウィジェット
│   ├── widgets/           # 再利用可能なウィジェット
│   ├── providers/         # Riverpod プロバイダー
│   ├── models/            # データモデル
│   ├── services/          # ビジネスロジック
│   ├── database/          # SQLite操作
│   ├── theme/             # Material 3テーマ設定
│   └── main.dart          # エントリーポイント
├── pubspec.yaml
└── pubspec.lock
```

## 技術方針

### Material 3

- 最新の Material Design 言語
- Kick×Kickのモノクロ＋オレンジのデザインに合わせる

### Riverpod

- 宣言的な状態管理
- キャッシング機能
- テスト容易性の確保

### SQLite

- ローカルデータ永続化
- オフライン環境での完全対応
- 高速クエリ処理

### オフライン完結

- サーバー依存なし
- ログイン機能不要
- すべてのデータはローカルに保存

## 開発ガイド

Kick×Kick の正本仕様は以下を参照してください。

```text
../specs/KICKXKICK_*
```

Sprint1実装では以下を参照してください。

```text
../specs/KICKXKICK_SPRINT1_INSTRUCTION.md
```
