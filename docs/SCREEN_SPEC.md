SoleMuseum Screen Specification v1.0

Purpose

Define all screens included in SoleMuseum v1.0.

This document specifies screen responsibilities, UI elements, and navigation behavior.

---

Screen List

Home

Purpose:

Museum dashboard.

Status:

Sprint5

---

Collection

Purpose:

Browse sneaker collection.

Status:

Sprint2

---

Shoe Detail

Purpose:

View sneaker information and photos.

Status:

Sprint2 + Sprint3

---

Shoe Form

Purpose:

Register and edit sneakers.

Status:

Sprint2

---

Settings

Purpose:

Application settings.

Status:

Sprint1

---

Home Screen

Purpose

Provide an overview of the collection.

---

Sections

Collection Summary

Display:

- Total pairs
- Favorite pairs
- Brands owned

---

Recently Added

Display:

- Latest registered sneakers

---

Recently Worn

Display:

- Latest wear logs

---

MY TOP 5

Display:

- User selected featured sneakers

---

Actions

- Open Collection
- Open Detail

---

Collection Screen

Purpose

Display all sneakers.

---

Layout

Grid Layout

Default:

2 columns

---

Card Content

Photo

Main photo

Fallback:

Placeholder

---

Information

Display:

- Brand
- Model
- Favorite status

Optional:

- Size
- Color

---

Actions

Tap card:

Open Detail

---

Shoe Detail Screen

Purpose

Display sneaker information.

---

Header

Display:

- Model Name
- Favorite Button
- Edit Button
- Delete Button

---

Main Photo

Display:

- Main photo

Fallback:

Photo placeholder

---

Gallery

Display:

- Gallery photos
- Box photos

---

Information Section

Display:

- Brand
- Model
- Size
- Color
- Purchase Date
- Purchase Price
- Purchase Store
- Memo
- Created Date
- Updated Date

---

Actions

Add Main Photo

Source:

Gallery

---

Add Gallery Photo

Source:

Gallery

---

Add Box Photo

Source:

Gallery

---

Edit Sneaker

Open Shoe Form

---

Delete Sneaker

Show confirmation dialog

---

Shoe Form Screen

Purpose

Create and edit sneaker records.

---

Fields

Required:

- Brand
- Model Name

Optional:

- Size
- Color
- Purchase Date
- Purchase Price
- Purchase Store
- Memo
- Favorite

---

Actions

Save

Validate and save.

Cancel

Return without saving.

---

Settings Screen

Purpose

Application preferences.

---

Current Features

Theme Mode

- Light
- Dark
- System

---

Future Features

Backup

Sprint6

Export

Sprint6

Import

Sprint6

---

Navigation

Bottom Navigation

Tabs:

1. Home
2. Collection
3. Settings

---

Floating Action Button

Visible:

- Home
- Collection

Hidden:

- Settings

Action:

Open Shoe Form

---

Empty States

Collection

Message:

No sneakers registered.

Action:

Register first sneaker.

---

Photos

Message:

No photos available.

Action:

Add photo.

---

Loading States

Every screen must support:

- Loading
- Empty
- Error
- Success

---

Definition of Done

A screen is complete when:

- UI implemented
- Navigation works
- Loading state exists
- Empty state exists
- Error state exists
- Matches this specification