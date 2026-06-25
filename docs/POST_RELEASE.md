# Kick×Kick Post Release Roadmap

## 目的

この文書は、Kick×Kick MVPリリース後に検討・実装する機能を整理するためのもの。

MVPリリース前に新機能追加で迷走しないよう、今すぐ入れない機能はここへ退避する。

```text
MVP前は、この文書の機能を原則実装しない。
MVP後に優先順位を再評価する。
```

---

## 基本方針

- MVPリリース前は起動・登録・編集・詳細・写真・TOP5・着用履歴・Collection・Sticker最小実装を優先する
- MVP後にユーザー反応を見て追加機能を決める
- 新機能は必ずIssue化してから実装する
- 大きな設計変更はRelease 1.0後に検討する
- 課金・バックアップ・共有はMVP後に分けて進める

---

## Version 1.1 候補

MVP直後に検討する機能。

### Backup / Restore

- ローカルバックアップ
- 復元
- エクスポートファイル作成
- インポート
- 機種変更向けの最低限の引き継ぎ

### Premium

- Premium画面
- 買い切り課金
- 無料制限の整理
- Premium解放項目の整理
- ストア説明文との整合

### Sticker改善

- Stickerカードの見た目改善
- Sticker Text表示改善
- 写真なしStickerの見た目改善
- Sticker Boardの保存
- Sticker Boardの複数作成

### UI調整

- Collectionカード改善
- Home表示改善
- TOP5表示改善
- 空状態の見直し
- ローディング表示の見直し

---

## Version 1.2 候補

MVP後、アプリの価値を高める機能。

### 複数写真

- メイン写真以外の追加写真
- ギャラリー写真
- 着用写真
- 箱写真
- 写真並び替え

### 箱管理

- 箱あり / なし
- 箱写真
- 箱メモ
- 付属品メモ

### 統計

- 登録数
- ブランド別数
- 状態別数
- 着用回数
- 最近履いた靴
- よく履く靴

### 検索・フィルター拡張

- サイズフィルター
- カラーフィルター
- 購入年フィルター
- TOP5フィルター
- 着用済み / 未着用フィルター

---

## Version 1.3 候補

共有・展示体験を強化する機能。

### SNS共有

- Collection共有画像
- Sticker Board共有画像
- TOP5共有画像
- PNG出力

### Sticker拡張

- Sticker自由配置
- Sticker拡大縮小
- Sticker回転
- 背景テーマ
- Boardテンプレート

### テーマ

- Dark / Light
- モノクロテーマ
- オレンジアクセントテーマ
- Premiumテーマ

---

## Version 1.4以降 候補

大きめの機能。MVP後に需要を見て判断する。

### Cloud / Sync

- Google Drive連携
- クラウド同期
- 複数端末同期
- 自動バックアップ

### Account

- ログイン
- アカウント連携
- データ引き継ぎ

### AI機能

- スニーカー説明文生成
- タグ提案
- 写真から情報補助
- Collection紹介文生成

### Brand / Model Factory再開

- data/*.json と app/assets/data/*.json の同期自動化
- Tier S / Tier A のモデル追加
- Alias / searchKeywords 品質監査
- Factory提案JSONからPR作成

---

## Release 1.0 には含めないもの

以下は、Release 1.0には含めない。

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

## 新しいアイデアの扱い

MVPリリース前に新しいアイデアが出た場合は、以下のルールで扱う。

```text
1. すぐ実装しない
2. このPOST_RELEASE.mdへ追加する
3. MVPリリース後に優先順位を決める
4. 必要ならIssue化する
```

---

## 優先順位の考え方

MVP後は、以下の順で判断する。

1. ユーザーのデータを守る機能
2. 継続利用につながる機能
3. 共有・展示体験を強くする機能
4. 課金につながる機能
5. 開発者都合の改善

---

## MVP前の禁止事項

Release 1.0前は、以下を避ける。

- 新しい大型機能の実装
- 大規模リファクタリング
- DBの不要な大変更
- Brand / Model Factory作業への復帰
- Premiumの作り込み
- クラウド同期の着手
- SNS共有の着手

---

## 関連文書

- `docs/HANDOFF_KICKXKICK_MVP_2026-06-25.md`
- `docs/HANDOFF_BRAND_MODEL_SEARCH.md`
- `docs/MVP_RELEASE_CHECKLIST.md`
- `docs/RELEASE_PLAN.md`

---

## 最終メモ

この文書は「やらないことリスト」でもある。

MVPリリース前に迷ったら、まず `docs/RELEASE_PLAN.md` と `docs/MVP_RELEASE_CHECKLIST.md` を優先する。
