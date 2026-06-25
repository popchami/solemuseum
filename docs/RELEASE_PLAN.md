# Kick×Kick Release Plan v1.0

## 目的

Kick×KickのMVPリリース範囲、リリース条件、リリース後に回す機能を明確にする。

MVP開発中に機能追加で迷走しないため、この文書をリリース判断の基準にする。

---

## Release 1.0 の目的

Kick×Kickを、スニーカーコレクション管理アプリとして最低限使える状態でリリースする。

最初のリリースでは、完成度よりも以下を優先する。

- 登録できる
- 編集できる
- 見返せる
- 写真を残せる
- TOP5を決められる
- 着用履歴を残せる
- Stickerとして楽しめる
- クラッシュしない

---

## Release 1.0 に含める機能

### 1. スニーカー登録

- ブランド選択
- モデル選択
- ブランド自由入力
- モデル自由入力
- サイズ
- カラー
- 購入日
- 購入価格
- 購入店
- メモ
- Display Title
- Sticker Text
- 状態
- メイン写真

### 2. ブランド・モデル検索

MVPリリース可能ラインとして扱う。

- ブランド候補
- モデル候補
- Alias検索
- searchKeywords検索
- 数字検索
- 自由入力

ユーザーの自由入力はマスターJSONへ自動追加しない。

### 3. Collection

- 登録済みスニーカー一覧
- 写真表示
- Display Title表示
- 状態表示
- ブランド検索
- モデル検索
- Display Title検索
- Sticker Text検索
- ブランドフィルター
- 状態フィルター
- 詳細画面への遷移

### 4. ShoeDetailScreen

- 登録内容表示
- Display Title表示
- Sticker Text表示
- 状態表示
- 写真表示
- 編集
- 削除
- MY TOP5追加 / 解除
- 着用履歴表示

### 5. MY TOP5

- 最大5足まで登録
- Home表示
- 詳細画面から追加 / 解除

### 6. 着用履歴

- 今日履いた記録
- メモ追加
- 同日重複防止
- 履歴表示
- 履歴削除

### 7. Home

- 最近追加
- MY TOP5
- 登録数サマリー
- Display Title対応

### 8. Sticker

MVPでは最小実装とする。

- Sticker画面表示
- 登録済みスニーカーをStickerカードとして表示
- Sticker Text表示
- Display TitleまたはModel Name表示
- 写真表示
- 写真なしカード表示

高度な配置編集や共有機能はRelease 1.0には含めない。

---

## Release 1.0 に含めない機能

以下はMVP後に回す。

- クラウド同期
- Google Driveバックアップ
- アカウント機能
- ログイン
- Premium課金
- 広告
- SNS共有
- 通知
- AI画像生成
- AI説明文生成
- ブランド・モデルFactoryの拡張
- マスターJSON自動更新
- 自由入力モデル管理画面
- Stickerの自由配置
- Stickerの画像書き出し
- 複数写真ギャラリー
- 箱管理
- 統計の高度化
- テーマ切り替え

---

## リリース条件

Release 1.0 は、以下を満たした場合にリリース候補とする。

### 必須条件

- `flutter pub get` が通る
- `flutter analyze` の重大エラーが0
- `flutter run` で実機起動できる
- 起動直後にクラッシュしない
- DB migration version5 が通る
- 新規登録できる
- 編集できる
- 削除できる
- 詳細画面で登録内容を確認できる
- Collectionに登録内容が表示される
- 写真あり / 写真なしの両方で保存できる
- MY TOP5が動く
- 着用履歴が動く
- Sticker最小実装が表示できる

### 望ましい条件

- 主要導線で表示崩れがない
- エラーメッセージが最低限表示される
- 連続操作でクラッシュしない
- 既存DBからversion5へ更新できる
- 新規DBでも起動できる

---

## リリース前に確認する導線

1. アプリ起動
2. Home表示
3. Collection表示
4. 新規登録
5. ブランド検索
6. モデル検索
7. 自由入力ブランド登録
8. 自由入力モデル登録
9. 写真あり保存
10. 写真なし保存
11. 詳細表示
12. 編集
13. 写真変更
14. TOP5追加
15. TOP5解除
16. 着用履歴追加
17. 着用履歴削除
18. Collection検索
19. Collectionフィルター
20. Sticker表示
21. 削除

---

## リリース不可条件

以下が1つでも残る場合はRelease 1.0に進まない。

- 起動できない
- `flutter analyze` の重大エラーが残る
- 新規登録できない
- 登録後に詳細画面でクラッシュする
- DB migrationで既存データが壊れる
- 写真なし登録でクラッシュする
- Collectionが表示できない
- 編集後に保存できない
- 削除できない

---

## 開発ルール

Release 1.0までは以下を守る。

- 新機能追加より不具合修正を優先
- 大きな設計変更をしない
- Riverpod構成を維持
- Repository構成を維持
- SQLite中心を維持
- 小さな差分で修正
- 1変更ごとに `flutter analyze` を確認
- ブランド・モデルFactory作業へ戻らない

---

## GitHub運用

MVP確認は以下を中心に進める。

- `docs/HANDOFF_KICKXKICK_MVP_2026-06-25.md`
- `docs/HANDOFF_BRAND_MODEL_SEARCH.md`
- `docs/MVP_RELEASE_CHECKLIST.md`
- `docs/RELEASE_PLAN.md`
- Issue #23

---

## Release 1.0 完了後

Release 1.0完了後、次の検討へ進む。

- Premium
- Backup
- Google Drive連携
- Sticker拡張
- SNS共有
- 複数写真
- 箱管理
- 統計
- デザインテーマ
- ストア掲載準備
