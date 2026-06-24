# Kick×Kick Routing Specification v1.0

## 1. 目的

この仕様書は Kick×Kick の画面遷移を定義する。

対象:

- Bottom Navigation
- Home
- Collection
- Sticker
- Settings
- スニーカー登録
- スニーカー詳細
- ステッカー生成
- バックアップ / 復元
- 初回体験

## 2. 基本ナビゲーション

Bottom Navigation:

```text
Home
Collection
＋
Sticker
Settings
```

中央FAB:

```text
スニーカー追加
```

## 3. 初回起動フロー

```text
App Launch
↓
Onboarding
↓
最初の一足を登録
↓
ステッカー生成
↓
Sticker Board
```

初回はHomeに戻さない。
Kick×Kickの価値である「貼って遊ぶ」体験まで進める。

## 4. 通常起動フロー

```text
App Launch
↓
Home
```

ただし各タブでは最後に見ていた状態を復元する。

Collection:

```text
Collection Tab
↓
Last Viewed Collection
```

Sticker:

```text
Sticker Tab
↓
Last Viewed Sticker Board
```

## 5. Homeルート

```text
Home
├─ TOP5 item → Sneaker Detail
├─ Collection preview → Collection Tab
├─ Sticker preview → Sticker Tab
├─ Recently Added Sneaker → Sneaker Detail
└─ Statistics → Statistics Detail
```

## 6. スニーカー追加ルート

中央FABまたはCollection編集モードから開始する。

```text
FAB
↓
Sneaker Form
↓
Photo Select / Camera
↓
Basic Info Input
↓
Save
↓
Sticker Generate Prompt
```

初回登録時:

```text
Save
↓
Sticker Generate
↓
Sticker Board
```

通常登録時:

```text
Save
↓
Sneaker Detail
```

## 7. スニーカー詳細ルート

```text
Sneaker Detail
├─ Edit → Sneaker Form
├─ Add to TOP5 → TOP5 Select / Replace
├─ Wore Today → Wear History Add
├─ Add Past Wear → Wear History Date Select
├─ Generate Sticker → Sticker Generate
├─ Add to Collection → Collection Select
├─ Photo Manage → Photo Category Edit
└─ Delete → Trash Confirm
```

## 8. スニーカー編集ルート

```text
Sneaker Detail
↓
Edit
↓
Sneaker Form
↓
Save
↓
Sneaker Detail
```

キャンセル時:

```text
Sneaker Form
↓
Sneaker Detail
```

## 9. 写真管理ルート

```text
Sneaker Detail
↓
Photo Manage
├─ Shoe Photo Category
└─ Box Photo Category
```

同カテゴリに新しい写真を登録する場合:

```text
Select Photo
↓
Replace Confirm
↓
Save
```

## 10. ステッカー生成ルート

```text
Sneaker Detail
↓
Generate Sticker
↓
Source Photo Select
↓
Auto Background Remove
↓
Preview
├─ Save
└─ Edit Mask
```

修正時:

```text
Preview
↓
Edit Mask
├─ Eraser
├─ Restore
├─ Zoom
├─ Undo
└─ Redo
↓
Preview
↓
Save
```

保存後:

```text
Save
↓
Sticker Board Select
↓
Place on Board
```

Freeで同じスニーカーの2枚目ステッカーを作る場合:

```text
Generate Sticker
↓
Premium Prompt
```

## 11. Collectionルート

```text
Collection Tab
↓
Last Viewed Collection
```

通常UI:

```text
Collection View
├─ Shelf List
├─ Edit Mode
└─ Sneaker Item → Sneaker Detail
```

棚一覧:

```text
Shelf List
├─ Select Shelf → Collection View
├─ Create Shelf → Collection Edit
└─ Delete Shelf → Delete Confirm
```

Freeで2棚目を作る場合:

```text
Create Shelf
↓
Premium Prompt
```

## 12. Collection編集ルート

