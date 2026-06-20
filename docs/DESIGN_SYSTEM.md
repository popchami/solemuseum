SoleMuseum Design System v1.0

Overview

SoleMuseum is a digital museum for sneaker collections.

It is not a marketplace.

It is not a social network.

It is not an investment tracking application.

Its purpose is to help users collect, record, and exhibit their sneaker collections.

Tagline

Collect.
Record.
Exhibit.

---

Brand

Brand Concept

SoleMuseum is a digital museum that preserves sneaker collections.

Users do not simply own sneakers.

Users archive and exhibit them.

Brand Keywords

Required

- Museum
- Archive
- Premium
- Minimal
- Elegant

Forbidden

- Flashy
- SNS-style
- Marketplace-style
- Gamified UI

---

Design Principles

Collection First

Show the collection before showing data.

Photo First

Photos are more important than text.

Museum Experience

Every screen should feel like a museum experience.

Quiet Premium

Premium quality should be expressed through space and restraint.

Offline First

The collection belongs to the user.

---

Color System

Primary

Museum Black

"#111111"

Secondary

Archive Gray

"#6B7280"

Accent

Gallery Gold

"#C8A96B"

Background

Ivory White

"#FAFAF8"

Surface

White

"#FFFFFF"

Error

"#D32F2F"

---

Typography

Display Large

32px Bold

Headline

28px SemiBold

Title

18px Medium

Body

16px Regular

Caption

12px Regular

---

Layout System

Grid

8dp Grid System

Spacing

- 4dp
- 8dp
- 16dp
- 24dp
- 32dp

Radius

- 12dp
- 16dp
- 24dp

---

Navigation

Bottom Navigation

Tabs

- Home
- Collection
- Settings

No additional root navigation items are allowed in v1.0.

---

Home Screen

Purpose

Museum Entrance Hall

Structure

1. Header
2. Featured Exhibit
3. Statistics
4. Recent Gallery

Header

Title:

SoleMuseum

Tagline:

Collect. Record. Exhibit.

Height:

120dp

Featured Exhibit

Displays the latest sneaker.

Large hero image.

Primary visual element of the Home screen.

Statistics

- Total Shoes
- Brands
- Recently Added

Recent Gallery

Latest six images.

3 columns × 2 rows.

---

Collection Screen

Purpose

Museum Gallery

Structure

1. Header
2. Search
3. Brand Filter
4. Collection Grid

Grid

Phone

2 Columns

Tablet

3 Columns

Shoe Card

Content

- Photo
- Model Name
- Brand
- Archive Number

Example

Air Jordan 1

Nike

SM-0012

Important Rule

Do not display:

- Notes
- Purchase Store
- Price
- Size

inside collection cards.

---

Shoe Detail Screen

Purpose

Museum Exhibit

Structure

1. Hero Image
2. Model Information
3. Information Card
4. Notes
5. Gallery

Hero Image

Height:

320dp

Ratio:

4:3

Radius:

24dp

Information

- Brand
- Model
- Size
- Purchase Date
- Archive Number
- Created Date

Notes

Maximum:

500 characters

Line breaks must be preserved.

Gallery

3-column grid.

Fullscreen preview supported.

---

Registration Screen

Purpose

Archive Registration

Fields

Required

- Brand
- Model Name

Optional

- Size
- Purchase Date
- Notes
- Photos

Save Button

Label:

Add To Collection

---

Archive Number

Every sneaker receives an archive number.

Format:

SM-0001
SM-0002
SM-0003

Archive numbers are unique.

---

Photography Guidelines

Recommended

- Side Profile
- Three Quarter View
- Clean Background
- Natural Light

Avoid

- Dark Images
- Heavy Shadows
- Cluttered Backgrounds
- Social Media Screenshots

---

Empty States

Collection

Title:

Your Museum Is Empty

Subtitle:

Add Your First Exhibit

Generic Empty State

Title:

Your Museum Awaits.

Subtitle:

Start your collection today.

---

App Icon

Concept

Sneaker archived inside a display case.

Colors

Background:

Museum Black

Frame:

Gallery Gold

Sneaker:

White

Style

Minimal

Premium

Museum-inspired

---

Splash Screen

Background

Museum Black

Center

Logo

Bottom

Collect. Record. Exhibit.

Duration

1200ms

Fade

300ms

---

Dark Mode

Background

#121212

Surface

#1E1E1E

Text

#FFFFFF

Accent

Gallery Gold

---

Accessibility

Minimum Tap Target

48dp

Minimum Text Size

12px

Contrast

WCAG AA

Requirement

Dark Mode support is mandatory.

---

Product Boundaries

SoleMuseum Is

- Collection Archive
- Collection Record
- Collection Exhibition

SoleMuseum Is Not

- Marketplace
- Social Network
- Price Tracker
- Investment Tool
- Authentication Service

---

Features Excluded From v1.0

Marketplace

Not allowed.

Social Features

Not allowed.

Cloud Sync

Not allowed.

Firebase

Not allowed.

AI Authentication

Not allowed.

---

Data Model

Brand

- id
- name

Shoe

- id
- brandId
- modelName
- size
- purchaseDate
- notes
- archiveNumber
- createdAt

Photo

- id
- shoeId
- path
- createdAt

WearHistory

- id
- shoeId
- wornDate
- memo
- createdAt

---

Future Expansion

Sprint 4

Wear History

- Wear Count
- Last Worn
- Wear Timeline

Sprint 5

Statistics

Sprint 6

Cloud Sync

Not included in v1.0.

---

Design Tokens

Colors

Museum Black

#111111

Gallery Gold

#C8A96B

Archive Gray

#6B7280

Ivory White

#FAFAF8

Surface White

#FFFFFF

Spacing

4

8

16

24

32

Radius

12

16

24

Animation

Fast: 150ms

Normal: 300ms

Splash: 1200ms

---

Definition of Success

When users open SoleMuseum, they should feel:

"I am viewing my collection."

Not:

"I am managing my shoes."