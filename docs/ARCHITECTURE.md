SoleMuseum Architecture v1.0

Overview

SoleMuseum is a Flutter application designed to collect, record, and exhibit sneaker collections.

Architecture goals:

- Simple
- Maintainable
- Offline-first
- Easy to extend

---

Technology Stack

Framework

Flutter

Language

Dart

State Management

Riverpod

Database

SQLite

Storage

Local Device Storage

Navigation

Flutter Navigation

---

Architectural Principles

1. Offline First
2. Local Data Ownership
3. Simple CRUD Before Advanced Features
4. Museum Experience Over Marketplace Features

---

Project Structure

lib/

core/

data/

- database/
- models/
- repositories/

features/

- collection/
- photos/
- wear_logs/
- home/
- settings/

shared/

- widgets/
- providers/
- theme/

---

Data Flow

UI

↓

Provider

↓

Repository

↓

Database

↓

Repository

↓

Provider

↓

UI

---

Database Design

brands

Stores sneaker brands.

Examples:

- Nike
- Jordan
- adidas
- New Balance

---

shoes

Stores sneaker collection data.

Examples:

- model name
- size
- color
- purchase information
- notes

---

photos

Stores sneaker photo metadata.

Photo files are stored locally.

Database stores only file paths.

---

wear_logs

Stores wear history.

Examples:

- date worn
- notes

---

State Management

Riverpod Providers

Examples:

- brandsProvider
- shoesProvider
- shoeByIdProvider
- photosByShoeIdProvider
- mainPhotoProvider

---

Repository Layer

Repositories isolate database access.

Examples:

- BrandRepository
- ShoeRepository
- PhotoRepository

Benefits:

- Easier testing
- Easier migration
- Cleaner UI code

---

Photo Storage

Photo files are stored in:

solemuseum/
photos/
shoe_id/

Example:

solemuseum/photos/15/

Database stores:

- file_path
- photo_type

Only.

---

Version Roadmap

Database Version 1

- brands
- shoes

---

Database Version 2

- photos

---

Database Version 3

- wear_logs

---

Security Principles

No user account required.

No cloud dependency required.

User owns all collection data.

---

Future Expansion

Potential future features:

- JSON Backup
- Cloud Sync
- Firebase
- Web Version
- Collection Sharing

These features must not affect offline functionality.

---

Definition of Success

A collector can:

1. Register sneakers
2. Add photos
3. Record wear history
4. Browse collection
5. Backup collection

Without requiring an internet connection.
