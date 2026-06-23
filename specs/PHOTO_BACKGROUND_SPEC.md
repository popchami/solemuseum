# Photo Background Processing Specification v1.0

## 1. Purpose

SoleMuseum / sneaker collection UI should allow users to control how sneaker photos are displayed.

When registering or adding a photo, the user should be able to choose whether the photo keeps its original background, removes the background, or uses a custom display background.

This feature is intended to make the Collection screen feel closer to a sneaker collector display shelf rather than a simple database list.

---

## 2. User Options

When a user selects a sneaker photo, show a photo display mode selection step.

### Option A: Original Photo

```text
写真のまま
```

Behavior:

- Keep the selected photo as-is
- Background remains unchanged
- Fastest and safest option
- No image processing required

Use case:

- Room photos
- Box photos
- Lifestyle photos
- Photos where the background is part of the memory

---

### Option B: Cutout / Transparent PNG

```text
切り抜き
```

Behavior:

- Remove the original photo background
- Save the sneaker as a transparent PNG when possible
- Display the sneaker over the app's default collection background

Use case:

- Clean sneaker catalog display
- Collection grid
- Sneaker shelf view
- Product-like presentation

Important:

- Automatic background removal may require an external service, on-device ML model, or manual upload workflow
- This should not be treated as a simple UI-only feature

---

### Option C: Cutout + Custom Background

```text
背景を選ぶ
```

Behavior:

- Remove the photo background
- User chooses a display background
- The app displays the sneaker cutout over the selected background

Possible backgrounds:

- Plain white
- Museum black
- Sneaker box wall
- Transparent case
- Wood shelf
- User-selected image
- Brand color style

Use case:

- Better Collection screen appearance
- Personalized display shelves
- SNS sharing in future versions

---

## 3. Recommended MVP Implementation

Do not implement full automatic background removal immediately.

### MVP Step 1

Implement display mode metadata only.

Add photo display mode:

```text
original
cutout
custom_background
```

For now:

- `original` works normally
- `cutout` can be prepared but disabled or marked as future
- `custom_background` can use preset backgrounds only after cutout support exists

### MVP Step 2

Allow the user to choose:

```text
写真のまま
```

This remains the default.

### MVP Step 3

Add visual placeholders for future modes:

```text
切り抜き（準備中）
背景を選ぶ（準備中）
```

This lets the UX direction be fixed without breaking current photo registration.

---

## 4. Data Model Direction

The existing `photos` table stores:

- id
- shoe_id
- photo_type
- file_path
- display_order
- created_at

Future columns should be added when implementing this feature:

```text
display_mode TEXT NOT NULL DEFAULT 'original'
processed_file_path TEXT
background_type TEXT
background_value TEXT
```

### Field Meaning

#### display_mode

```text
original
cutout
custom_background
```

#### processed_file_path

Path to the processed transparent PNG or composited image.

#### background_type

```text
none
preset
color
image
```

#### background_value

Preset name, color code, or background image path.

---

## 5. UI Flow

### Photo Registration Flow

```text
Select Photo
↓
Preview Photo
↓
Choose Display Style
  - 写真のまま
  - 切り抜き
  - 背景を選ぶ
↓
Save
```

### Default

Default selection must be:

```text
写真のまま
```

Reason:

- Fast
- Safe
- No processing failure
- Preserves original collection memory

---

## 6. Collection Screen Display

Collection screen should eventually support a photo-first display.

If `display_mode == original`:

- Show original image

If `display_mode == cutout`:

- Show transparent sneaker over default app background

If `display_mode == custom_background`:

- Show transparent sneaker over selected background

---

## 7. Background Removal Strategy

Automatic background removal is not part of the immediate MVP unless a reliable method is selected.

Possible approaches:

### Approach A: External API

Pros:

- Best quality
- Easier implementation

Cons:

- Cost
- Requires internet
- Privacy concerns
- Not aligned with offline-first concept

### Approach B: On-device ML

Pros:

- Offline
- Better privacy

Cons:

- More complex
- App size may increase
- Quality may vary

### Approach C: Manual Preprocessing Outside App

Pros:

- Lowest development cost
- User can import already-cutout PNG

Cons:

- Less convenient
- Not beginner-friendly

Recommended short-term approach:

```text
Support imported transparent PNG first.
```

Then later consider automatic cutout.

---

## 8. Priority

### Priority 1

Support photo display mode concept in specification.

### Priority 2

Keep original photo mode stable.

### Priority 3

Allow imported transparent PNG to be displayed cleanly.

### Priority 4

Add preset backgrounds for transparent PNG display.

### Priority 5

Investigate automatic background removal.

---

## 9. Definition of Done

This feature is complete when:

- User can choose how the photo should be displayed
- Original photo mode remains reliable
- Transparent PNG photos display properly
- Custom backgrounds can be selected for transparent photos
- Automatic cutout has a clearly selected technical approach before implementation
