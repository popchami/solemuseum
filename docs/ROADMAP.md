# Kick×Kick Roadmap v1.0

## v1.0 Goal

Kick×Kick v1.0 は、スニーカーを「登録・ステッカー化・展示」できるコレクションアプリとして成立することを目標とする。

---

## Current Source of Truth

This roadmap is being migrated from older documents.

Current app name and product direction:

```text
Kick×Kick
```

Current product focus:

```text
Collect
Create
Exhibit
```

Important current specs:

```text
specs/KICKXKICK_PRODUCT.md
specs/KICKXKICK_UI_SPEC.md
specs/KICKXKICK_DATA.md
specs/KICKXKICK_DB_SPEC.md
specs/KICKXKICK_BRAND_MODEL_CATALOG.md
specs/BRAND_MASTER.md
```

---

## Sprint Status

### Sprint1: App Foundation

Status: Completed

- Flutter app foundation
- Material 3 theme
- Riverpod setup
- Bottom navigation
- Home screen
- Collection screen
- Settings screen
- Shared FAB

### Sprint2: Collection CRUD

Status: Code Review Completed

- SQLite database
- Brand model
- Shoe model
- Brand repository
- Shoe repository
- Riverpod providers
- Shoe registration
- Shoe list
- Shoe detail
- Shoe edit
- Shoe delete

### Sprint3: Photo Foundation

Status: Code Complete — Runtime Verification Pending

- Photo model
- Photos table
- Photo repository
- Photo provider
- Image picker
- Local photo storage
- Main photo
- Gallery photos
- Box photos

### Sprint4: Wear History Foundation

Status: Code Complete — Runtime Verification Pending

- Wear log model
- wear_logs table
- Today worn action
- Wear history on detail screen
- Recent worn section on home screen

### Sprint5: Home / TOP5 / Statistics

Status: Code Complete — Runtime Verification Pending

- TOP5
- Recently added
- Recently worn
- Collection summary
- Brand ownership summary

### Sprint6: Backup Foundation

Status: Code Complete — Runtime Verification Pending

- JSON export
- JSON import
- Local backup
- Restore confirmation

---

## Brand / Model Data Foundation

Status: Specification Started

- Brand master
- Brand aliases
- Model master
- Model aliases
- Candidate selection
- Free input fallback

---

## v1.0 Completion Criteria

Kick×Kick v1.0 is complete when users can:

- Register sneakers
- Add photos
- View collection
- Track wear history
- Set TOP5
- Create and display stickers
- Back up local data

---

## Development Principle

Priority order:

1. Finish runtime verification
2. Stabilize photo and wear history
3. Stabilize TOP5 and Home
4. Complete brand / model master foundation
5. Prepare v1.0 release
