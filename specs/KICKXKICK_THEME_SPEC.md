# Kick×Kick Theme Specification v1.0

## 1. Purpose

This document defines the visual theme direction for Kick×Kick.

Kick×Kick is not a simple sneaker management app.
It is a sneaker collection app based on the concept:

```text
貼って、飾って、コレクション。
```

The design must support three feelings:

- Collect: register and keep sneakers
- Create: turn sneakers into stickers
- Exhibit: decorate shelves and boards

The user's sneaker photos are always the main content.
Theme assets must support the photos without competing with them.

---

## 2. Final Theme Lineup

### Free Theme

#### Scrapbook Collage

This is the default free theme.

Concept:

- Scrapbook
- Magazine cut-outs
- Paper texture
- Masking tape
- Handwritten notes
- Casual collage

Role:

- Default first impression of Kick×Kick
- Easy for all users to understand
- Simple enough to keep sneaker photos as the main focus

---

### Premium Theme 1

#### Pop Illustration Street

This is a Premium-only theme.

Concept:

- Street art
- Pop illustration
- Graffiti
- Neon stickers
- Speech bubbles
- Cool and energetic visual style

Role:

- Premium theme for users who want a stronger visual identity
- Best for users who like sneakers, street culture, and bold layouts

---

### Premium Theme 2

#### Pop Colorful Girly

This is a Premium-only theme.

Concept:

- Colorful pop illustration
- Cute stickers
- Pastel colors
- Hearts, stars, ribbons, rainbows
- Bright and playful girly scrapbook style

Role:

- Premium theme for users who prefer cute, colorful and cheerful designs
- Helps Kick×Kick appeal beyond only sneaker/street users

---

## 3. Theme Availability

| Theme | Availability | Pricing |
|---|---|---|
| Scrapbook Collage | Free | Included |
| Pop Illustration Street | Premium | Paid unlock |
| Pop Colorful Girly | Premium | Paid unlock |

Rules:

- Free users can use Scrapbook Collage.
- Premium users unlock all themes.
- Themes change visual presentation and image assets only.
- Core features must not depend on the selected theme.
- Premium themes should feel clearly more decorative than the free theme.

---

## 4. Shared Visual Rules

These rules apply to all themes.

### Main Principle

User sneaker photos must be the hero.

Do:

- Use simple backgrounds.
- Use illustrated or paper-like assets.
- Keep decoration around the edges.
- Leave enough white space.
- Use orange as a brand accent.

Do not:

- Use realistic fixed sneaker photos as theme assets.
- Use busy photo backgrounds.
- Place decorations over important sneaker photo areas.
- Make theme assets stronger than user photos.
- Make the UI difficult to read.

---

## 5. Theme Color Direction

### Scrapbook Collage / Free

Color direction:

- White
- Warm off-white
- Light beige
- Light gray
- Black
- Orange accent

Usage:

- Base is bright and clean.
- Orange is used for active tabs, small labels, CTA accents and sticker outlines.
- Decoration should be restrained.

Suggested palette:

```text
Background: #FAF7F1
Surface:    #FFFFFF
Paper:      #EFE2CF
Line:       #222222
Muted:      #9B9B9B
Accent:     #FF6A00
```

---

### Pop Illustration Street / Premium

Color direction:

- Black
- Charcoal
- White
- Neon yellow
- Cyan
- Magenta
- Orange accent

Usage:

- Dark base is allowed.
- Sneakers and cards must remain readable.
- Use neon decorations carefully.
- The theme should feel cool and premium.

Suggested palette:

```text
Background: #0F0F10
Surface:    #1A1A1D
Card:       #222228
Text:       #FFFFFF
NeonYellow: #EFFF3A
Cyan:       #25D9FF
Magenta:    #FF4FB8
Accent:     #FF6A00
```

---

### Pop Colorful Girly / Premium

Color direction:

- White
- Soft pink
- Mint
- Lavender
- Yellow
- Sky blue
- Orange accent

Usage:

- Base should stay bright and soft.
- Decorations can be cute and colorful.
- Avoid making it look childish; keep the UI clean.
- Use rounded cards and friendly icons.

Suggested palette:

```text
Background: #FFF7FB
Surface:    #FFFFFF
Pink:       #FF8BB8
Mint:       #8FE8D1
Lavender:   #B9A7FF
Yellow:     #FFE680
SkyBlue:    #8ED8FF
Accent:     #FF6A00
```

---

## 6. Image Asset Requirements

The following image assets are required.

| Screen | Placement | Recommended Size | Ratio | Purpose | Count |
|---|---:|---:|---:|---|---:|
| Home | Header | 1440x720 | 2:1 | Worldview expression | 1 |
| Collection | Empty State | 800x800 | 1:1 | First sneaker registration guidance | 1 |
| Sticker | Empty State | 800x800 | 1:1 | First sticker board guidance | 1 |
| Sticker | Board Background | 1080x1350 | 4:5 | Paper, desk, scrapbook board | 3 |
| Detail | Main photo frame | 1200x900 | 4:3 | User photo display frame | No extra asset required |
| Registration | Photo not selected | 800x600 | 4:3 | Photo selection guidance | 1 |
| Common | Photo Placeholder | 600x600 | 1:1 | No photo display | 1 |
| Wear History | Empty State | 800x600 | 4:3 | First wear log guidance | 1 |

Base required asset count per theme:

```text
9 images
```

---

## 7. Recommended Asset File Names

Use theme-specific folders.

