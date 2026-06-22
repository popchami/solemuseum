# SoleMuseum Design Improvement Specification v1.0

## 1. Purpose

This document defines the next design improvement direction for SoleMuseum.

The current app is functionally advanced, but the visual quality still feels close to a standard personal Flutter app.

The goal of this design improvement sprint is to make SoleMuseum feel more like a premium digital museum for sneaker collections.

---

## 2. Current Problems

### 2.1 Font Rendering Problem

The current app sets the following font family in `AppTheme`:

```dart
fontFamily: 'Noto Sans JP'
fontFamilyFallback: ['Noto Sans CJK JP', 'sans-serif']
```

However, the actual Android rendering appears visually incorrect.

Observed issue:

- Japanese glyphs look distorted
- The kanji shape does not look like normal Noto Sans JP
- The app may be falling back to an Android system font
- The app may not have an actual font asset bundled

### Required Action

Before changing the visual language, confirm whether the font file is actually included in the Flutter project.

Check:

```yaml
flutter:
  fonts:
```

If no bundled font exists, the app must not rely only on `fontFamily` names.

---

## 3. Font Direction

### Recommended Direction

Use a bundled font strategy.

Primary recommendation:

```text
English / numbers: Inter
Japanese fallback: Noto Sans JP or IBM Plex Sans JP
```

Alternative:

```text
All text: IBM Plex Sans JP
```

### Reason

SoleMuseum uses many English labels:

- SoleMuseum
- Collect. Record. Exhibit.
- MY COLLECTION
- MY TOP 5
- Archive number

A clean Latin font is important for the brand impression.

Japanese text must remain readable and clean.

### Implementation Rule

Do not rely on OS fallback only.

Font files must be bundled and declared in `pubspec.yaml` before assigning `fontFamily`.

---

## 4. Floating Action Button Improvement

### Current Problem

The current `+` floating action button feels generic and visually weak.

It gives the impression of a default Flutter sample app.

### Required Direction

Replace the simple circular `+` FAB with a more intentional museum-style action.

Preferred labels:

```text
収蔵する
```

or

```text
Add Sneaker
```

or

```text
Archive
```

### Recommended Choice

Use:

```text
収蔵する
```

Reason:

- Matches the museum concept
- Feels less generic than `+`
- Clearly expresses the act of adding a sneaker to the collection

### Visual Direction

Use an extended FAB instead of a small circular FAB.

Example behavior:

```text
[ museum/archive icon ] 収蔵する
```

The button should feel like a primary museum action, not a generic add button.

---

## 5. Visual Quality Improvement

### Current Problem

The current UI works, but still feels plain.

The likely causes are:

- Too much default Material appearance
- Standard Material icons
- Flat white cards
- Weak visual hierarchy
- Lack of branded assets
- Empty states feel generic
- Home screen does not yet feel like a museum entrance

---

## 6. Required Asset Direction

To reduce the personal-development feel, the app should introduce branded assets.

### Required Assets

1. App logo
2. App icon
3. Empty state illustration
4. Museum-style background or header texture
5. Custom archive / exhibition icons
6. Optional TOP 5 visual badge

### Empty State Direction

Avoid generic messages such as:

```text
コレクションがありません
```

Use brand-oriented wording:

```text
まだ展示品がありません
最初の一足を収蔵しましょう
```

or

```text
あなたのミュージアムはまだ空です
最初のスニーカーを展示しましょう
```

---

## 7. Home Screen Direction

### Current Sections

```text
MY COLLECTION
最近追加
最近履いた
MY TOP 5
```

### Improved Direction

The Home screen should feel like the entrance to a personal museum.

Recommended section naming:

```text
MUSEUM OVERVIEW
RECENT ARCHIVES
RECENTLY WORN
MY TOP 5
BRAND COLLECTION
```

Japanese alternatives:

```text
ミュージアム概要
最近の収蔵品
最近履いた一足
MY TOP 5
ブランド別コレクション
```

### Rule

English labels may be used for premium tone, but Japanese explanations should support usability.

---

## 8. Card Design Direction

### Current Problem

Cards feel too flat and default.

### Required Direction

Sneaker cards should feel like museum exhibit cards.

Recommended elements:

- Large photo area
- Archive number
- Brand name as small label
- Model name as primary title
- Favorite marker as small badge
- Subtle border instead of heavy elevation
- More intentional spacing

### Avoid

- Heavy shadows
- Bright accent colors
- SNS-like decoration
- Marketplace-style price emphasis

---

## 9. Pricing Direction

### Previous Direction

Pro price candidate:

```text
980円
```

### Revised Recommendation

Use a simple paid unlock model.

```text
Free: up to 5 sneakers
Premium: one-time purchase 300〜500円
```

### Recommended Final Candidate

```text
Free: 5 sneakers
Premium: 500円 one-time purchase
```

### Unlock Benefits

Premium unlocks:

- Unlimited sneaker registration
- Multiple photos
- MY TOP 5
- Backup and restore

### Notes

300円 is easy to buy, but may feel too cheap for a premium collection app.

500円 is still affordable and gives the app more perceived value.

---

## 10. Priority Order

### Priority A

Fix font rendering.

- Bundle actual font files
- Register fonts in `pubspec.yaml`
- Confirm Japanese glyph rendering on Android

### Priority B

Replace the default `+` FAB.

- Use extended FAB
- Label: `収蔵する`
- Use archive or museum-style icon

### Priority C

Improve Home screen visual quality.

- Add museum-oriented wording
- Add branded section hierarchy
- Improve spacing and card presentation

### Priority D

Create and integrate branded assets.

- Logo
- Empty state illustration
- Museum header / background
- TOP 5 badge

### Priority E

Finalize monetization.

- Free limit: 5 sneakers
- Premium: 500円 one-time purchase

---

## 11. Definition of Done

This design improvement sprint is complete when:

- Japanese font rendering looks normal on Android
- FAB no longer looks like a default Flutter sample button
- Home screen feels like a museum entrance
- Empty states use SoleMuseum-specific language
- Sneaker cards feel more like exhibit cards
- Pricing direction is documented and ready for implementation
