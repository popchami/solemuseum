# Sprint4 Specification

## Sprint Name

History Foundation

## Objective

スニーカーを所有するだけでなく、実際に履いた記録を端末内へ残せるようにする。

## Scope

- WearLog model
- wear_logs table
- Database migration version 2 → 3
- 「今日履いた」アクション
- 任意メモ
- Detail画面の着用履歴
- Home画面の最近履いた一覧
- 着用記録の削除

## Data Model

wear_logs

| Column | Type | Required |
| --- | --- | --- |
| id | INTEGER | YES |
| shoe_id | INTEGER | YES |
| worn_date | TEXT | YES |
| memo | TEXT | NO |
| created_at | TEXT | YES |

## Rules

- 1足につき1日1件
- 同じ日付の重複登録は行わない
- メモは任意
- 日付の新しい順に表示
- スニーカー削除時は関連する着用記録も削除

## Completion Criteria

- 既存DBをversion 3へ移行できる
- 今日の着用を記録できる
- 重複登録を防止できる
- Detail画面で履歴を確認・削除できる
- Home画面で最近履いたスニーカーを確認できる
