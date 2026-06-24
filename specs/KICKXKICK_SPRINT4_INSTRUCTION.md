# Kick×Kick Sprint4 Implementation Instruction

## 1. 目的

Sprint4ではPremium機能・PNG出力・ゴミ箱・バックアップ・復元を実装する。

Sprint1〜3で完成した体験を保護し、製品として成立させる段階である。

最優先は以下。

- Free制限
- Premium判定
- PNG出力
- ゴミ箱
- 復元
- .kkbバックアップ
- .kkb復元

## 2. 前提

Sprint1〜3完了。

既存機能:

- Sneaker
- TOP5
- Wear History
- Collection
- Sticker Board
- Sticker Generate

## 3. 参照仕様

```text
specs/KICKXKICK_MONETIZE.md
specs/KICKXKICK_BACKUP.md
specs/KICKXKICK_DB_SPEC.md
specs/KICKXKICK_ROUTING_SPEC.md
```

## 4. Free制限

### Free

- スニーカー5足
- Collection 1棚
- Sticker Board 1枚
- 1足につき1ステッカー
- Freeテーマ
- Freeフォント

### Premium

- スニーカー無制限
- Collection無制限
- Sticker Board無制限
- 複数ステッカー
- PNG出力
- バックアップ
- 復元
- 全テーマ
- Premiumフォント

## 5. Premium誘導

強い誘導:

1. 6足目登録
2. 同じスニーカーの2枚目ステッカー

軽い案内:

- 2個目Collection
- 2枚目Board
- PNG出力
- Backup
- Premiumテーマ
- Premiumフォント

## 6. PNG出力

出力サイズ:

- 512
- 1024
- 2048

出力形式:

- Shoe Sticker PNG
- Box Sticker PNG
- Layout PNG

透過PNG対応。

## 7. ゴミ箱

保持期間:

30日

復元対象:

- スニーカー
- 写真
- 箱写真
- ステッカー
- 履歴
- TOP5
- 棚配置

30日後は完全削除。

ゴミ箱内はFree制限に含めない。

## 8. バックアップ

拡張子:

```text
.kkb
```

保存対象:

- スニーカー
- 写真
- 箱写真
- ステッカー
- Collection
- Sticker Board
- TOP5
- 履歴
- 設定

保存先:

- Google Drive
- OneDrive
- Dropbox
- Device

## 9. Provider

推奨:

```text
premiumProvider
backupProvider
trashProvider
exportProvider
```

## 10. 完了条件

- 6足目制限が動作
- 2枚目ステッカー制限が動作
- PNG出力できる
- ゴミ箱へ移動できる
- 復元できる
- .kkb生成できる
- .kkb復元できる
- Free/Premium判定が機能する

## 11. 注意

課金を主役にしない。

Premiumは展示体験を拡張するための機能として扱う。