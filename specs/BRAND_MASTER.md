# Kick×Kick Brand Master

## Purpose

Kick×Kickで使用するブランドマスターを管理する。

このファイルは、ブランド候補・モデルマスター・今後の追加予定を管理するための基準ファイルである。

ユーザー満足度を基準に、以下を重視する。

- 登録時に主要ブランドが候補に出ること
- 各ブランドの代表モデルが候補に出ること
- 候補にない場合も自由入力できること
- ブランドロゴや商標素材は扱わないこと

---

## Tier S

最重要ブランド。

モデルマスターの品質監査を最優先する。

- Nike
- Air Jordan
- adidas
- New Balance
- ASICS

---

## Tier A

登録頻度が高く、スニーカー・ランニング・ライフスタイル層に重要なブランド。

- Salomon
- HOKA
- On
- PUMA
- Converse
- Vans
- Reebok
- Onitsuka Tiger

---

## Tier B

ランニング・アウトドア・日本ユーザー向けに重要なブランド。

- Mizuno
- Saucony
- Brooks
- Merrell
- KEEN
- Danner

---

## Tier C

クラシック・日本・欧州系のコレクター満足度を高めるブランド。

- Karhu
- Diadora
- Patrick
- K-Swiss
- le coq sportif
- Lacoste
- MoonStar
- SPINGLE

---

## Tier D

スポーツ・ランニング・ウォーキング系の補完ブランド。

- FILA
- Skechers
- Under Armour
- Altra
- Topo Athletic

---

## Tier E

普段履き・ライフスタイル・サンダル・ブーツ系の補完ブランド。

- Crocs
- Birkenstock
- Clarks
- Dr. Martens
- UGG
- Veja

---

## Planned

今後追加予定のブランド。

- Li-Ning
- ANTA
- Peak
- 361°
- Xtep
- Timberland
- Red Wing
- Camper
- Autry
- Common Projects

---

## Fallback

- Other

---

## Model Master File Rule

ブランドごとのモデル候補は以下に配置する。

```text
specs/MODEL_MASTER/{BRAND_FILE_NAME}.md
```

例:

```text
specs/MODEL_MASTER/NIKE.md
specs/MODEL_MASTER/AIR_JORDAN.md
specs/MODEL_MASTER/ADIDAS.md
```

---

## Completion Policy

ブランド追加は、単にブランド名を増やすだけでは完了としない。

各ブランドについて、最低限以下を満たす。

- 代表モデルを登録する
- 検索されやすい別名候補を記載する
- ブランド好きが見ても大きな違和感がない状態にする

---

## Priority Rule

今後の優先順位は以下とする。

1. Tier S のモデルマスター監査
2. Planned ブランドの追加
3. Tier A / B のモデル補強
4. Tier C 以降の拡張

---

## Important Note

Kick×Kickは全世界の全モデルを完全網羅することを目的にしない。

目的は、ユーザーが登録時に「自分のブランド・モデルがある」と感じられる候補体験を作ることである。

そのため、候補にないブランド・モデルも自由入力できる仕様を必ず維持する。