```text
Collection View
↓
Edit
↓
Collection Edit Mode
├─ Add Sneaker
├─ Change Background
├─ Toggle Box Display
├─ Reorder
└─ Save
```

スニーカー追加:

```text
Add Sneaker
↓
Sneaker Select
↓
Slot Placement
↓
Save
```

背景変更:

```text
Change Background
↓
Theme Select
↓
Apply Preview
↓
Save
```

Premiumテーマ選択時:

```text
Theme Select
↓
Premium Prompt
```

## 13. Stickerルート

```text
Sticker Tab
↓
Last Viewed Sticker Board
```

Sticker Board:

```text
Sticker Board
├─ Board List
├─ Add Sticker
├─ Edit Item
├─ Undo
├─ Redo
└─ Export PNG
```

Board一覧:

```text
Board List
├─ Select Board → Sticker Board
├─ Create Board → New Board
└─ Delete Board → Delete Confirm
```

Freeで2枚目のBoardを作る場合:

```text
Create Board
↓
Premium Prompt
```

## 14. Sticker Board編集ルート

ステッカー操作:

```text
Sticker Item
├─ Drag Move
├─ Tap Lock / Unlock
├─ Long Press Rotate
├─ Pinch Scale
├─ Duplicate
├─ Bring Front
└─ Delete
```

削除:

```text
Sticker Item
↓
Drag to Trash / Menu Delete
↓
Remove from Board
```

複製:

```text
Duplicate
↓
Offset Copy Created
```

## 15. PNG出力ルート

```text
Sticker Board
↓
Export PNG
↓
Size Select
├─ 512
├─ 1024
└─ 2048
↓
Export
```

Freeの場合:

```text
Export PNG
↓
Premium Prompt
```

出力種別:

- 靴ステッカー: 透過PNG
- 箱ステッカー: 透過PNG
- レイアウト: 背景ありPNG

## 16. Settingsルート

```text
Settings
├─ Premium
├─ Backup
├─ Restore
├─ Trash
├─ Theme / Display
├─ Onboarding Replay
└─ Legal
```

## 17. Backup / Restoreルート

Backup:

```text
Settings
↓
Backup
↓
Destination Select
├─ Google Drive
├─ OneDrive
├─ Dropbox
└─ Device
↓
Export .kkb
```

Restore:

```text
Settings
↓
Restore
↓
Select .kkb
↓
Confirm
↓
Restore Complete
```

Freeの場合:

```text
Backup / Restore
↓
Premium Prompt
```

## 18. Trashルート

```text
Settings
↓
Trash
↓
Trash List
├─ Restore Item
└─ Delete Permanently
```

30日後:

```text
Auto Permanent Delete
```

ゴミ箱内データはFree制限にカウントしない。

## 19. Premium Promptルート

Premium誘導は強くしすぎない。

強い誘導:

1. 6足目登録
2. 同じスニーカーで2つ目のステッカー作成

軽い案内:

- 2個目のCollection作成
- 2枚目のSticker Board作成
- PNG出力
- バックアップ
- Premiumテーマ
- Premiumフォント

## 20. 戻る操作方針

基本:

- 入力中は確認ダイアログを出す
- 保存済みなら前画面へ戻る
- Bottom Navigation間の移動では入力中データを破棄しない設計を検討する

## 21. MVP優先ルート

Sprint1で実装するルート:

```text
Home
FAB
Sneaker Form
Sneaker Detail
Wear History
TOP5
```

Sprint2:

```text
Collection
Collection Edit
Shelf List
```

Sprint3:

```text
Sticker Board
Sticker Generate
Sticker Edit
```

Sprint4:

```text
Settings
Trash
Backup
Restore
Premium Prompt
```

## 22. 最重要ルール

初回体験ではHomeに戻さずSticker Boardまで進める。

Collectionは整列展示。
Stickerは自由配置。

画面遷移もこの思想を崩さない。