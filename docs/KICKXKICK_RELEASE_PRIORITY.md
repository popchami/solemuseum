# Kick×Kick Release Priority v1.0

## Purpose

このファイルは、Kick×Kick開発の最優先事項を明確にする。

結論:

```text
最優先は Kick×Kick をリリースまで持っていくこと。
```

---

## Priority

Kick×Kickの目的は、検索データベースやFactoryそのものを完成させることではない。

目的は、ユーザーがスニーカーを簡単に登録し、コレクションとして楽しめるアプリを完成させることである。

---

## Search / Registration Position

ブランド・モデル検索は重要だが、Kick×Kick全体の一部機能である。

役割:

```text
ユーザーがブランド・モデルを簡単に登録できるようにする
入力ミスを減らす
正式名称で保存しやすくする
低評価につながる登録ストレスを減らす
```

ただし、候補がない場合でも自由入力できることを必須とする。

---

## Master Data Position

ブランド・モデルデータは増え続ける。

そのため、完全完成を待ってリリースしてはいけない。

方針:

```text
MVPに必要な品質まで整える
不足分は自由入力で補う
リリース後も継続的に育てる
```

---

## Factory Position

AI Data Factory は目的ではなく手段である。

役割:

```text
ユーザー本人がなるべく手を動かさずに済むようにする
ブランド・モデル・Alias・searchKeywordsの追加を楽にする
AIが候補作成と監査を行い、ユーザーは承認するだけに近づける
```

Factory開発がKick×Kick本体開発を止めてはいけない。

---

## Development Rule

今後の優先順位は以下とする。

```text
1. Kick×KickアプリのMVP完成
2. 登録・検索UXの実装
3. data/*.json の読み込み
4. 自由入力fallback
5. 写真・TOP5・着用履歴
6. Collection / Sticker
7. Premium / Backup / Export
8. データFactoryの継続改善
```

---

## Release Principle

ブランド・モデルデータは完璧でなくてもよい。

ただし、以下は必須。

```text
- 主要ブランドが候補に出る
- 主要モデルが候補に出る
- Alias検索が最低限効く
- 数字検索が最低限効く
- 候補がない場合でも自由入力できる
- 保存後に編集できる
```

---

## Final Rule

```text
Factory is support.
Kick×Kick release is the goal.
```

AIや自動化は、Kick×Kick完成を早めるために使う。

Kick×Kick本体のリリースを遅らせるほど、Factory開発を広げない。