```text
assets/images/themes/scrapbook/home_header.png
assets/images/themes/scrapbook/empty_collection.png
assets/images/themes/scrapbook/empty_sticker.png
assets/images/themes/scrapbook/sticker_board_paper_01.png
assets/images/themes/scrapbook/sticker_board_desk_01.png
assets/images/themes/scrapbook/sticker_board_scrapbook_01.png
assets/images/themes/scrapbook/photo_select_placeholder.png
assets/images/themes/scrapbook/photo_placeholder.png
assets/images/themes/scrapbook/empty_wear_history.png

assets/images/themes/street/home_header.png
assets/images/themes/street/empty_collection.png
assets/images/themes/street/empty_sticker.png
assets/images/themes/street/sticker_board_paper_01.png
assets/images/themes/street/sticker_board_desk_01.png
assets/images/themes/street/sticker_board_scrapbook_01.png
assets/images/themes/street/photo_select_placeholder.png
assets/images/themes/street/photo_placeholder.png
assets/images/themes/street/empty_wear_history.png

assets/images/themes/girly/home_header.png
assets/images/themes/girly/empty_collection.png
assets/images/themes/girly/empty_sticker.png
assets/images/themes/girly/sticker_board_paper_01.png
assets/images/themes/girly/sticker_board_desk_01.png
assets/images/themes/girly/sticker_board_scrapbook_01.png
assets/images/themes/girly/photo_select_placeholder.png
assets/images/themes/girly/photo_placeholder.png
assets/images/themes/girly/empty_wear_history.png
```

---

## 8. Screen Direction

### Home

Purpose:

- Express Kick×Kick's world.
- Make the user want to collect and decorate sneakers.

Free theme:

- Scrapbook header.
- Paper scraps and tape.
- Small sneaker sticker motifs.

Premium Street:

- Black or dark header.
- Graffiti and neon stickers.
- Street-style energy.

Premium Girly:

- Pastel header.
- Hearts, stars, ribbons and cute sticker motifs.
- Cheerful and friendly look.

---

### Collection

Purpose:

- Show the user's sneaker photos clearly.

Rules:

- Cards must stay readable.
- Decoration must be minimal.
- Empty state can use illustration.
- Collection screen should not become too busy.

---

### Sticker

Purpose:

- Make the user feel like they are creating a board.

Rules:

- Board backgrounds are the most important theme assets.
- Free theme uses paper and scrapbook textures.
- Street theme uses dark paper, graffiti wall, or sticker wall motifs.
- Girly theme uses pastel paper, grid paper, heart pattern or cute notebook motifs.

---

### Settings

Purpose:

- Functional screen.

Rules:

- Keep clean and simple.
- Use theme colors only for icons, accents and small decorations.
- Do not make Settings look too decorative.

---

### Registration

Purpose:

- Guide the user to select or take a sneaker photo.

Rules:

- Use simple line illustration.
- Keep the photo selection area clear.
- No strong decorative background.

---

### Detail

Purpose:

- Show the sneaker photo and details.

Rules:

- The photo is the main content.
- Theme decoration should only appear as frame corners or small labels.
- Avoid placing decorative assets over the sneaker image.

---

## 9. AI Image Generation Rules

When generating assets with AI, follow these rules.

### Common Prompt Requirements

Include:

```text
mobile app UI asset, scrapbook collage style, sticker collection app, sneaker sticker motif, illustrated paper texture, clean layout, no realistic photo background, user sneaker photo must be the main focus, orange accent, high quality, flat illustration, no real brand logos
```

Avoid:

```text
realistic sneaker product photo, famous brand logo, Nike logo, Adidas logo, crowded background, unreadable text, photorealistic collage, luxury museum style
```

Important:

- Do not generate real brand logos.
- Do not generate realistic product photos as fixed assets.
- Text in generated images should be minimal because AI text may break.
- Final text can be added later in Canva or Flutter.

---

## 10. Theme Prompt Seeds

### Scrapbook Collage

```text
scrapbook collage theme, warm paper texture, masking tape, magazine cut-out style, hand drawn doodles, sneaker sticker motifs, simple casual design, white and beige background, small orange accent, clean mobile app asset, no real brand logos, no photorealistic background
```

### Pop Illustration Street

```text
pop illustration street theme, black background, neon graffiti doodles, sticker bomb style, speech bubbles, energetic street art, sneaker sticker motifs, cyan magenta yellow orange accents, premium mobile app asset, no real brand logos, no photorealistic background
```

### Pop Colorful Girly

```text
pop colorful girly theme, pastel scrapbook design, cute stickers, hearts, stars, ribbons, rainbow doodles, soft pink mint lavender yellow palette, cheerful sneaker sticker motifs, clean mobile app asset, no real brand logos, no photorealistic background
```

---

## 11. Implementation Notes

- Theme selection should be stored locally.
- Free users can select only Scrapbook Collage.
- Premium unlock enables Street and Girly themes.
- Theme assets should be loaded by theme key.

Suggested theme keys:

```text
scrapbook
street
 girly
```

Correct keys:

```text
scrapbook
street
girly
```

Suggested enum:

```dart
enum AppThemeId {
  scrapbook,
  street,
  girly,
}
```

---

## 12. MVP Decision

For Release 1.0:

- Implement Scrapbook Collage first.
- Premium themes can be prepared as design specifications first.
- If implementation time is limited, Premium theme switching can be moved after MVP.
- Do not delay core MVP features for theme expansion.

Priority:

1. Scrapbook Collage visual baseline
2. Theme asset folder structure
3. Theme selection data model
4. Premium theme lock UI
5. Premium Street assets
6. Premium Girly assets
